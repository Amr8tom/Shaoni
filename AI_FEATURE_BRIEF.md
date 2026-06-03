# 🧾 AI Feature Brief — what to fill in BEFORE asking the AI to build a feature

> Every time you ask Claude (or any AI agent) to add a new feature to this app,
> copy this file, fill in every section, and paste it as the very first message.
> The agent will follow `FEATURE_TEMPLATE.md` for *how* to write the code, and
> this file for *what* to build.
>
> **Rule:** if you can't fill a section, mark it `TODO` — never delete it. The AI
> needs to see what's missing so it can ask the right follow-up questions.

---

## 1. Feature identity

- **Feature name (English):** `_______________________` (e.g. `Loan Request`)
- **Feature name (Arabic):** `_______________________` (e.g. `طلب قرض`)
- **Folder name (snake_case):** `_______________________` (e.g. `loan_request`)
- **Service code (must match backend exactly):** `_______________________` (e.g. `hr.loan.request`)
- **Plural / list label (English):** `_______________________`
- **Plural / list label (Arabic):** `_______________________`
- **Icon (Material name OR asset path):** `_______________________`
- **Accent color (one of `ColorRes.xxx`):** `_______________________`

---

## 2. API endpoints

Fill the table — for any row you don't have yet, write `TODO`.

| Action  | Method | URL (relative to `URL.baseUrl`) | Notes |
|---------|--------|---------------------------------|-------|
| List    | GET    | `/Xxx/list`                     | pagination params? |
| Details | GET    | `/Xxx/{id}`                     | |
| Create  | POST   | `/Xxx/create`                   | |
| Update  | PUT    | `/Xxx/update/{id}`              | trailing slash in URL constant |
| Edit (request edit / return) | PUT | `/Xxx/edit/{id}` | only if the service supports request-edit |
| Delete  | DELETE | `/Xxx/{id}`                     | only if applicable |

---

## 3. Lookup endpoints (for every dropdown the form has)

For each lookup, fill all three columns.

| Lookup name | Endpoint URL | Sample JSON (paste one element) |
|---|---|---|
| Example: `LoanType` | `$baseUrl/Lookup/GetLoanTypes` | `{ "id": 1, "nameAr": "قرض شخصي", "nameEn": "Personal" }` |
|  |  |  |
|  |  |  |

> If the lookup uses a single `name` field instead of `nameAr`/`nameEn`, say so explicitly.

---

## 4. Form fields (the create / update screen)

| Field name (camelCase) | Type | Required? | Validation | Source | Notes |
|---|---|---|---|---|---|
| Example: `loanAmount` | number | yes | min 1000, max 100000 | text input | |
| Example: `loanTypeId` | int | yes | one of the lookup | dropdown from `LoanType` lookup | |
| Example: `note`       | string | no | – | multiline | |
| Example: `attachment` | file/base64 | no | – | `FileUploadWidget` | |

For dropdowns, point to the lookup name in section 3.

---

## 5. Create payload — paste the exact JSON the backend expects

```json
{
  "employee_id": 0,
  "office_id": 0,
  "loan_type_id": 0,
  "loan_amount": 0,
  "note": "",
  "attachment_ids": [
    { "name": "file.pdf", "attachment": "<base64>" }
  ]
}
```
> The AI will build `CreateXxxParams { toMap() }` from this. Snake_case keys are taken as-is.

---

## 6. Update payload

- [ ] Identical to create + `requestId` in URL — **no changes to body**.
- [ ] Different body — paste below:

```json
{
  // paste only if different from create
}
```

---

## 7. Details GET response — paste the JSON returned from `/Xxx/{id}`

Just paste one example response. The AI will derive the entity + model from it.

```json
{
  "id": 0,
  "serviceCode": "hr.loan.request",
  "currentStatus": { "techName": "manager_review", "nameAr": "…", "nameEn": "…" },
  "extraData": {
    "loanRequest": {
      "loanAmount": 0,
      "loanType": "Personal",
      "note": "",
      "state": "draft",
      "attachments": ["<base64>"]
    }
  }
}
```

---

## 8. Stages / Statuses (techName from the API → unified UI status)

| Backend techName | Maps to `RequestStatusEnum` |
|---|---|
| `draft` / `new` / `submitted` | `newRequest` |
| `manager_review` / `manger`   | `managerApproval` |
| `hr_review` / `hr_pending`    | `hrApproval` |
| `accepted` / `done`           | `done` |
| `rejected` / `cancelled`      | `rejected` |
| _your tech name_              | _your UI status_ |

