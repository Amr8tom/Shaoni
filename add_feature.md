Rule: outer layers depend on inner layers, never the reverse.
`presentation` imports `domain`. `data` imports `domain`. `domain` imports nothing.

---

## Two patterns the whole app relies on (read this once)

### Pattern 1 — Service code → Widget dispatch

A request's `serviceCode` (e.g. `'car.permission'`) decides which widget renders it.
The same `serviceCode` is keyed in **three** places. Adding a new service = add one
`case` in each of these three files:

| File | Purpose |
|---|---|
| `GetRequestDetailsWidget` | Picks the details widget to show |
| `UpdateRequestButton`     | Decides which create/edit route to push |
| `EditCubit.editRequest()` | Calls the matching `_get{Feature}Edit()` method |

```dart
switch (serviceCode) {
  case 'study.request':     return const StudyRequestDetailsWidget();
  case 'car.permission':    return const CarPermissionDetailsWidget();
  // add your new case here ↑
}
```

### Pattern 2 — Enums everywhere, raw strings nowhere

The cubit uses a `Status` enum + extension getters so UI compares to typed
booleans, not strings.

```dart
if (state.isCreateLoaded) { ... }     // ✅
if (state.status == "loaded") { ... } // ❌
```

The same for stages coming from the API — `RequestStatusEnum` (new / managerApproval /
hrApproval / done / rejected) maps service-specific tech names to a unified UI status.

If your IDE marks the comparison red, you mistyped. Strings would let typos slip.

---

## File checklist for a new feature `Xxx`

### 1) Domain
- `domain/entity/xxx/create_xxx_response.dart` — response entity (Equatable, no JSON).
- `domain/entity/xxx/xxx_type.dart` etc — one per dropdown lookup.
- `domain/use_cases/xxx/create_xxx_use_case.dart` — `CreateXxxParams { toMap() }`.
- `domain/use_cases/xxx/update_xxx_use_case.dart` — wraps `CreateXxxParams + requestId`.
- `domain/use_cases/xxx/get_xxx_types_use_case.dart` — one per lookup, `UseCase<List<T>, NoParams>`.
- `domain/repository/repository.dart` — add an abstract method per use case.

### 2) Data
- `data/model/xxx/xxx_type_model.dart` — extends entity, adds `fromJson` / `toJson`.
- `data/data_sources/remote_data_sources.dart` — add the network calls.
  - `getData` / `postData` → return body directly → `fromJson(response)`.
  - `putData` → returns `Response`, use `response.data`.
  - List parsing defensive: `response is List ? response : response['data'] as List`.
- `data/repositories/repository.dart` — implement every abstract method.
  Wrap with `_networkInfo.isConnected` and return `Either<Failure, T>`.
- `core/constants/api_constants.dart`:
```dart
  static const String createXxx     = '$baseUrl/Xxx/create';
  static const String updateXxx     = '$baseUrl/Xxx/update/'; // trailing slash, id appended at call site
  static const String getXxxEdit    = '$baseUrl/Xxx/edit/';
```

### 3) Presentation
- `presentation/controller/xxx/xxx_cubit.dart` + `xxx_state.dart` (part file).
  - Load all lookups in the constructor via `Future.wait([...])`.
  - `createRequest()`, `updateRequest({required int requestId})`, `deleteRequest()` (clears controllers).
  - Resolve dropdown display-name → id via `selectedXxxId` getters.
  - Dispose every controller in `close()`.
- Status enum required keys:
  `initial, lookupsLoading, lookupsLoaded, lookupsError, createLoading, createLoaded, createError, updateLoading, updateLoaded, updateError`.
- `presentation/xxx/create_xxx_form.dart` — accepts `int? requestId`, exposes
  `bool get _isEditMode => requestId != null`.
  - AppBar title: `_isEditMode ? S.current.editRequest : S.current.createRequest`.
  - Success dialog: `_isEditMode ? requestUpdatedSuccessfully : requestSentSuccessfully`.
  - Submit button: `_isEditMode ? controller.update(requestId: requestId!) : controller.create()`.
- `details_and_edit_for_requests/presentation/widgets/xxx_request_details_widget.dart`
  - Use `Skeletonizer(enabled: state.isLoading, child: ...)`.
  - Show key entity fields with `OrderTextCard`s.
  - Add to the `GetRequestDetailsWidget` switch.

