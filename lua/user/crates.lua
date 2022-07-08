local status_ok, crates = pcall(require, "crates")
if not status_ok then
  return
end

local null_status_ok, null_ls = pcall(require, "null-ls")
if not null_status_ok then
  return
end

crates.setup {
  popup = {
    autofocus = true,
    style = "minimal",
    border = "rounded",
    show_version_date = true,
    show_dependency_version = true,
    max_height = 30,
    min_width = 20,
    padding = 1,
  },
  null_ls = {
    enabled = true,
    name = "Crates",
  },
}
