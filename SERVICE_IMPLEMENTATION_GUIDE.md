# Shaoni Service Implementation Guide

Use this file before adding any new backend service/request flow to the Shaoni
Flutter app.

This guide is project-specific. It tells Codex, another AI agent, or a human
developer how to understand the existing codebase, what information must be
received from the product/API side, and exactly how to implement a new service
without breaking existing flows.

In this app, a "service" usually means one backend request type such as car
permission, loan request, salary transfer, ID renewal, study request, etc. A
service may live inside an existing feature group such as `human_resources`,
`salaries`, or `study&training`. Only create a brand-new top-level feature
folder when the service belongs to a new business area.

---

## 1. Required Input Before Coding

Do not start implementation until the service contract is clear. If anything is
missing, ask for it first or mark it as an assumption in the final report.

### 1.1 Service Identity

The user/API owner must provide:

- Service name in English.
- Service name in Arabic.
- Exact backend service code, for example `car.permission`.
- Which category the service belongs to:
  - Human resources
  - Salaries
  - Study and training
  - Leaves
  - Other/new category
- Whether the service appears in the services catalog.
- Whether the service appears in user requests, manager requests, kafeel
  requests, or all of them.
- Whether the service supports create, update, edit-by-manager, details, approve,
  reject, or only viewing.

### 1.2 APIs To Send For Each Service

Send the real API contract, not only screenshots.

For every endpoint, provide:

- HTTP method: `GET`, `POST`, `PUT`, `PATCH`, or `DELETE`.
- Full endpoint path after the base URL.
- Path params, query params, and body params.
- Required vs optional fields.
- Exact request body JSON sample.
- Exact success response JSON sample.
- Exact failure/validation response JSON sample.
- Whether the response is a raw object, `{ data: ... }`, `{ body: ... }`, or a
  list.
- Whether the endpoint requires auth headers.
- Whether attachments are base64 strings, file URLs, file IDs, or arrays.
- Whether field names are snake_case or camelCase.

Minimum API set for a normal request service:

```text
1. Create request API
2. Update request API, if edit/update is supported
3. Lookup APIs for dropdowns, if any
4. Edit/details API for pre-filling update forms, if any
5. Request details response inside Request/{id}/with-stages
6. Status/stage values for the request timeline
```

### 1.3 Details API Data

For details screens, send a full sample from:

```text
GET /Request/{requestId}/with-stages
```

The sample must include the relevant object inside `extraData`.

Example:

```json
{
  "extraData": {
    "carPermission": {
      "externalName": "CP000214",
      "carType": "Nissan",
      "carColor": "Purple",
      "carNumber": "123",
      "note": "",
      "state": "draft",
      "attachments": []
    }
  },
  "currentStatus": {
    "nameEn": "Applied",
    "techName": "applied"
  }
}
```

The `extraData` key name is critical. Do not guess it. Common mistakes:

- `startWork` vs `startWorking`
- `idDocument` vs `idRenewalRequest`
- `salaryRequest` vs `salaryTransfer`
- Array attachment vs string attachment
- `data` object vs direct object response

### 1.4 UI/Business Requirements

The user must clarify:

- Is this a create-only service, update service, manager-edit service, or all?
- Which fields are visible.
- Which fields are required.
- Which fields are read-only and filled from the logged-in user/session.
- Which fields use dropdown lookups.
- Which dropdown label should be shown in Arabic/English.
- Which ID should be sent to the API after selecting a dropdown label.
- Which fields are dates and required format.
- Which fields support attachments.
- What happens after success: show request number, pop screen, refresh list, etc.
- What buttons are needed: create, update, delete/clear, approve, reject.
- Empty/loading/error states.

### 1.5 If There Is No API Yet

If the UI must be built before APIs are ready:

- Still create domain entities, params, repository interface, use cases, cubit,
  and UI.
- Create a fake/local data source behind the repository interface.
- Keep fake data in the data layer only.
- Do not put dummy lists inside widgets.
- Do not change UI when real API arrives; only swap the data source/model mapping.