If the service has weird tech names, list every one. The AI will fill the
`getRequestStatusEnum(serviceCode)` switch.

---

## 9. Allowed actions per stage (which buttons show when)

| Stage (techName) | Show Update? | Show Cancel? | Show Resubmit? | Other |
|---|---|---|---|---|
| `draft`           | ✅ | ✅ | — | – |
| `manager_review`  | — | — | — | – |
| `manager_returned`| ✅ | — | ✅ | – |
| `hr_review`       | — | — | — | – |
| `accepted`        | — | — | — | – |
| `rejected`        | — | — | — | – |

> The AI will use these to gate the "Update" button visibility per service.

---

## 10. UI / Design references

- **Figma / screenshot links:** (paste here)
- **Behaviour notes:** anything that's NOT obvious from the screenshots — animations,
  conditional fields, dynamic field visibility, validation messages.

---

## 11. Localization strings (English + Arabic pairs)

Add EVERY new string the screen uses. The AI will add them to `intl_en.arb` and
`intl_ar.arb` simultaneously.

| Key (camelCase)        | English             | Arabic        |
|------------------------|---------------------|---------------|
| `loanType`             | Loan Type           | نوع القرض      |
| `selectLoanType`       | Select Loan Type    | اختر نوع القرض |
| `loanAmount`           | Loan Amount         | قيمة القرض     |
| `enterLoanAmount`      | Enter Loan Amount   | أدخل قيمة القرض |
|                        |                     |               |

---

## 12. Special business rules

Anything that doesn't fit elsewhere. Examples:
- "Update is only allowed within 24h of submission."
- "If `loanAmount > 50000`, an extra `guarantor` field becomes required."
- "Only users with role `manager` can see this service in the catalog."
- "When `loanType == 'mortgage'`, hide `repaymentMonths` and show `repaymentYears`."

```
- 
- 
- 
```

---

## 13. Service-locator dependencies

- [ ] Uses the existing `HRServiceLocator` (default — yes for most features).
- [ ] Needs its own service-locator file. Reason: `_______________________`.

---

## 14. Confirmation checklist before sending to the AI

- [ ] Section 1 filled (identity).
- [ ] All API URLs in section 2 are real (not TODO) OR explicitly marked as not-yet-existing.
- [ ] Every dropdown in section 4 has a matching lookup in section 3.
- [ ] Sample JSON pasted for create (5), details (7), and any lookup (3).
- [ ] Stage table (8) covers every techName the backend can return.
- [ ] Allowed-actions table (9) covers every stage.
- [ ] All new strings listed in section 11 with BOTH languages.

---

## Quick example — minimal filled brief

> ### Feature: Loan Request
>
> **Service code:** `hr.loan.request`
> **Folder:** `loan_request`
> **Icon:** `Icons.account_balance_wallet_rounded` · **Color:** `ColorRes.success`
>
> **Endpoints**
> - List: `GET $baseUrl/HrLoan/list`
> - Details: `GET $baseUrl/HrLoan/{id}`
> - Create: `POST $baseUrl/HrLoan/create`
> - Update: `PUT $baseUrl/HrLoan/update/`
>
> **Lookups**
> - `LoanType` → `GET $baseUrl/Lookup/GetLoanTypes` → `{ "id": 1, "nameAr": "شخصي", "nameEn": "Personal" }`
>
> **Form fields**
> - `loanTypeId` (int, required, dropdown from `LoanType`)
> - `loanAmount` (number, required, min 1000)
> - `note` (string, optional, multiline)
> - `attachment` (file, optional)
>
> **Create payload**
> ```json
> { "employee_id": 0, "office_id": 0, "loan_type_id": 0, "loan_amount": 0, "note": "", "attachment_ids": [] }
> ```
>
> **Stages**
> - `draft` → newRequest · `manager_review` → managerApproval · `hr_review` → hrApproval · `accepted` → done · `rejected` → rejected
>
> **Allowed actions**
> - `draft`: Update + Cancel
> - All others: none
>
> **Localization**
> - `loanType` → "Loan Type" / "نوع القرض"
> - `loanAmount` → "Loan Amount" / "قيمة القرض"
> - `selectLoanType` → "Select Loan Type" / "اختر نوع القرض"
>
> **Business rules** — none beyond defaults.

That's it — paste this with a one-line instruction (`Build the Loan Request feature
following FEATURE_TEMPLATE.md and the brief below`) and the AI will scaffold every
file in the same shape as `car_permission`.
