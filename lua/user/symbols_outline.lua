local status_ok, outline = pcall(require, "symbols-outline")
if not status_ok then
  return
end

local i = require("user.icons").kind

local opts = {
  auto_preview = true,
  relative_width = true,
  width = 15,
  position = 'right',
  symbols = {
    File = {icon = i.File, hl = "TSURI"},
    Module = {icon = i.Module, hl = "TSNamespace"},
    Namespace = {icon = i.Namespace, hl = "TSNamespace"},
    Package = {icon = i.Package, hl = "TSNamespace"},
    Class = {icon = i.Class, hl = "TSType"},
    Method = {icon = i.Method, hl = "TSMethod"},
    Property = {icon = i.Property, hl = "TSMethod"},
    Field = {icon = i.Field, hl = "TSField"},
    Constructor = {icon = i.Constructor, hl = "TSConstructor"},
    Enum = {icon = i.Enum, hl = "TSType"},
    Interface = {icon = i.Interface, hl = "TSType"},
    Function = {icon = i.Function, hl = "TSFunction"},
    Variable = {icon = i.Variable, hl = "TSConstant"},
    Constant = {icon = i.Constant, hl = "TSConstant"},
    String = {icon = i.String, hl = "TSString"},
    Number = {icon = i.Number, hl = "TSNumber"},
    Boolean = {icon = i.Boolean, hl = "TSBoolean"},
    Array = {icon = i.Array, hl = "TSConstant"},
    Object = {icon = i.Object, hl = "TSType"},
    Key = {icon = i.Keyword, hl = "TSType"},
    Null = {icon = i.Null, hl = "TSType"},
    EnumMember = {icon = i.EnumMember, hl = "TSField"},
    Struct = {icon = i.Struct, hl = "TSType"},
    Event = {icon = i.Event, hl = "TSType"},
    Operator = {icon = i.Operator, hl = "TSOperator"},
    TypeParameter = {icon = i.TypeParameter, hl = "TSParameter"}
  },
  autofold_depth = 1,
}

outline.setup(opts)