Example structure:

```text
domain:
  entity/xxx
  repository/xxx_repository.dart
  use_cases/xxx

data:
  data_sources/xxx_fake_data_source.dart
  repositories/xxx_repository_impl.dart
  model/xxx

presentation:
  controller/xxx
  xxx/create_xxx_form.dart
  xxx/widget/...
```

---

## 2. Read These Files Before Editing

Before implementing a service, inspect the closest existing service and these
shared files:

```text
lib/core/constants/service_codes.dart
lib/core/constants/api_constants.dart
lib/core/routing/routes.dart
lib/core/service_locator/request_service_locator.dart
lib/core/service_locator/salaries_service_locator.dart
lib/core/service_locator/study_training_service_locator.dart
lib/core/service_locator/my_requests_service_locator.dart
lib/features/services/domain/entity/services_names.dart
lib/features/details_and_edit_for_requests/domain/enums_and_extentions/request_enums.dart
lib/features/details_and_edit_for_requests/presentation/helpers/get_request_details_widget.dart
lib/features/details_and_edit_for_requests/presentation/controller/my_requests_cubit.dart
```

Then read the closest implemented service:

```text
Human resources:
  lib/features/human_resources/domain/use_cases/<service>/
  lib/features/human_resources/data/model/<service>/
  lib/features/human_resources/presentation/controller/<service>/
  lib/features/human_resources/presentation/<service>/

Salaries:
  lib/features/salaries/domain/use_cases/<service>/
  lib/features/salaries/data/model/<service>/
  lib/features/salaries/presentation/controller/<service>/
  lib/features/salaries/presentation/<service>/

Study and training:
  lib/features/study&training/domain/use_cases/<service>/
  lib/features/study&training/data/model/<service>/
  lib/features/study&training/presentation/controller/<service>/
  lib/features/study&training/presentation/<service>/
```

Useful commands:

```bash
rg -n "ServiceCode|ServicesNames|getRequestDetailsWidget|with-stages" lib
rg -n "class .*Cubit|class .*State|class .*UseCase|abstract class .*Repository" lib/features
rg -n "fromJson|toJsonFromEntity|as Map<String, dynamic>|as List" lib/features
```

---

## 3. Architecture Rules

Dependency direction:

```text
presentation -> domain
data         -> domain
domain      -> core/shared only
```

Rules:

- Domain returns entities, not models.
- Data sources return models.
- Repository implementation converts models to entities by returning them through
  entity types.
- Cubits call use cases only.
- Widgets call cubit methods only.
- UI never calls API, repository, cache, `fromJson`, or `toJson`.
- API-specific conversion stays in params, model, or data source mapping.
- Do not import `data/model`, `data/models`, or `data_sources` from domain.
- Do not use `props => throw UnimplementedError()`.
- Do not serialize entities with `(x as XxxModel).toJson()`. Use
  `XxxModel.toJsonFromEntity(x)`.

---

## 4. Standard Folder Placement

Use the existing folder style of the parent feature.

For HR services:

```text
lib/features/human_resources/
├── data/
│   ├── data_sources/remote_data_sources.dart
│   ├── data_sources/local_data_sources.dart
│   ├── model/<service>/
│   └── repositories/repository.dart
├── domain/
│   ├── entity/<service>/
│   ├── repository/repository.dart
│   └── use_cases/<service>/
└── presentation/
    ├── controller/<service>/
    └── <service>/
        ├── create_<service>_form.dart
        └── widget/
```

For salary services:

```text
lib/features/salaries/
├── data/
│   ├── data_sources/salaries_remote_data_source.dart
│   ├── data_sources/salaries_local_data_source.dart
│   ├── model/<service>/
│   └── repositories/salaries_repository_impl.dart
├── domain/
│   ├── entity/<service>/
│   ├── repository/salaries_repository.dart
│   └── use_cases/<service>/
└── presentation/
    ├── controller/<service>/
    └── <service>/
        ├── create_<service>_form.dart
        └── widget/
```

