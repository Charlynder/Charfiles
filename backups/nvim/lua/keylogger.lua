-- Neovim Statusline Keylogger
-- Save this as ~/.config/nvim/lua/keylogger.lua

local M = {}

-- Configuration
M.config = {
    max_keys = 20,     -- Maximum number of keys to display
    timeout = 3000,    -- Clear keys after 3 seconds of inactivity (ms)
    show_special = true, -- Show special keys like <CR>, <ESC>
    show_counts = true, -- Show counts like "3j" instead of "jjj"
}

-- State
local key_buffer = {}
local last_key_time = 0
local timer = nil

-- Function to clear old keys
local function clear_keys()
    key_buffer = {}
    vim.cmd('redrawstatus')
end

-- Function to format key for display
local function format_key(key)
    -- Replace special characters with readable names
    local special_keys = {
        ['\r'] = '<CR>',
        ['\n'] = '<CR>',
        ['\27'] = '<ESC>',
        [' '] = '<Space>',
        ['\t'] = '<Tab>',
    }

    return special_keys[key] or key
end

-- Function to add key to buffer
local function log_key(key)
    local current_time = vim.loop.now()

    -- Clear buffer if timeout exceeded
    if current_time - last_key_time > M.config.timeout then
        key_buffer = {}
    end

    last_key_time = current_time

    -- Format and add key
    local formatted_key = format_key(key)

    -- Combine consecutive identical keys if show_counts is enabled
    if M.config.show_counts and #key_buffer > 0 then
        local last_entry = key_buffer[#key_buffer]
        local last_key = last_entry:match("^(%d*)(.+)$")
        local count = tonumber(last_entry:match("^(%d+)")) or 1

        if last_entry:match("[^%d]+$") == formatted_key then
            key_buffer[#key_buffer] = (count + 1) .. formatted_key
            vim.cmd('redrawstatus')
            return
        end
    end

    table.insert(key_buffer, formatted_key)

    -- Limit buffer size
    if #key_buffer > M.config.max_keys then
        table.remove(key_buffer, 1)
    end

    -- Reset timer
    if timer then
        timer:stop()
        timer:close()
    end

    timer = vim.loop.new_timer()
    timer:start(M.config.timeout, 0, vim.schedule_wrap(clear_keys))

    vim.cmd('redrawstatus')
end

-- Get the key buffer as a string
function M.get_keys()
    return table.concat(key_buffer, '')
end

-- Setup function
function M.setup(opts)
    -- Merge user config
    if opts then
        M.config = vim.tbl_extend('force', M.config, opts)
    end

    -- Set up autocommand to capture keys
    vim.on_key(function(key)
        -- Filter out some keys you might not want to log
        if key == '' or key == '\128' then
            return
        end

        log_key(key)
    end, vim.api.nvim_create_namespace('keylogger'))

    -- Add to statusline
    -- You can customize this format
    vim.o.statusline = vim.o.statusline .. ' %{luaeval("require(\'keylogger\').get_keys()")}'
end

-- Clear the key buffer manually
function M.clear()
    clear_keys()
end

return M
