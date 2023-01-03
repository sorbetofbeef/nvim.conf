  local ok, hints = pcall(require, "lsp-inlayhints")
  if not ok then
    return
  end

  hints.setup()
