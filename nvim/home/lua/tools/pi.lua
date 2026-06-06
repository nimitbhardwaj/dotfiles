local M = {}

local Terminal = require("toggleterm.terminal").Terminal
local terminal = require("tools.terminal")

-- Tracks whether the pi process is alive (true once opened, false once the
-- process exits). Toggling the window off keeps the process running, so this
-- stays true while the window is merely hidden.
local running = false

local pi = Terminal:new({
  cmd = "pi",
  direction = "float",
  count = terminal.get_count(),
  float_opts = {
    border = "rounded",
  },
  hidden = true,
  on_open = function(self)
    terminal.register(self)
    running = true
    vim.cmd("startinsert!")
  end,
  on_exit = function(self)
    terminal.unregister(self)
    running = false
  end,
})

function M.toggle()
  pi:toggle()
end

-- Path of the current buffer relative to the cwd (falls back to absolute
-- when the file lives outside cwd).
local function relative_path()
  local path = vim.fn.expand("%:.")
  if path == "" then
    return nil
  end
  return path
end

-- Build the "@path[:range]" reference for the current mode/selection.
--   normal       -> @path
--   visual line  -> @path:L<sl>-L<el>
--   visual char  -> @path:L<sl>C<sc>-L<el>C<ec>   (1-based columns)
local function build_reference()
  local path = relative_path()
  if not path then
    vim.notify("pi: current buffer has no file path", vim.log.levels.WARN)
    return nil
  end

  local mode = vim.fn.mode()
  local visual_line = mode == "V"
  local visual_char = mode == "v" or mode == "\22" -- v or <C-v> (blockwise)

  if not (visual_line or visual_char) then
    return "@" .. path
  end

  -- In visual mode getpos("v") is the selection anchor and getpos(".") the
  -- cursor; normalise so (srow,scol) is the start.
  local anchor = vim.fn.getpos("v")
  local cursor = vim.fn.getpos(".")
  local srow, scol = anchor[2], anchor[3]
  local erow, ecol = cursor[2], cursor[3]
  if srow > erow or (srow == erow and scol > ecol) then
    srow, erow, scol, ecol = erow, srow, ecol, scol
  end

  if visual_line then
    return string.format("@%s:L%d-L%d", path, srow, erow)
  end
  return string.format("@%s:L%dC%d-L%dC%d", path, srow, scol, erow, ecol)
end

-- Type text into pi's prompt without submitting (no trailing CR).
local function type_into_pi(text)
  if not pi.job_id then
    return false
  end
  vim.fn.chansend(pi.job_id, text)
  return true
end

-- Type the reference followed by a space, then press <Esc> to dismiss pi's
-- @-mention completion popup while keeping the typed path.
local function deliver(ref)
  type_into_pi(ref .. " ")
  vim.defer_fn(function()
    type_into_pi("\27") -- <Esc>
  end, 100)
end

function M.send_reference()
  -- Read the reference while we are still in the source buffer/selection.
  local ref = build_reference()

  -- Leave visual mode (back to normal) now that the selection has been read.
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "\22" then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  end

  if not ref then
    return
  end

  -- If the pi process isn't running, don't spawn or open anything — just tell
  -- the user to start it. Otherwise send the reference straight to the process
  -- without changing the window's open/hidden state.
  if not running then
    vim.notify("pi: agent not running — press <C-.> to open it first", vim.log.levels.WARN)
    return
  end

  deliver(ref)
end

return M
