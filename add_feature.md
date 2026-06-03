# Feature Implementation Guide

Rule: outer layers depend on inner layers, never the reverse.
`presentation` imports `domain`. `data` imports `domain`. `domain` imports nothing.

---

## 1. The Dispatch Pattern (CRITICAL)

A request's backend `serviceCode` is stored as a `ServiceCode` enum value before the app compares, routes, categorizes, renders details, or edits the request.

**Never compare raw service-code strings in feature logic.** Convert once:

```dart
final serviceCode = ServiceCode.fromCode(service.nameEn);
```

Then switch/compare with enum values:

```dart
switch (ServiceCode.fromCode(serviceCode)) {
  case ServiceCode.carPermission:
    return const CarPermissionDetailsWidget();
  case ServiceCode.studyRequest:
    return const StudyRequestDetailsWidget();
  default:
    return const Sizer();
}
```

### 1.1 Source of Truth

| File | Purpose |
|---|---|
| `core/constants/service_codes.dart` | All canonical backend service codes as `ServiceCode` enum values |
| `core/routing/service_route_resolver.dart` | Converts `ServiceCode` to app routes |
| `details_and_edit_for_requests/presentation/helpers/get_request_details_widget.dart` | Converts `ServiceCode` to details widgets |
| `details_and_edit_for_requests/presentation/controller/edit/edit_cubit.dart` | Converts `ServiceCode` to manager-edit use cases |
| `details_and_edit_for_requests/domain/enums_and_extentions/request_enums.dart` | Converts `ServiceCode + techName` to `RequestStatusEnum` |
| `services/domain/entity/services_names.dart` | Categorizes services using `List<ServiceCode>` |

### 1.2 Add The Service Code

Add the new backend code to `ServiceCode`:

```dart
enum ServiceCode {
  carPermission('car.permission'),
  studyRequest('study.request'),
  loan('hr.loan'),
  xxxRequest('xxx.service.code');

  final String code;
  const ServiceCode(this.code);

  static ServiceCode? fromCode(String? value) {
    final code = value?.toLowerCase().trim();
    if (code == null || code.isEmpty) return null;

    for (final serviceCode in ServiceCode.values) {
      if (serviceCode.code == code) return serviceCode;
    }
    return null;
  }
}
```

Use canonical API codes only. For example:

```dart
ServiceCode.startWork.code          // start.work
ServiceCode.idRenewalRequest.code   // id.renewal.request
```

Do **not** use old internal aliases. Always copy the canonical value from the backend/API and put it in `ServiceCode`.

### 1.3 Route Dispatch

Routes stay centralized in `core/routing`. Do not put route names in widgets.

Add a create route in `ServiceRouteResolver.createRouteFor` only if the feature has a real screen:

```dart
static String createRouteFor(String? serviceCode) {
  switch (ServiceCode.fromCode(serviceCode)) {
    case ServiceCode.carPermission:
      return DRoutesName.createCarPermissionRoute;
    case ServiceCode.xxxRequest:
      return DRoutesName.createXxxRoute;
    case null:
      return DRoutesName.noDataRoute;
    default:
      return DRoutesName.noDataRoute;
  }
}
```

Use `catalogRouteFor` only for catalog-specific exceptions:

```dart
static String catalogRouteFor(String? serviceCode) {
  switch (ServiceCode.fromCode(serviceCode)) {
    case ServiceCode.exitPermission:
      return DRoutesName.requestCertainService;
    case ServiceCode.attendanceUpdate:
      return DRoutesName.missingAttendanceHistory;
    default:
      return createRouteFor(serviceCode);
  }
}
```

Use `updateRouteFor` only for update-specific exceptions:

```dart
static String updateRouteFor(String? serviceCode) {
  switch (ServiceCode.fromCode(serviceCode)) {
    case ServiceCode.exitPermission:
      return DRoutesName.requestCreateDetails;
    case ServiceCode.attendanceUpdate:
      return DRoutesName.createAttendanceRoute;
    default:
      return createRouteFor(serviceCode);
  }
}
```

Widgets should call the resolver directly:

```dart
onTap: () => context.pushNamed(
  ServiceRouteResolver.catalogRouteFor(service.nameEn),
)
```

