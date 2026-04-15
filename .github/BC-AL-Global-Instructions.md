# Business Central AL Development - Global Instructions

## General Principles
- Custom extension objects should use a consistent prefix to distinguish from base BC objects
- Follow Microsoft's AL coding conventions and best practices
- Enable `NoImplicitWith` feature in app.json for explicit record references

## Naming Conventions
- **Company Prefix**: Use `OBX` prefix for all custom objects (tables, pages, codeunits, etc.)
  - Examples: `OBX Model`, `OBX Shop`, `OBX Brand`
- **Extension Fields**: All fields added via TableExtension or PageExtension must start with `OBX`
  - Example: `OBXCustomField`, `OBXIsActive`
- **Object Names**: Combine prefix with descriptive name
  - Tables: `table 82000 "OBX Model"`
  - Pages: `page 82001 "OBX Model Card"`
  - Codeunits: `codeunit 82000 "OBX Item Management"`

## Code Conventions

### Field Definitions
- Always include `Caption` and `ToolTip` for all table fields
- Set `DataClassification` at the table level, not on individual fields
- Use `TableRelation` for foreign key relationships
- Set `NotBlank = true` for required fields
- **Field Naming**: Only use quotes around field names when necessary
  - Single-word field names: No quotes (e.g., `field(10; Description; Text[100])`, `Rec.Description`)
  - Multi-word or special character names: Use quotes (e.g., `field(20; "Ship-to Code"; Code[20])`, `Rec."Ship-to Code"`)
- **ToolTips and Captions on Pages**: 
  - Define ToolTips and Captions at the table field level; page fields automatically inherit them from their source table fields
  - **Remove** ToolTip and Caption properties from page fields when they are bound to table fields (redundant)
  - Only add ToolTip or Caption on page fields if:
    - The field is not bound to a table field (e.g., calculated fields, display-only fields)
    - You need to override the inherited value with a page-specific caption or tooltip
- **FlowFields**: 
  - Use `FieldClass = FlowField` with `CalcFormula` for denormalized lookups
  - Use lowercase for `CalcFormula` functions: `lookup()`, `exist()`, `sum()`, `count()`, etc. (not `Lookup`, `Exist`)
  - Mark as `Editable = false`

### Triggers
- Place validation logic in field `OnValidate()` triggers for data integrity
- Use table triggers sparingly; prefer field-level validation

### Record Modifications
- **RunTrigger Parameter**: Always explicitly set the runTrigger parameter on record operations
  - **Normal records**: Use `true` to ensure triggers execute
    - `Record.Insert(true);`
    - `Record.Modify(true);`
    - `Record.Delete(true);`
    - `Record.Validate(FieldName, Value);` (always runs trigger)
  - **Temporary records**: Use `false` since no triggers exist on temporary tables
    - `TempRecord.Insert(false);`
    - `TempRecord.Modify(false);`
    - `TempRecord.Delete(false);`
  - Never omit the parameter - always be explicit about trigger execution

### Procedures
- Use `local procedure` for internal helper methods
- Public procedures for cross-object integration and reusable functionality
- **EventSubscriber**: Use identifier syntax (not string literals) for event names
  - Correct: `[EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterValidateEvent, "No.", false, false)]`
  - Incorrect: `[EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', "No.", false, false)]`
- **EventSubscriber var Parameters**: Parameter signatures must match the publisher
  - If publisher parameter is `var`, subscriber parameter must also be `var`
  - Example: `local procedure OnBeforeInsert(var Rec: Record "Sales Line"; var xRec: Record "Sales Line")`
- **RecordId**: Always use parentheses when calling the RecordId function
  - Correct: `Record.RecordId()`
  - Incorrect: `Record.RecordId`
- **FieldRef and RecordRef functions**: Always use parentheses on all FieldRef/RecordRef member calls
  - Correct: `FieldRef.Class()`, `FieldRef.Value()`, `RecRef.RecordId()`
  - Incorrect: `FieldRef.Class`, `FieldRef.Value`, `RecRef.RecordId`
  - Applies to: `Class()`, `Value()`, `Name()`, `Caption()`, `Length()`, `Number()`, `Type()`, `Active()`, `OptionMembers()`, `OptionCaption()`, `Relation()`, `TestField()`, `Validate()` and all other FieldRef/RecordRef members that are callable