For request details/edit:

```text
lib/features/details_and_edit_for_requests/
├── data/
│   ├── data_sources/remote_data_sources.dart
│   ├── data_sources/local_data_sources.dart
│   └── models/
├── domain/
│   ├── entities/
│   └── use_cases/
└── presentation/
    ├── helpers/get_request_details_widget.dart
    ├── controller/my_requests_cubit.dart
    └── widgets/<service>_details_widget.dart
```

Screen rules:

- The main screen/form should be thin.
- Every major section goes in its own file under `widget/`.
- Prefer public `StatelessWidget` section widgets with `const` constructors.
- Use `StatefulWidget` only for local UI-only behavior that truly cannot live in
  the cubit.
- Cubit owns changing logic, validation decisions, selected-value mapping, API
  calls, and controllers.

---

## 5. Implementation Steps

### Step 1: Service Code And Category

Update the service code enum/source of truth.

Add the backend code exactly as provided by the API.

Then categorize it in:

```text
lib/features/services/domain/entity/services_names.dart
```

Never compare raw service-code strings in widgets. Normalize through the
existing service-code pattern.

### Step 2: API Constants

Add endpoints in:

```text
lib/core/constants/api_constants.dart
```

Use the exact backend path. Do not rename endpoints to look nicer if that hides
the backend contract.

### Step 3: Domain Layer

Create or update:

```text
domain/entity/<service>/
domain/use_cases/<service>/
domain/repository/repository.dart
```

Entity rules:

- Immutable fields.
- `Equatable`.
- No JSON methods.
- No API/cache/UI imports.
- Same app-facing field types as the response/model contract.

Params rules:

- Params may include `toMap()` if that is the current pattern for request bodies.
- Request body keys must match the API exactly.
- Do not make up defaults that can create wrong backend data.
- Session fields such as employee ID should be read in the cubit or injected
  session provider, then passed into params.

### Step 4: Data Layer

Create or update:

```text
data/model/<service>/
data/data_sources/remote_data_sources.dart
data/data_sources/local_data_sources.dart
data/repositories/repository.dart
```

Model rules:

- Model extends entity when practical.
- `fromJson` handles actual API shape.
- `toJson` and `toJsonFromEntity` handle cache/API serialization.
- Nested entities use model static serializers, not casts.
- Handle `List`, `{ data: [...] }`, `{ body: [...] }`, and direct object shapes
  explicitly based on the API sample.
- If the API may return HTML or an unexpected shape, fail with `ServerFailure`
  instead of casting blindly.

Repository rules:

- Read methods:
  - If online, get remote data, cache it, return entities.
  - If offline, return cached data when possible.
  - If remote read fails, fallback to cache only when useful.
- Write methods:
  - Create/update/delete stay online-only unless offline sync is explicitly
    requested.
- Catch existing `Failure` types consistently.
- Do not swallow failures silently.

### Step 5: Cubit And State

Create or update:

```text
presentation/controller/<service>/<service>_cubit.dart
presentation/controller/<service>/<service>_state.dart
```

Cubit rules:

- Inject use cases and session/storage abstractions through constructor.
- Do not call `serviceLocator<T>()` inside cubit methods unless the project has
  no existing registration path and the exception is documented.
- Do not call async load methods from both the cubit constructor and the screen.
  Pick one place. Prefer screen/provider call:

```dart
BlocProvider(
  create: (_) => serviceLocator<XxxCubit>()..loadLookups(),
  child: const XxxForm(),
)
```

- After every awaited async call, avoid emitting if the cubit is closed:

```dart
if (isClosed) return;
emit(state.copyWith(status: XxxStatus.loaded));
```

- Dispose every `TextEditingController` in `close()`.
- Keep selected lookup IDs in the cubit/state.
- UI should not map dropdown labels back to IDs.
- Avoid force unwraps. Use validation or early returns.
- Store error messages in state.

### Step 6: UI

Create or update:

