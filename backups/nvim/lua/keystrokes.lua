-- Keystroke Visualizer for Neovim (floating window)
-- Save as ~/.config/nvim/lua/keystrokes.lua (or in your runtimepath)

local M = {}

-- Configuration
M.config = {
  max_keys = 20,       -- max number of keys to keep in buffer
  timeout = 3000,      -- clear after inactivity (ms)
  show_special = true, -- render readable names for special keys
  show_counts = true,  -- combine repeated keys as counts (e.g. 3j)
  win = {
    border = "rounded",
    row_offset = 2,    -- distance from bottom
    col_offset = 2,    -- distance from right
    zindex = 200,
    title = "Keys",
    title_pos = "right",
  },
}

-- State
local key_buffer = {}
local last_key_time = 0
local timer = nil
local buf = nil
local win = nil

-- Utils
local function close_window()
  if win and vim.api.nvim_win_is_valid(win) then
    pcall(vim.api.nvim_win_close, win, true)
  end
  win = nil
end

local function ensure_buf()
  if not (buf and vim.api.nvim_buf_is_valid(buf)) then
    buf = vim.api.nvim_create_buf(false, true)
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].filetype = "keystrokes"
  end
  return buf
end

local function format_key(key)
  local special = {
    ["\r"] = "<CR>",
    ["\n"] = "<CR>",
    ["\27"] = "<ESC>",
    [" "] = "<Space>",
    ["\t"] = "<Tab>",
    ["\8"] = "<BS>",
  }
  return special[key] or key
end

local function key_text()
  return table.concat(key_buffer, "")
end

local function update_display()
  local txt = key_text()
  if txt == "" then
    close_window()
    return
  end

  local b = ensure_buf()
  local line = " " .. txt .. " "
  vim.api.nvim_buf_set_lines(b, 0, -1, false, { line })

  local width = math.min(vim.o.columns, vim.fn.strdisplaywidth(line))
  local height = 1

  local opts = {
    relative = "editor",
    anchor = "SE",
    row = vim.o.lines - (M.config.win.row_offset or 2),
    col = vim.o.columns - (M.config.win.col_offset or 2),
    width = width,
    height = height,
    style = "minimal",
    focusable = false,
    border = M.config.win.border or "rounded",
    zindex = M.config.win.zindex or 200,
    noautocmd = true,
    title = M.config.win.title,
    title_pos = M.config.win.title_pos,
  }

  if win and vim.api.nvim_win_is_valid(win) then
    pcall(vim.api.nvim_win_set_config, win, opts)
    vim.api.nvim_win_set_buf(win, b)
  else
    win = vim.api.nvim_open_win(b, false, opts)
  end
end

local function clear_keys()
  key_buffer = {}
  update_display()
end

local function add_key(key)
  local now = vim.loop.now()
  if now - last_key_time > M.config.timeout then
    key_buffer = {}
  end
  last_key_time = now

  local k = format_key(key)

  if M.config.show_counts and #key_buffer > 0 then
    local last = key_buffer[#key_buffer]
    local count = tonumber(last:match("^(%d+)")) or 1
    local last_key = last:match("[^%d]+$") or last
    if last_key == k then
      key_buffer[#key_buffer] = (count + 1) .. k
    else
      table.insert(key_buffer, k)
    end
  else
    table.insert(key_buffer, k)
  end

  if #key_buffer > M.config.max_keys then
    table.remove(key_buffer, 1)
  end

  if timer then
    timer:stop()
    timer:close()
  end
  timer = vim.loop.new_timer()
  timer:start(M.config.timeout, 0, vim.schedule_wrap(clear_keys))

  update_display()
end

function M.get_keys()
  return key_text()
end

function M.setup(opts)
  if opts then
    M.config = vim.tbl_extend("force", M.config, opts)
  end

  vim.on_key(function(key)
    if key == "" or key == "\128" then
      return
    end
    add_key(key)
  end, vim.api.nvim_create_namespace("keystrokes"))
end

function M.clear()
  clear_keys()
end

return M
