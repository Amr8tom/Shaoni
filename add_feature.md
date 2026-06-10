# Add Feature Guide

Use this guide when adding a new request/service feature to the Shaoni Flutter app.
It is written as an implementation contract for an AI agent or developer working in this codebase.

The project follows Clean Architecture:

```text
presentation -> domain
data         -> domain
domain      -> core/shared only
```

The domain layer is the app contract. The data layer adapts API/cache JSON into that contract. The presentation layer depends on domain contracts, not data-source details.

---

## 1. Non-Negotiable Rules

### 1.1 Do Not Change Backend Contracts Accidentally

- Do not change API endpoints, request keys, response keys, or integration behavior unless the task explicitly asks for it.
- Do not add, remove, rename, or reinterpret fields while creating entities or models.
- If a model did not have an entity before, create an entity with the same app-facing data:
  - Same public fields.
  - Same Dart types.
  - Same nullability.
  - Same required/optional constructor shape where possible.
  - Same Equatable props coverage.
- Any API-specific conversion belongs in `fromJson`, `toJson`, or params mapping, not in UI widgets.

### 1.2 Domain Must Never Depend On Data

Forbidden inside `lib/features/*/domain`:

- Imports from `data/model`, `data/models`, or `data/data_sources`.
- Return types ending in `Model`.
- JSON parsing, cache parsing, Dio, Response, SharedPreferences, or UI/localization dependencies.
- `props => throw UnimplementedError()`.

Domain repository methods and use cases return entities only:

```dart
Future<Either<Failure, CreateXxxResponse>> createXxx({
  required CreateXxxParams params,
});

Future<Either<Failure, List<XxxType>>> getXxxTypes({
  required NoParams params,
});
```

### 1.3 Models Are Data Adapters

Models live in `data/model` or `data/models`.

Use the current project pattern: model classes extend their matching entity when practical.

```dart
class XxxTypeModel extends XxxType {
  const XxxTypeModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
  });

  factory XxxTypeModel.fromJson(Map<String, dynamic> json) {
    return XxxTypeModel(
      id: json['id'],
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],
    );
  }

  Map<String, dynamic> toJson() {
    return toJsonFromEntity(this);
  }

  static Map<String, dynamic> toJsonFromEntity(XxxType entity) {
    return {
      'id': entity.id,
      'nameAr': entity.nameAr,
      'nameEn': entity.nameEn,
    };
  }
}
```

Avoid unsafe serializer casts:

```dart
// Bad
(item as XxxTypeModel).toJson()

// Good
XxxTypeModel.toJsonFromEntity(item)
```

For nested fields:

```dart
'request': entity.request == null
    ? null
    : RequestModel.toJsonFromEntity(entity.request!),
```

### 1.4 Presentation Uses Entities

- Cubits depend on use cases and entities, not models.
- Widgets render entities or simple view state, not data models.
- UI must not call `fromJson`, `toJson`, Dio, repositories, or raw cache APIs.
- UI text must be user-facing/localized; do not leave debug text in widgets.

### 1.5 No Debug Noise Or Dead Code

- Remove debug-only `print(...)` and temporary `debugPrint(...)`.
- Do not leave old commented-out code blocks.
- Keep only useful comments that explain current non-obvious behavior or structure large widgets/files.
- Important errors should flow through existing repository failure handling or cubit state, not prints.

---

## 2. Read Before You Edit

Before adding or refactoring a feature, inspect the nearest existing feature and the shared dispatch files.

Important source-of-truth files:

| Area | File |
|---|---|
| Service codes | `lib/core/constants/service_codes.dart` |
| Route dispatch | `lib/core/routing/service_route_resolver.dart` |
| Route names | `lib/core/routing/route_names.dart` |
| Router setup | `lib/core/routing/routes.dart` |
| API constants | `lib/core/constants/api_constants.dart` |
| Assets | `lib/core/constants/asset_resources.dart` (`AssetRes`) |
| HR service wiring | `lib/core/service_locator/request_service_locator.dart` |
| Request/details wiring | `lib/core/service_locator/my_requests_service_locator.dart` |
| Details widget dispatch | `lib/features/details_and_edit_for_requests/presentation/helpers/get_request_details_widget.dart` |
| Manager edit dispatch | `lib/features/details_and_edit_for_requests/presentation/controller/edit/edit_cubit.dart` |
| Request status mapping | `lib/features/details_and_edit_for_requests/domain/enums_and_extentions/request_enums.dart` |
| Service categorization | `lib/features/services/domain/entity/services_names.dart` |

Useful discovery commands:

```bash
rg -n "ServiceCode|ServiceRouteResolver|editRequest|getRequestDetailsWidget" lib
rg -n "class .*Model extends|toJsonFromEntity|fromJson" lib/features
rg -n "abstract class .*Repository|class .*UseCase|class .*Cubit" lib/features
```

