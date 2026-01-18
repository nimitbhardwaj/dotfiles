local M = {}

local Terminal = require("toggleterm.terminal").Terminal
local terminal = require("tools.terminal")

local ralph_terminal = nil
local last_args = nil

local function create_terminal(args)
  return Terminal:new({
    cmd = "ralph-tui run " .. args,
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
      ralph_terminal = nil
    end,
  })
end

local function ask_for_args(cb)
  vim.ui.input({
    prompt = "ralph-tui args (e.g. --epic EPIC-42 --model chatgpt): ",
  }, function(input)
    -- Esc pressed → cancel
    if input == nil then
      return
    end

    -- Empty input is VALID
    last_args = input
    cb(input)
  end)
end

function M.toggle()
  -- If terminal exists, just toggle it
  if ralph_terminal then
    ralph_terminal:toggle()
    return
  end

  -- Ask only the first time
  if not last_args then
    ask_for_args(function(args)
      ralph_terminal = create_terminal(args)
      ralph_terminal:toggle()
    end)
    return
  end

  -- Reuse previous args
  ralph_terminal = create_terminal(last_args)
  ralph_terminal:toggle()
end

function M.reset()
  last_args = nil
end

return M
