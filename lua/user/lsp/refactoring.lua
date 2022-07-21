local refactor_status_ok, refactor = pcall(require, "refactoring")
if not refactor_status_ok then
  return
end

refactor.setup({
  prompt_func_return_type = {
    go = true,
    java = true,

    cpp = true,
    c = true,
    h = true,
    hpp = true,
    cxx = true,
  },
  prompt_func_param_type = {
    go = true,
    java = true,

    cpp = true,
    c = true,
    h = true,
    hpp = true,
    cxx = true,
  },
  printf_statements = {},
  printf_var_statements = {},
})