### 2.1 Target Folder Arrangement

Use this structure for new feature work:

```text
lib/
├── common/                         # shared UI widgets/helpers only
├── core/                           # constants, routing, DI, networking, errors, theme, utilities
├── features/                       # vertical business features
│   └── <feature>/
│       ├── data/
│       │   ├── data_sources/
│       │   │   ├── local_data_sources.dart
│       │   │   └── remote_data_sources.dart
│       │   ├── model/
│       │   │   └── <flow_or_service>/
│       │   └── repositories/
│       │       └── repository.dart
│       ├── domain/
│       │   ├── entity/
│       │   │   └── <flow_or_service>/
│       │   ├── repository/
│       │   │   └── repository.dart
│       │   └── use_cases/
│       │       └── <flow_or_service>/
│       └── presentation/
│           ├── controller/
│           │   └── <flow_or_service>/
│           ├── <flow_or_service>/
│           │   ├── create_xxx_form.dart
│           │   └── widget/
│           └── widgets/
├── generated/                      # generated localization output
└── l10n/                           # ARB localization source files
```

Folder rules:

- `common/` is shared UI only.
- `core/` is app-wide infrastructure only.
- Feature-specific business code belongs under `features/<feature>`.
- Keep current project naming: `data/model`, `domain/entity`, `domain/repository`, `data/repositories`.
- Group large features by flow/service under each layer.
- Main screen/form files stay thin; every major section goes in its own file under the feature `widget/` folder.
- `widgets/` is only for widgets shared by multiple screens inside the same feature.
- Cubits stay under `presentation/controller`, not inside screen folders.
- Models/data sources stay in `data`, never in `domain` or `presentation`.

---

## 3. ServiceCode Dispatch Pattern

Backend service codes must be normalized once through `ServiceCode.fromCode`.
Never compare raw service-code strings in feature logic.

```dart
final serviceCode = ServiceCode.fromCode(service.nameEn);
```

Then compare enum values:

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

### 3.1 Add A Backend Code

Add the canonical backend value to `ServiceCode`.

```dart
enum ServiceCode {
  carPermission('car.permission'),
  studyRequest('study.request'),
  xxxRequest('xxx.service.code');

  final String code;
  const ServiceCode(this.code);
}
```

Use backend/API codes only:

```dart
ServiceCode.startWork.code
ServiceCode.idRenewalRequest.code
```

Do not introduce old aliases or display names as codes.

### 3.2 Add Routes Centrally

Routes stay in `core/routing`; widgets should not hardcode route names for service dispatch.

Add a create route only if the feature has a real screen:

```dart
static String createRouteFor(String? serviceCode) {
  switch (ServiceCode.fromCode(serviceCode)) {
    case ServiceCode.xxxRequest:
      return DRoutesName.createXxxRoute;
    case null:
      return DRoutesName.noDataRoute;
    default:
      return DRoutesName.noDataRoute;
  }
}
```

Use `catalogRouteFor` only when the catalog route differs from the create route.
Use `updateRouteFor` only when the update route differs from the create route.

Widgets should call the resolver:

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

### 3.3 Add Details Widget Dispatch

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

### 3.4 Add Manager Edit Dispatch

Add only services that really support manager edit:

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

### 3.5 Categorize Services With Enum Values

```dart
static List<ServiceCode> hrServiceKeys = [
  ServiceCode.carPermission,
  ServiceCode.xxxRequest,
];
```

```dart
final serviceCode = ServiceCode.fromCode(service.nameEn);

if (ServicesNames.hrServiceKeys.contains(serviceCode)) {
  hrServices.add(service);
}
```

### 3.6 Request Status and Stage Card

The request details screen shows a timeline of stages (e.g., Draft -> Manager Approval -> HR Approval). 
When adding a new feature, you must configure its stages in `lib/features/details_and_edit_for_requests/domain/enums_and_extentions/request_enums.dart`.

1. Open `request_enums.dart`.
2. Find `extension RequestStatusExtensionList on CurrentStatus`.
3. Inside `getRequestStatusEnumList`, add a `case` for your `ServiceCode` that returns the exact ordered list of stages for your feature.

```dart
case ServiceCode.xxxRequest:
  return const [
    RequestStatusEnum.draft,
    RequestStatusEnum.managerApproval,
    RequestStatusEnum.hrApproval,
    RequestStatusEnum.approved,
    RequestStatusEnum.rejected
  ];
```

The UI (`RequestStageCard`) automatically uses this list to render the stepper and determine the active step based on the current status of the request. Do NOT hardcode stage titles or indices inside the details widget.

---

