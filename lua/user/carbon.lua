local status, carbon = pcall(require, "carbon")
if not status then return end

carbon.setup({
  keep_netrw = false
})