```dart
onTap: () => context.pushNamed(
  ServiceRouteResolver.updateRouteFor(serviceType),
  arguments: {'requestId': int.tryParse(requestID)},
)
```

### 1.4 Details Widget Dispatch

Add only the enum case for the new details widget:

```dart
Widget getRequestDetailsWidget({required String serviceCode}) {
  switch (ServiceCode.fromCode(serviceCode)) {
    case ServiceCode.xxxRequest:
      return const XxxRequestDetailsWidget();
    default:
      return const Sizer();
  }
}
```

### 1.5 Manager Edit Dispatch

Add only supported manager-edit services to `EditCubit.editRequest()`:

```dart
switch (ServiceCode.fromCode(serviceCode)) {
  case ServiceCode.xxxRequest:
    await _getXxxEdit(requestId: requestId);
    break;
  default:
    emit(state.copyWith(
      status: EditStatus.error,
      errorMessage: 'Edit not supported for service: $serviceCode',
    ));
}
```

### 1.6 Service Categorization

Categorize with enum values, not strings:

```dart
static List<ServiceCode> hrServiceKeys = [
  ServiceCode.carPermission,
  ServiceCode.xxxRequest,
];
```

Then compare by parsed enum:

```dart
final serviceCode = ServiceCode.fromCode(service.nameEn);

if (ServicesNames.hrServiceKeys.contains(serviceCode)) {
  hrServices.add(service);
}
```

---

## 2. File Checklist for New Feature `Xxx`

### 2.1 Domain Layer
- `domain/entity/xxx/create_xxx_response.dart` — response entity (Equatable, no JSON).
- `domain/entity/xxx/xxx_type.dart` etc — one per dropdown lookup.
- `domain/use_cases/xxx/create_xxx_use_case.dart` — `CreateXxxParams { toMap() }`.
- `domain/use_cases/xxx/update_xxx_use_case.dart` — wraps `CreateXxxParams + requestId`.
- `domain/use_cases/xxx/get_xxx_types_use_case.dart` — one per lookup, `UseCase<List<T>, NoParams>`.
- `domain/repository/repository.dart` — add an abstract method per use case.
  - **Note:** For HR features, use the shared `HRServicesRepository`.

### 2.2 Data Layer
- `data/model/xxx/xxx_type_model.dart` — extends entity, adds `fromJson` / `toJson`.
- `data/data_sources/remote_data_sources.dart` — add the network calls.
  - **Note:** For HR features, use the shared `HRServicesRemoteDataSources`.
- `data/repositories/repository.dart` — implement every abstract method.
- `core/constants/api_constants.dart`:
```dart
  static const String createXxx     = '$baseUrl/Xxx/create';
  static const String updateXxx     = '$baseUrl/Xxx/update/'; // trailing slash
  static const String getXxxEdit    = '$baseUrl/Xxx/edit/';
```

#### DioHelper Rules:
- `getData` / `postData` → returns `response` directly. Use `XxxModel.fromJson(response)`.
- `putData` → returns `Response` object. Use `XxxModel.fromJson(response.data as Map<String, dynamic>)`.
- List parsing: `final List data = response is List ? response : response['data'] as List;`.

### 2.3 Presentation Layer
- `presentation/controller/xxx/xxx_cubit.dart` + `xxx_state.dart` (part file).
  - Load all lookups in the constructor.
  - `createRequest()`, `updateRequest({required int requestId})`, `deleteRequest()` (clears controllers).
  - Use `_localizedName(ar, en)` helper for dropdown display.
  - Dispose every controller in `close()`.
- `presentation/xxx/create_xxx_form.dart` — accepts `int? requestId`.
  - AppBar title: `requestId != null ? S.current.editRequest : S.current.createRequest`.
  - Submit button: `requestId != null ? controller.update(requestId: requestId!) : controller.create()`.
- `details_and_edit_for_requests/presentation/widgets/xxx_request_details_widget.dart`
  - Use `Skeletonizer(enabled: state.isLoading, child: ...)`.
  - Show key fields with `OrderTextCard`s.