- **User Confirmations**: Use Confirm Management framework instead of direct `Confirm()` calls
  - Add variable: `ConfirmManagement: Codeunit "Confirm Management";`
  - Use `ConfirmManagement.GetResponseOrDefault(QuestionText, DefaultResponse)` instead of `Confirm(QuestionText, DefaultResponse)`
  - For labels with placeholders, use `StrSubstNo()`: `ConfirmManagement.GetResponseOrDefault(StrSubstNo(LabelText, Param1, Param2), false)`
  - Example:
    ```al
    var
        ConfirmManagement: Codeunit "Confirm Management";
    begin
        if not ConfirmManagement.GetResponseOrDefault(StrSubstNo(DeleteQst, ItemCount), false) then
            exit;
    end;
    ```
- **Parameter Naming**: Avoid using parameter names that conflict with global variables
  - If a global variable exists named `ArticleNo`, don't use `ArticleNo` as a parameter name
  - Use descriptive alternatives: `ParamArticleNo`, `NewArticleNo`, `InputArticleNo`
- **Unused Variables**: Remove all declared variables that are never used in the code
  - Improves code readability and maintainability
  - Reduces memory overhead

### DataClassification Guidelines
- Set `DataClassification` at the table level (applies to all fields in the table)
- `CustomerContent` for user-entered business data
- `SystemMetadata` for system-generated fields (e.g., SystemId, timestamps)
- `ToBeClassified` for setup/configuration tables (should be reviewed and properly classified)
- Only specify DataClassification on individual fields if they differ from the table-level setting

## Page Patterns

### Application Area
- Set `ApplicationArea = All;` at the page level, not on individual fields or actions
- This applies the application area to all elements on the page
- Only specify ApplicationArea on individual fields/actions if they differ from the page-level setting

