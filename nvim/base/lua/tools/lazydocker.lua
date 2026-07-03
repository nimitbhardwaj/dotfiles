local M = {}

local Terminal = require("toggleterm.terminal").Terminal
local terminal = require("tools.terminal")

local lazydocker = Terminal:new({
  cmd = "lazydocker",
  direction = "float",
  count = terminal.get_count(),
  float_opts = {
    border = "rounded",
  },
  hidden = true,
  on_open = function(self)
    terminal.register(self)
  end,
  on_exit = function(self)
    terminal.unregister(self)
  end,
})

function M.toggle()
  lazydocker:toggle()
end

return M