## 4. New Feature Checklist

Use `Xxx` as the feature placeholder below.

### 4.1 Domain Layer

Create or update:

- `domain/entity/xxx/create_xxx_response.dart`
- `domain/entity/xxx/xxx_type.dart`
- `domain/use_cases/xxx/create_xxx_use_case.dart`
- `domain/use_cases/xxx/update_xxx_use_case.dart`
- `domain/use_cases/xxx/get_xxx_types_use_case.dart`
- `domain/repository/repository.dart`

Rules:

- Entities are immutable value objects and extend `Equatable`.
- Entities contain no JSON methods.
- Entity names do not end in `Model`.
- Use cases return `Either<Failure, Entity>` or `Either<Failure, List<Entity>>`.
- Params may expose `toMap()` when the existing feature pattern sends request bodies from params.
- For HR features, add methods to the shared `HRServicesRepository`.

Entity example:

```dart
class XxxType extends Equatable {
  final int id;
  final String nameAr;
  final String nameEn;

  const XxxType({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  @override
  List<Object?> get props => [id, nameAr, nameEn];
}
```

### 4.2 Data Layer

Create or update:

- `data/model/xxx/xxx_type_model.dart`
- `data/data_sources/remote_data_sources.dart`
- `data/repositories/repository.dart`
- `lib/core/constants/api_constants.dart`

Rules:

- Remote data source calls APIs only.
- Repository implementation catches/handles failures using the existing project pattern.
- Repository implementation returns entities to domain callers.
- Models parse API responses and serialize API/cache payloads.
- Use `toJsonFromEntity` for entity-shaped values.
- Do not serialize a domain entity by casting it to a model.

API constants example:

```dart
static const String createXxx = '$baseUrl/Xxx/create';
static const String updateXxx = '$baseUrl/Xxx/update/';
static const String getXxxEdit = '$baseUrl/Xxx/edit/';
```

Dio helper rules from the current project:

- `getData` and `postData` return the response payload directly. Use `XxxModel.fromJson(response)`.
- `putData` returns a `Response` object. Use `XxxModel.fromJson(response.data as Map<String, dynamic>)`.
- For list parsing, support the existing response shape:

```dart
final List data = response is List ? response : response['data'] as List;
```

### 4.3 Presentation Layer

Create or update:

- `presentation/controller/xxx/xxx_cubit.dart`
- `presentation/controller/xxx/xxx_state.dart`
- `presentation/xxx/create_xxx_form.dart`
- `presentation/xxx/widget/...`
- `details_and_edit_for_requests/presentation/widgets/xxx_request_details_widget.dart`

Rules:

- Main screen/form stays declarative.
- Main screen/form is a thin composition file: provider/listener/scaffold/scroll layout and calls to section widgets.
- Every major section lives in its own file under the feature `widget/` folder.
- Section widgets are public `StatelessWidget`s with const constructors wherever possible.
- Cubit owns all changing logic, state transitions, validation decisions, selected-value mapping, API/use-case calls, and `TextEditingController`s.
- Cubit loads dropdown/lookups through use cases.
- Cubit exposes `createRequest()`, `updateRequest({required int requestId})`, and cleanup/reset methods where needed.
- Dispose every controller in `close()`.
- UI only reads cubit state and calls cubit methods or simple cubit setters.
- UI must not contain business logic, repository calls, API calls, cache reads, JSON mapping, or service-code decisions.
- Details widgets render entities/current state and use existing shared cards/widgets.

Recommended form behavior:

```dart
final isEdit = requestId != null;

DAppBar(
  title: isEdit ? S.current.editRequest : S.current.createRequest,
  showBackArrow: true,
);
```

```dart
isEdit
    ? controller.updateRequest(requestId: requestId!)
    : controller.createRequest();
```

### 4.4 Edit And Details Flow

For manager edit support:

- Add a domain use case in `details_and_edit_for_requests/domain/use_cases`.
- Add data model parsing in `details_and_edit_for_requests/data/models`.
- Add repository and remote data-source methods.
- Register the use case in `my_requests_service_locator.dart`.
- Add the dependency and switch case in `EditCubit`.
- Add the details widget dispatch case.

Keep manager edit separate from create/update screens unless the route intentionally reuses the same form.

### 4.5 Service Locator

Use the existing registration pattern:

- Remote data sources: `registerLazySingleton`.
- Local data sources: `registerLazySingleton` when used.
- Repository implementations: `registerLazySingleton`.
- Use cases: `registerLazySingleton`.
- Cubits: `registerFactory`.

For HR features, update `HRServiceLocator` in `request_service_locator.dart`.
For request details/edit, update `my_requests_service_locator.dart`.

---

## 5. Localization And UI Style

### 5.1 Localization