### ToolTip Requirements
- **Fields**: All page fields must have ToolTip property with `Comment = '%'`
  - Table-bound fields inherit ToolTip from table definition (don't duplicate)
  - Calculated/unbound fields must have ToolTip defined on page
- **Actions**: All page actions must have ToolTip property with `Comment = '%'`
  - Actions never inherit ToolTip - always define explicitly
  - Example: `ToolTip = 'Opens the item card for editing.', Comment = '%';`

### List and Card Pattern
- Card pages use `PageType = Card` with grouped field layouts
- List pages should have corresponding `LookupPageId` and `DrillDownPageId` properties on the source table
- **FieldGroups**: Always define FieldGroups on tables for better lookup experiences
  - `DropDown`: Fields shown in lookup dropdowns (typically key field + description)
  - `Brick`: Fields shown in tile views
  - Example: `fieldgroup(DropDown; "Code", Description) { }`

### Matrix Pages
- Dynamic column captions via `CaptionClass = '3,' + VariableName`
- Use Dictionary-based value overrides for cell validation
- Typically source on `Integer` table with filters for row generation

## Common AL Patterns

### No. Series Pattern
- Implement `AssistEdit()` procedure for user-triggered number assignment
- Implement `TestNoSeries()` to validate manual entry
- Handle both automatic and manual numbering scenarios

### Composite Keys
- Detail/line tables should use parent code + child code as primary key
- Include secondary sorting keys for alternate access patterns
- Consider adding SystemId-based keys for API compatibility

### Translation Support
- Enable `TranslationFile` feature in app.json for multi-language support
- Always provide ToolTips with `Comment = '%'` pattern for translation context
- Keep UI text in Caption properties, not hardcoded in code

## Object Organization

### Object ID Assignment
- Always use the next available sequential object ID when creating new objects
- Before creating a new object, check the existing objects in the target folder to identify the highest ID
- Example: If the highest table ID is 82027, use 82028 for the next table
- Maintain sequential numbering within each object type (tables, pages, codeunits, etc.)

### File Naming
- Use descriptive names: `Tab<ID>.<ObjectName>.al`, `Pag<ID>.<ObjectName>.al`
- Group objects in folders by type: `.src/Table/`, `.src/Page/`, `.src/Codeunit/`, etc.
- File names must match the object ID: if table ID is 82028, file should be `Tab82028.ObjectName.al`

### Permission Sets
**Critical Best Practice**: Whenever creating new objects (tables, pages, codeunits, reports, queries, xmlports, etc.), always add them to the extension's permission set file to ensure proper security and access control.

**Why This Matters:**
- **Required by Microsoft**: Starting from Business Central version 16, Microsoft requires that all application objects in an extension must be covered by at least one permission set. This is enforced by the compiler/analyzer.
- **Security by Design**: Forces explicit definition of who can access what, preventing accidental exposure of functionality
- **Compliance**: Helps meet security audit requirements and regulatory standards
- **Granular Control**: Allows administrators to control user access at a detailed level

**Required permissions for each object type:**
- **Tables**: Add both `tabledata "ObjectName" = RIMD` and `table "ObjectName" = X`
  - `RIMD` = Read, Insert, Modify, Delete (data permissions)
  - `X` = eXecute (object permissions)
- **Pages**: Add `page "ObjectName" = X`
- **Codeunits**: Add `codeunit "ObjectName" = X`
- **Reports/XMLports/Queries**: Add `report/xmlport/query "ObjectName" = X`

**Organization guidelines:**
- Group permissions by functional area with comment headers (e.g., // Shop Management)
- Within each group, list `tabledata` permissions first, then `table`/`page`/`codeunit` permissions
- Keep related objects together (table + pages for the same entity in same section)
- Place event subscribers and handlers in a separate section at the end
- Base BC object permissions go in their own section

**Recommended workflow when creating objects:**
1. Create the object file (table, page, codeunit, etc.)
2. Open the extension's permission set file
3. Add the required permissions to the appropriate functional group
4. If no suitable group exists, create a new one with a comment header
5. Verify all new objects have corresponding permission entries before deployment
6. Run compiler to check for "not covered by any permission set" errors

**Common mistakes to avoid:**
- Forgetting to add both `tabledata` AND `table` permissions for tables
- Creating objects but forgetting to update the permission set file
- Not grouping related permissions together
- Missing permissions for event subscribers and handlers

## Best Practices
- Field numbering: Group related fields numerically (e.g., 100-series for one category, 200-series for another)
- Avoid hardcoded values; use enums or setup tables for configurable options
- Use FlowFields instead of storing calculated values when appropriate
- Always test with `SchemaUpdateMode: Synchronize` during development

## Code Quality and Performance

### AL Keyword Casing
- **Always use proper PascalCase for AL keywords and built-in functions**
- Common violations to avoid:
  - Use `Format` not `format`
  - Use `StrLen` not `strlen`
  - Use `CopyStr` not `copystr`
  - Use `Sections` not `sections` (in page extensions)
  - Use `StrSubstNo` not `strsubstno`
- AL is case-insensitive but LinterCop enforces proper casing for consistency

### Database Query Optimization
- **Use IsEmpty instead of Find when you don't need record values**
  - Inefficient: `if Record.FindFirst() then ...` (when not using Record fields)
  - Efficient: `if not Record.IsEmpty() then ...`
  - Only use `FindFirst`/`FindSet`/`Get` when you need to access field values from the record
- **Example**:
  ```al
  // Bad - queries database but doesn't use the record
  if ModelVariant.FindFirst() then
      HasVariants := true;
  
  // Good - only checks existence
  if not ModelVariant.IsEmpty() then
      HasVariants := true;
  ```

### Data Type Safety
- **Avoid Text to Code overflow**
  - When assigning Text to Code fields, ensure the result fits
  - Use `CopyStr(TextValue, 1, MaxLength)` to prevent overflow
  - Example: `Rec."Code" := CopyStr(PadStr('', 10, '0') + Format(Number), 1, MaxLen(Rec."Code"));`
- Be explicit about conversions and length constraints

### Code Complexity
- **Keep procedures simple and focused**
  - Target cyclomatic complexity < 8
  - Target maintainability index > 20
  - Break complex procedures into smaller, focused helper methods
  - Use descriptive names for extracted methods