### 2.4 Edit/Manager Flow
- `domain/use_cases/get_xxx_edit_use_case.dart` — params: `requestId, note, editReasons`.
- `EditCubit.editRequest()`:
  - Add `case ServiceCode.xxxRequest:` → `await _getXxxEdit(requestId: requestId);`.
  - Implement private `_getXxxEdit` method mapping `editNotesController.text` to params.

---

## 3. Service Locators

`request_service_locator.dart` (or `HRServiceLocator` for HR):
- **Use cases** = `registerLazySingleton`.
- **Cubits** = `registerFactory`.
- Update `EditCubit` factory when adding a new edit use case.

---

## 4. Localization & Style

### 4.1 Declarative Main Screen
The main UI screen (e.g., `CreateXxxScreen`) must be **declarative** and contain **no imperative logic**.
- **One Stateless Class**: The screen should be a single `StatelessWidget`.
- **Section-Based Structure**: The `body` should only call section widgets (e.g., `ApplicantDataWidget()`, `XxxRequestDataWidget()`).
- **No Inline Implementation**: Every major section must be extracted into its own file in a `widget/` folder.
- **BlocProvider/Consumer**: Wrap the screen in a `BlocProvider` and use `BlocConsumer` for listener logic (dialogs, snacks) and builder logic (UI state).

### 4.2 Cubit-Driven Logic
**All logic must live in the Cubit.** The UI should only:
- Call methods on the controller (e.g., `controller.create()`).
- Read state from the Cubit to render.
- Pass controller properties (like `TextEditingController`) to form atoms.

### 4.3 Folder Structure for Presentation
```text
presentation/
├── controller/
│   └── xxx_cubit.dart
└── xxx/
    ├── widget/                 # Extract every section here
    │   ├── xxx_section_one.dart
    │   └── xxx_section_two.dart
    └── create_xxx_screen.dart   # The main declarative entry point
```

### 4.4 Localization
- Add keys to **both** `intl_en.arb` and `intl_ar.arb`.
- Run `flutter pub run intl_utils:generate`.

### 4.5 Non-Negotiable Style Rules
- **Colors**: `ColorRes.xxx` only.
- **Sizes**: `AppSizes.xxx` for padding, radius, icons, buttons, and fixed widget dimensions.
- **Spacing**: use `const Sizer(width: 8)` / `const Sizer(height: 8)` for empty gaps instead of `SizedBox`; never pass `.w`, `.h`, or `AppSizes` into `Sizer`.
- **Strings**: `S.current.xxx` only.
- **App Bar**: `DAppBar(title: ..., showBackArrow: true)`.
- **Buttons**: `DButton(variant: ..., size: ...)` or shared templates like `CreateDeleteButtons`.
- **Text Styles**: `Theme.of(context).textTheme.bodyLarge?.copyWith(...)`.
- **Controllers**: All `TextEditingController` instances live in the Cubit and are disposed in `close()`.

#### Spacing Examples:
- ✅ `const Sizer(height: 8)`
- ✅ `const Sizer(width: 12)`
- ❌ `const SizedBox(height: 8)`
- ❌ `Sizer(height: 8.h)`
- ❌ `Sizer(width: AppSizes.sm)`

#### Color Examples:
- ✅ `color: ColorRes.white`
- ✅ `color: ColorRes.primary`
- ❌ `color: Colors.white`
- ❌ `color: Color(0xFFE8B4A8)`

---

## 5. Final Sanity Check
- [ ] Added the canonical backend code to `ServiceCode`?
- [ ] Used canonical codes only? (`start.work`, `id.renewal.request`; never old aliases.)
- [ ] Added the create route to `ServiceRouteResolver.createRouteFor` if the service has a screen?
- [ ] Added catalog/update exceptions only when their route differs from the create route?
- [ ] Added details-widget dispatch with `ServiceCode.fromCode`?
- [ ] Added manager-edit dispatch with `ServiceCode.fromCode` only if edit is supported?
- [ ] Added service categorization using `List<ServiceCode>`?
- [ ] `putData` uses `response.data`?
- [ ] Use cases registered as Singletons, Cubits as Factories?
- [ ] Arabic + English translations exist?
- [ ] All controllers disposed?
