# Obtain Rebuy — Project Context

## Object ID Range
- **Lowest**: 87600 (`tableextension 87600 "OBX Item Ext"`)
- **Highest**: 87639 (`page 87639 "OBT Item List2"`)
- **Next available**: 87640

---

## Code Quality Audit — April 15, 2026

Full audit performed against BC-AL-Global-Instructions.md. Status: **Open** (not yet fixed).

---

### CRITICAL

#### Rule 3 — Missing ToolTips on table fields
All table fields have `Caption` but no `ToolTip`. Affects all 7 custom tables and 3 table extensions.

| File | Fields Missing ToolTip |
|------|------------------------|
| Tab87609.OBTSalesLineAttributeValue.al | All fields (1, 2, 3, 11–16) — 9 fields |
| Tab87611.OBTAssortment.al | All fields (1, 5, 11–15) — 7 fields |
| Tab87612.OBTItemAssortment.al | field(1), field(5) |
| Tab87613.OBTCustomerAssortment.al | field(1), field(5) |
| Tab87616.OBTContactAssortment.al | field(1), field(5) |
| Tab87622.OBTSalesLineCopyBuffer.al | All fields (1–16, 101) — 17 fields |
| Tab87635.OBTGetPostBuffer.al | All fields (1–7) |
| Tab-Ext87600.OBTItemExtension.al | field(87602), field(87603) |
| Tab-Ext87605.OBTSalesLineExt.al | field(87603) |
| Tab-Ext87617.OBTCustomerExt.al | field(87600), field(87601), field(87602), field(87605) |

**Status**: ☑ Fixed — April 15, 2026

---

### HIGH

#### Rule 2 — DataClassification set at field level instead of table level
Should be set once at table level, not per field.

| File | Fields Affected |
|------|-----------------|
| Tab87612.OBTItemAssortment.al | field(1), field(5) |
| Tab87613.OBTCustomerAssortment.al | field(1), field(5) |
| Tab87616.OBTContactAssortment.al | field(1), field(5) |
| Tab-Ext87617.OBTCustomerExt.al | field(87602) — **intentional**: tableextension has no table-level DataClassification; field-level is the only valid location |

**Note**: No page files contained DataClassification — confirmed clean.

**Status**: ☑ Fixed — April 15, 2026

#### Rule 8 — Insert() without explicit runTrigger parameter
In Tab87611.OBTAssortment.al:
- `obtItemAssort.Insert` → should be `obtItemAssort.Insert(true)`
- `CustomerAssortment.Insert` → should be `CustomerAssortment.Insert(true)`
- `ContactAssortment.Insert` → should be `ContactAssortment.Insert(true)`

**Status**: ☐ Open

#### Rule 15 — Permission set missing 26 objects
Obtain_CopySales.permissionset.al only covers tables. Missing:

**Pages (18):** Pag87607, 87610, 87611, 87612, 87613, 87614, 87615, 87617, 87619, 87624, 87625, 87626, 87627, 87628, 87633, 87634, 87637, 87638, 87639

**Codeunits (6):** Cod87629, 87630, 87631, 87632, 87635, 87636

**Enum (1):** Enum87623 "OBT Sal. Line Type Copy Buff"

**Status**: ☐ Open

---

### MEDIUM

#### Rule 4 — Page fields re-declaring inherited ToolTip/Caption
Bound page fields should not repeat ToolTip/Caption already defined on the table field.

| File | Fields | Fix |
|------|--------|-----|
| Pag87610.OBTSalesLineAttributes.al | "OBT Sales Document Type/No./Line No." — removed ToolTip; "RawValue" — removed Caption + ToolTip; "Attribute Name" — removed ToolTip, kept Caption (intentional override: 'Attribute' ≠ 'Attribute Name') | Done |
| Pag87611.OBTAssortments.al | All 7 repeater fields had `ToolTip = 'Shows the value'` — removed | Done |
| Pag87613.OBTItemAssortmentFactbox.al | "OBT Assortment Code", "OBT Assortment Description" — removed Caption | Done |
| Pag87615.OBTCustomerAssortmentFactbox.al | "OBT Assortment Code", "OBT Assortment Description" — removed Caption | Done |
| Pag87619.OBTContactAssortmentFactbox.al | "OBT Assortment Code", "OBT Assortment Description" — removed Caption | Done |

**Status**: ☑ Fixed — April 15, 2026

#### Rule 6 — Actions missing ToolTip
All page actions must have `ToolTip` with `Comment = '%'`.

| File | Action | Fix |
|------|--------|-----|
| Pag87612.OBTAssortmentItems.al | `SelectItems` | Added ToolTip |
| Pag87614.OBTAssortmentCustomers.al | `SelectCustomers` | Added ToolTip |
| Pag87617.OBTAssortmentContacts.al | `SelectContact` | Added ToolTip |
| Pag87611.OBTAssortments.al | `ShowItems`, `ShowCustomers`, `ShowContacts` | Replaced placeholder 'Shows X' with proper descriptions |

**Note**: All other actions (Pag87625/87626/87627/87628/87633/87634/87639, Pag-Ext87606/87607, Page-87607) already had correct ToolTips — confirmed clean.

**Status**: ☑ Fixed — April 15, 2026

#### Rule 16 — No FieldGroups defined on any table
All 7 custom tables are missing `fieldgroup(DropDown; ...)` and `fieldgroup(Brick; ...)`.

Affected: Tab87609, Tab87611, Tab87612, Tab87613, Tab87616, Tab87622, Tab87635

**Status**: ☐ Open

#### Rule 17 — Missing DrillDownPageId
Tables have `LookupPageId` but no `DrillDownPageId`.

| File | DrillDownPageId added |
|------|-----------------------|
| Tab87611.OBTAssortment.al | "OBT Assortments" |
| Tab87612.OBTItemAssortment.al | "OBT Assortment Items" |
| Tab87613.OBTCustomerAssortment.al | "OBT Assortment Customers" |
| Tab87616.OBTContactAssortment.al | "OBT Assortment Contacts" |

**Status**: ☑ Fixed — April 15, 2026

---

### LOW

#### Rule 7 — CalcFormula uppercase function
In Tab87609.OBTSalesLineAttributeValue.al: `Lookup()` should be lowercase `lookup()`.

**Status**: ☑ Fixed — April 15, 2026

---

## Recommended Fix Order
1. **Rule 15** — Permissions (quick wins, compiler errors in BC16+)
2. **Rule 2** — DataClassification (move to table level)
3. **Rule 8** — runTrigger on Insert calls
4. **Rule 7** — CalcFormula casing
5. **Rule 3** — Add ToolTips to all table fields (most numerous)
6. **Rule 4** — Remove redundant ToolTip/Caption from page fields
7. **Rule 6** — Add ToolTip to actions
8. **Rule 16** — Add FieldGroups to tables
9. **Rule 17** — Add DrillDownPageId to tables
