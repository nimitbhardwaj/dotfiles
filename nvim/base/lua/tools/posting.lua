local M = {}

local Terminal = require("toggleterm.terminal").Terminal
local terminal = require("tools.terminal")

local posting = Terminal:new({
  cmd = "posting",
  direction = "float",
  float_opts = {
    border = "rounded",
  },
  hidden = true,
  on_open = function(self)
    terminal.register(self)
    vim.cmd("startinsert!")
  end,
  on_exit = function(self)
    terminal.unregister(self)
  end,
})

function M.toggle()
  posting:toggle()
end

return M