```text
presentation/<service>/create_<service>_form.dart
presentation/<service>/widget/<section>.dart
```

UI rules:

- UI only renders state and calls cubit methods.
- No API/repository/cache/JSON logic in widgets.
- Use existing shared widgets and project design tokens:
  - `DAppBar`
  - `DButton`
  - `CreateDeleteButtons`
  - `ColorRes`
  - `AppSizes`
  - `const Sizer(height: 8)` / `const Sizer(width: 8)`
- Do not use raw user-facing strings. Add localization.
- Do not use `SizedBox` for normal spacing when `Sizer` is the project standard.
- Keep every major section in a separate widget file.
- Prefer `const` and `StatelessWidget`.

### Step 7: Details Screen

For request details:

- Add entity/model parsing for the service object inside `extraData`.
- Update `ExtraData` and `ExtraDataModel`.
- Add details widget:

```text
lib/features/details_and_edit_for_requests/presentation/widgets/<service>_details_widget.dart
```

- Add dispatch case in:

```text
lib/features/details_and_edit_for_requests/presentation/helpers/get_request_details_widget.dart
```

Details widget rules:

- Render already-parsed entities.
- Do not parse maps in the widget.
- Do not access `extraData` using raw string keys in UI.
- Use safe null handling.

### Step 8: Edit/Update Flow

If the service supports editing:

- Add edit endpoint constant.
- Add edit use case in `details_and_edit_for_requests/domain/use_cases`.
- Add remote data source method.
- Add repository method.
- Register it in `my_requests_service_locator.dart`.
- Add case in the edit/request-details flow.
- Reuse create form for update only if fields and behavior are truly the same.

### Step 9: Dependency Injection

Update the correct service locator:

```text
HR service:
  lib/core/service_locator/request_service_locator.dart

Salary service:
  lib/core/service_locator/salaries_service_locator.dart

Study/training service:
  lib/core/service_locator/study_training_service_locator.dart

Details/edit flow:
  lib/core/service_locator/my_requests_service_locator.dart
```

DI rules:

- Data sources: `registerLazySingleton`.
- Repository: `registerLazySingleton`.
- Use cases: `registerLazySingleton`.
- Cubits: `registerFactory`.
- Inject `LocalStorage` and `SessionStorage` abstractions, not
  `SharedPreferences`.

### Step 10: Localization

Add every user-facing string to:

```text
lib/l10n/intl_en.arb
lib/l10n/intl_ar.arb
```

Then generate localization:

```bash
flutter pub run intl_utils:generate
```

Use:

```dart
S.current.someKey
```

---

## 6. Local Cache Rules

Use local data sources for read operations that the user may need offline:

- Services catalog.
- Lookups/dropdowns.
- Request lists.
- Request details.
- Profile/navigation/session-adjacent display data.

Do not let widgets or cubits read raw cache directly.

Correct path:

```text
Widget -> Cubit -> UseCase -> Repository -> LocalDataSource -> LocalStorage
```

Use `StorageKeys` for cache keys. Add a new key only when the service needs a
new persistent cache entry.

Cache shape:

- Cache models or model JSON.
- Decode cache in local data source.
- Return models from local data source.
- Repository returns entities.

Writes are online-only unless the task explicitly asks for queued offline sync.

---

## 7. Safety Rules From Past Breakages

These rules prevent the kinds of bugs that already happened in this project.

- Do not assign raw JSON maps to typed entity fields. Always call `fromJson`.
- Do not assume attachment type. Check if API sends string, list, object, or URL.
- Do not cast response blindly to `Map<String, dynamic>` without verifying the
  shape when the endpoint can return wrapper objects or non-JSON.
- Do not emit after a cubit is closed.
- Do not start the same async request twice from constructor and screen.
- Do not leave `print`, temporary `debugPrint`, stale TODOs, or old commented
  implementation blocks.