- Add every user-facing string to both `intl_en.arb` and `intl_ar.arb`.
- Run:

```bash
flutter pub run intl_utils:generate
```

- Use `S.current.xxx` in UI.
- Do not put temporary English debug labels in production widgets.

### 5.2 Project UI Rules

- Colors: use `ColorRes.xxx`.
- Sizes: use `AppSizes.xxx` for padding, radius, icons, buttons, and fixed widget dimensions.
- Assets: use `AssetRes.xxx` from `asset_resources.dart`.
- Empty spacing: use `const Sizer(width: 8)` or `const Sizer(height: 8)`.
- Do not use `.w`, `.h`, or `AppSizes` inside `Sizer`.
- App bar: use `DAppBar(title: ..., showBackArrow: true)`.
- Buttons: use `DButton(...)` or shared templates like `CreateDeleteButtons`.
- Text styles: use `Theme.of(context).textTheme...copyWith(...)`.
- Controllers: store and dispose them in cubits, not widgets.

Spacing examples:

```dart
const Sizer(height: 8);
const Sizer(width: 12);
```

Avoid:

```dart
const SizedBox(height: 8);
Sizer(height: 8.h);
Sizer(width: AppSizes.sm);
```

---

## 6. Verification Commands

Run these before and after meaningful architecture or feature work.
Any remaining matches must be explained in the final report.

### 6.1 Domain Boundary

```bash
rg -n "import .*data/(model|models|data_sources)|Model\b" lib/features/*/domain
rg -n "Future<.*Model|Either<Failure, .*Model|List<.*Model|Model>" lib/features/*/domain
```

Expected result: no matches.

### 6.2 Unsafe Model Casts

```bash
rg -n "as [A-Za-z0-9_]+Model\??\)\?*\.toJson\(|as [A-Za-z0-9_]+Model\??\)" lib
rg -n "\.map\(\(.*\) => \(.* as [A-Za-z0-9_]+\).*toJson|\(.* as .*Model.*\)\.toJson|\(.* as .*Model\?\)\?\.toJson" lib
```

Expected result: no unsafe serializer casts. Use `XxxModel.toJsonFromEntity(entity)` instead.

### 6.3 Debug Noise And Old Commented Code

```bash
rg -n "\bprint\(|debugPrint\(" lib
rg -n "^\s*//\s*(return|if|else|for|while|switch|case|final|var|const|Text|Container|SizedBox|Sizer|Navigator|context\.|controller\.|await|setState|Bloc|Expanded|Row|Column|Padding|GestureDetector|TODO|print|debugPrint|serviceLocator\.register)" lib
```

Expected result: no debug prints and no old commented-out implementation blocks.

### 6.4 Format And Analyze

Format all changed Dart files:

```bash
dart format <changed dart files>
```

Then run:

```bash
flutter analyze --no-fatal-infos --no-fatal-warnings
```

Expected result: no analyzer issues.

---

## 7. Final Report Format

When finishing a feature or refactor, report:

- Files changed.
- New service code/routes/details/edit dispatch added.
- Domain entities and use cases added.
- Data models and API methods added.
- Service locator registrations added.
- Verification commands run and results.
- Any remaining search matches and why they are acceptable.

Do not claim the architecture is fixed unless the domain boundary searches and analyzer are clean.

---

## 8. Final Checklist

- [ ] Read the closest existing feature before editing.
- [ ] Added canonical backend code to `ServiceCode`.
- [ ] Added route names and route builder entries only when needed.
- [ ] Updated `ServiceRouteResolver` instead of hardcoding route names in widgets.
- [ ] Added details-widget dispatch with `ServiceCode.fromCode`.
- [ ] Added manager-edit dispatch only if edit is supported.
- [ ] Categorized services with `List<ServiceCode>`.
- [ ] Domain returns entities, never models.
- [ ] New entities match existing model fields/types/nullability exactly when created from old models.
- [ ] Models own `fromJson`, `toJson`, and `toJsonFromEntity`.
- [ ] No unsafe `(x as SomeModel).toJson()` serialization.
- [ ] Cubits and UI use entities/use cases only.
- [ ] Cubits own changing logic, state transitions, validation decisions, and controller values.
- [ ] UI only reads state and calls cubit methods or setters.
- [ ] Main screen/form is split into section widgets instead of one large file.
- [ ] Every major section has its own file under the feature `widget/` folder.
- [ ] Section widgets are public `StatelessWidget`s with const constructors where possible.
- [ ] Controllers live in cubits and are disposed.
- [ ] Arabic and English translations exist.
- [ ] No debug prints or old commented-out code.
- [ ] Changed Dart files formatted.
- [ ] `flutter analyze --no-fatal-infos --no-fatal-warnings` passes.
