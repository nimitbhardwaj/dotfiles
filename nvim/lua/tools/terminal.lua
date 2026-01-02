local M = {}

M.terminals = {}

function M.register(term)
  M.terminals[term.bufnr] = term
end

function M.unregister(term)
  M.terminals[term.bufnr] = nil
end

function M.toggle_current()
  if vim.bo.buftype ~= "terminal" then
    vim.cmd("ToggleTerm")
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local term = M.terminals[bufnr]

  if term then
    term:toggle()
    return
  else
    vim.cmd("ToggleTerm")
  end
end

return M