### 4) Edit/Manager flow
- `domain/use_cases/get_xxx_edit_use_case.dart` — params: `requestId, note, editReasons`.
- Repository interface + impl: add `getXxxEdit`.
- Remote datasource: `_dio.putData('${URL.getXxxEdit}${params.requestId}', body: params.toMap())`.
- `EditCubit.editRequest()`: add `case 'xxx.service.code':` → `_getXxxEdit()`.

### 5) Service locators
`request_service_locator.dart`:
```dart
serviceLocator.registerLazySingleton<CreateXxxUseCase>(() => CreateXxxUseCase(serviceLocator()));
serviceLocator.registerLazySingleton<UpdateXxxUseCase>(() => UpdateXxxUseCase(serviceLocator()));
serviceLocator.registerLazySingleton<GetXxxTypesUseCase>(() => GetXxxTypesUseCase(serviceLocator()));
// register every lookup use case
serviceLocator.registerFactory<XxxCubit>(() => XxxCubit(sl(), sl(), sl(), sl()));
```

`my_requests_service_locator.dart`:
```dart
serviceLocator.registerLazySingleton<GetXxxEditUseCase>(() => GetXxxEditUseCase(serviceLocator()));
// then bump EditCubit factory arg count
```

Rule: **use cases = LazySingleton, cubits = Factory.** Never the other way.

### 6) Navigation
`route_names.dart`:
```dart
static const String createXxxRoute = 'create-xxx-route';
```

`routes.dart`:
```dart
case DRoutesName.createXxxRoute:
  final args = settings.arguments as Map<String, dynamic>?;
  final int? requestId = args?['requestId'] as int?;
  return PageTransition(
    child: CreateXxxForm(requestId: requestId),
    type: PageTransitionType.rightToLeft,
    settings: settings,
  );
```

Wire into the dispatch widgets:
- `UpdateRequestButton`: add `case 'xxx.service.code':` → `context.pushNamed(DRoutesName.createXxxRoute, arguments: {'requestId': int.tryParse(requestID)})`.
- `GetRequestDetailsWidget`: add `case 'xxx.service.code':` → `const XxxRequestDetailsWidget()`.

### 7) Localization
- Add every new key to **both** `lib/l10n/intl_en.arb` and `intl_ar.arb`.
- Run `flutter pub run intl_utils:generate`.
- Confirm the new getter shows up in `lib/generated/l10n.dart`.

---

## Style rules (non-negotiable)

- **Colors** → `ColorRes.xxx` only. Never `Color(0xFF…)` or `Colors.red` in widgets.
- **Sizes / padding / radius** → `AppSizes.xxx` only. Never raw numbers.
- **Spacing** → `Sizer(width:, height:)` instead of `SizedBox`.
- **Strings** → `S.current.xxx` only. Both Arabic and English required.
- **Text styles** → start from `Theme.of(context).textTheme.X?.copyWith(...)`. Never build a raw `TextStyle`.
- **App bar** → `DAppBar(title: …, showBackArrow: true)`. Never `AppBar(...)`.
- **Buttons** → `DButton(variant: …, size: …)`. Never raw `ElevatedButton`.
- **Navigation** → `context.pushNamed(DRoutesName.xxx)`. Never `Navigator.of(context).pushNamed('literal-string')`.
- **One class per file.** Widgets ≥ 30 lines or reused twice → extract.
- **Controllers live in the cubit**, not in `StatefulWidget`. Disposed in `close()`.

---

## Sanity check before running

- [ ] Every repository abstract method has an implementation.
- [ ] Use cases registered as `LazySingleton`, cubit as `Factory`.
- [ ] Cubit factory arg count matches its constructor.
- [ ] `EditCubit` factory arg count updated when adding a new edit use case.
- [ ] Service code string matches **exactly** in `EditCubit`, `UpdateRequestButton`, `GetRequestDetailsWidget`.
- [ ] `putData` → `response.data`, `getData`/`postData` → response directly.
- [ ] Arabic + English keys exist for every new string.
- [ ] `flutter pub run intl_utils:generate` was run after editing ARB files.

---

## When in doubt

Copy `car_permission` end-to-end (entity → model → use case → cubit → screen → routes → service locator).
Rename `car` → your feature. Fill in the API. Done.