- Do not put `fromJson`/`toJson` in new entities.
- Do not return models from use cases or domain repositories.
- Do not hardcode backend service-code strings in widgets.
- Do not force unwrap nullable route args or response fields.
- Do not ignore analyzer warnings, hints, or deprecated APIs.
- Do not change backend keys to nicer Dart names in request bodies.
- Do not add fields that the API does not return unless the UI genuinely owns
  them and they are documented.

---

## 8. Verification Checklist

Run these before and after implementation.

### 8.1 Analyzer

```bash
flutter analyze --no-fatal-infos --no-fatal-warnings
```

Expected: no issues. If any remain, explain why.

### 8.2 Format

```bash
dart format <changed dart files>
```

### 8.3 Domain Boundary

```bash
rg -n "import .*data/(model|models|data_sources)|Model\\b" lib/features/*/domain
rg -n "Future<.*Model|Either<Failure, .*Model|List<.*Model|Model>" lib/features/*/domain
```

Expected: no domain dependency on models/data.

### 8.4 Debug Noise

```bash
rg -n "\\bprint\\(|debugPrint\\(" lib
rg -n "^\\s*//\\s*(return|if|else|for|while|switch|case|final|var|const|Text|Container|SizedBox|Sizer|Navigator|context\\.|controller\\.|await|setState|Bloc|Expanded|Row|Column|Padding|GestureDetector|TODO|print|debugPrint|serviceLocator\\.register)" lib
```

Expected: no debug prints and no stale commented-out code.

### 8.5 Unsafe Casts And Serializers

```bash
rg -n "as [A-Za-z0-9_]+Model\\??\\)\\?*\\.toJson\\(|\\(.* as .*Model.*\\)\\.toJson" lib
rg -n "as Map<String, dynamic>|as List" lib/features
```

Review all matches. Some casts are acceptable when guarded by response-shape
checks, but unsafe casts in API parsing are a risk.

### 8.6 Cubit Lifecycle

```bash
rg -n "class .*Cubit|emit\\(|isClosed|serviceLocator<" lib/features -g "*_cubit.dart"
```

Review:

- Async methods should not emit after close.
- Cubits should use constructor injection.
- No duplicate load call in constructor and provider.

---

## 9. Final Report Required From Any Agent

Every completed service implementation must report:

- Service name and backend service code.
- APIs implemented.
- Files changed.
- Entities added/updated.
- Models added/updated.
- Use cases added/updated.
- Repository/data-source methods added/updated.
- Cubit/state added/updated.
- UI sections added/updated.
- Details/edit dispatch added/updated.
- Service locator registrations added.
- Localization keys added.
- Cache behavior added.
- Verification commands run and exact result.
- Remaining analyzer/search matches and why they are acceptable.
- Any assumptions made because API information was missing.

Do not say "done" if analyzer or required searches still have unexplained
issues.

---

## 10. Copy/Paste Prompt For A New Service

Use this prompt with an AI agent:

```text
Read SERVICE_IMPLEMENTATION_GUIDE.md, add the new Shaoni service below, and
follow the existing codebase style exactly.

Service identity:
- English name:
- Arabic name:
- Backend service code:
- Parent feature/category:
- Supports create:
- Supports update:
- Supports manager edit:
- Supports details:
- Appears in user/manager/kafeel requests:

APIs:
- Create endpoint/method/request/response:
- Update endpoint/method/request/response:
- Lookup endpoints/methods/responses:
- Edit endpoint/method/request/response:
- Details sample from Request/{id}/with-stages:
- Failure response samples:

UI requirements:
- Fields:
- Required fields:
- Dropdowns and labels:
- Attachments:
- Date fields and formats:
- Success behavior:
- Validation rules:

Implementation requirements:
- Do not change backend keys or response contracts.
- Keep domain independent from data/models.
- Use entities in presentation and use cases.
- Use models only in data layer.
- Use LocalStorage/SessionStorage abstractions through DI.
- Add local cache for read lookups/lists/details where useful.
- Split the main screen into stateless section widgets.
- Keep business logic in cubit, UI only calls cubit.
- Run format, analyzer, and the verification searches.
- Report every remaining issue or assumption.
```

