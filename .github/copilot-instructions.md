# AI Assistant Instructions - Obtain Pricing Worksheet Extension

## 📌 Quick Context

This is a **Business Central AL extension** for pricing worksheets — it allows users to manage and process pricing data in a worksheet-style interface. The codebase follows strict coding standards and uses automated verification patterns.

**Critical**: This workspace has comprehensive documentation that you must read and follow. The user (Morten Preuthun) values deep understanding and explanations of *why*, not just *what*.

---

## 📚 Documentation System

This project uses three documentation files that work together:

### 1. **BC-AL-Global-Instructions.md** 
**Purpose**: Complete coding standards and guidelines  
**Read this for**: Understanding what constitutes correct AL code  
**Contains**: 17+ detailed rules covering:
- Naming conventions (OBX prefix)
- Field definitions (DataClassification, ToolTip, Caption)
- Triggers and procedures
- Page patterns (ApplicationArea, ToolTips on actions)
- Permission set requirements (BC16+ mandatory)
- Code quality rules (keyword casing, performance, complexity)

**Key takeaways**:
- Always use `OBX` prefix for custom objects
- `DataClassification` at table level, not field level
- Remove redundant ToolTip/Caption from page fields (inherited from table)
- Use lowercase for CalcFormula functions: `lookup()`, not `Lookup()`
- Always explicitly set `runTrigger` parameter: `Insert(true)`, `Modify(true)`
- Use ConfirmManagement codeunit instead of direct `Confirm()` calls
- New objects MUST be added to permission set file

---

## 🎯 Communication Style

**Critical**: User prefers deep explanations over surface-level answers.

**✓ Do**:
- Explain *why* something works, not just *what* to do
- Teach concepts when introducing tools (grep, regex, AL patterns)
- Provide rationale behind coding standards
- Include context and reasoning

**✗ Don't**:
- Give quick fixes without explanation
- Say "run this command" without explaining what it does
- Oversimplify technical concepts
- Skip the reasoning behind decisions

---

## 🚀 Getting Started Workflow

When beginning work in this workspace:

1. **Read the three documentation files** in `.github/`:
   - BC-AL-Global-Instructions.md (standards)
   - PROJECT_CONTEXT.md (project specifics)
   - TRANSLATION-WORKFLOW.md (translation guidance)

2. **Check current state**:
   - Run `get_errors()` to see Problems panel
   - Review what the user is asking about

3. **Verify before claiming**:
   - Use `grep_search` to verify code patterns
   - Don't assume code follows standards
   - Read sufficient context (large line ranges)

4. **Fix systematically**:
   - Follow verification checklist patterns
   - Use `multi_replace_string_in_file` for batch fixes
   - Always include 3-5 lines of context in replacements

5. **Update permissions**:
   - When creating new objects, add to `ObtainPricingWorksheet.permissionset.al`
   - Tables need both `tabledata` (RIMD) and `table` (X) permissions
   - Pages/Codeunits need (X) execute permissions
   - PageExtensions inherit - don't add them

---

## 🔧 Technical Environment

- **BC Version**: Business Central 27.3+ (runtime 16.0)
- **Object Range**: 85000–85100
- **Prefix**: OBX (all custom objects)
- **Publisher**: OBTAIN
- **Code Analyzer**: LinterCop.dll (Stefan Maron)
- **Features**: `NoImplicitWith`, `TranslationFile` enabled in app.json

**File Structure**:
```
.src/
├── Table/       (Tab85000+)
├── Page/        (Pag85000+)
├── Codeunit/    (Cod85000+)
└── ...other AL objects
```

---

## 📋 Key Rules Quick Reference

1. **DataClassification**: Table-level only, not per-field
2. **ToolTip + Caption**: Required on all fields, with `Comment = '%'`
3. **Field naming**: No quotes for single-word names (unless reserved word)
4. **CalcFormula**: Use lowercase functions (`lookup`, `exist`)
5. **Page fields**: Remove inherited ToolTip/Caption (table-bound fields)
6. **ApplicationArea**: Page-level `All`, not per-field
7. **runTrigger**: Always explicit (`Insert(true)`, `Modify(true)`)
8. **Permissions**: All new objects must be added to permission set
9. **EventSubscriber**: Use identifiers, not string literals
10. **RecordId**: Always use parentheses `RecordId()`
11. **Confirm**: Use ConfirmManagement codeunit, not direct `Confirm()`
12. **IsEmpty()**: Use instead of `Find()` when not accessing record values
13. **Unused variables**: Remove all unused declarations
14. **Object IDs**: Sequential numbering within each type
15. **Keyword casing**: PascalCase (`Format`, `StrLen`, not `format`, `strlen`)

---

## 🔍 Common Tasks

### When User Reports Errors
1. Run `get_errors()` to see all violations
2. Compare against 17 rules in BC-AL-Global-Instructions.md
3. Fix systematically using `multi_replace_string_in_file`

### When Creating New Objects
1. Check existing objects to find next sequential ID (range: 85000–85100)
2. Create the object file in appropriate `.src/` subfolder
3. **Immediately add permissions** to `ObtainPricingWorksheet.permissionset.al`
4. Verify all standards are followed (ToolTip, Caption, DataClassification)

### When Modifying Existing Code
1. Read current implementation (large line ranges)
2. Verify what standards apply
3. Make changes following BC-AL-Global-Instructions.md
4. Re-run `get_errors()` to confirm fix

---

## 🎓 Philosophy

This workspace is set up for **systematic, verifiable code quality**:
- Standards are documented (BC-AL-Global-Instructions.md)
- AI assistants can execute verification patterns programmatically
- Code quality is measurable and improvable

**Your role**: Help maintain and improve code quality by following the documented standards and teaching the user *why* these patterns matter.

---

**Last Updated**: March 16, 2026  
**Workspace**: Obtain Pricing Worksheet Extension for Business Central  
**Maintained By**: AI Assistants working with Morten Preuthun
