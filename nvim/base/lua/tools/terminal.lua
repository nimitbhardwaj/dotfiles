local M = {}

M.terminals = {}
M.next_id = 1000

function M.get_count()
  local id = M.next_id
  M.next_id = M.next_id + 1
  return id
end

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

function M.toggle_with_count(count)
  if count == 0 then
    if vim.bo.buftype == "terminal" then
      M.toggle_current()
      return
    end
    count = 1
  end
  vim.cmd("exe " .. count .. " . 'ToggleTerm name=Terminal" .. count .. "'")
end

return M
