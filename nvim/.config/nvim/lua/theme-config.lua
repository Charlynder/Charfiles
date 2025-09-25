-- Mirror Ghostty theme in Neovim (best-effort)
-- Reads Ghostty's config to detect the selected theme and applies
-- a matching Neovim colorscheme if its plugin is available.

local M = {}

local function read_ghostty_theme()
  local home = vim.loop.os_homedir()
  local xdg = os.getenv("XDG_CONFIG_HOME") or (home .. "/.config")
  local candidates = {
    home .. "/Library/Application Support/com.mitchellh.ghostty/config", -- macOS default
    xdg .. "/ghostty/config", -- Linux/Unix default
  }

  for _, path in ipairs(candidates) do
    local f = io.open(path, "r")
    if f then
      for line in f:lines() do
        -- match lines like: theme = "Catppuccin Mocha" OR theme = Tokyonight Storm
        local name = line:match("^%s*theme%s*=%s*\"([^\"]+)\"%s*$")
          or line:match("^%s*theme%s*=%s*([^#;]+)")
        if name then
          name = vim.trim(name)
          f:close()
          return name
        end
      end
      f:close()
    end
  end
  return nil
end

local function colorscheme_safe(name)
  local ok, err = pcall(vim.cmd.colorscheme, name)
  if not ok then
    vim.schedule(function()
      vim.notify("Failed to set colorscheme '" .. name .. "': " .. tostring(err), vim.log.levels.WARN)
    end)
  end
  return ok
end

local function apply_from_name(theme_name)
  if not theme_name or theme_name == "" then
    return false
  end
  local n = theme_name:lower()

  -- Catppuccin
  if n:find("catppuccin", 1, true) then
    local flavour = nil
    if n:find("mocha", 1, true) then flavour = "mocha" end
    if n:find("latte", 1, true) then flavour = "latte" end
    if n:find("macchiato", 1, true) then flavour = "macchiato" end
    if n:find("frapp", 1, true) then flavour = "frappe" end
    if flavour then vim.g.catppuccin_flavour = flavour end
    return colorscheme_safe("catppuccin")
  end

  -- Tokyonight
  if n:find("tokyonight", 1, true) then
    local style = nil
    if n:find("storm", 1, true) then style = "storm" end
    if n:find("night", 1, true) then style = "night" end
    if n:find("moon", 1, true) then style = "moon" end
    if n:find("day", 1, true) then style = "day" end
    if style then
      return colorscheme_safe("tokyonight-" .. style)
    else
      return colorscheme_safe("tokyonight")
    end
  end

  -- Gruvbox
  if n:find("gruvbox", 1, true) then
    if n:find("light", 1, true) then
      vim.o.background = "light"
    else
      vim.o.background = "dark"
    end
    return colorscheme_safe("gruvbox")
  end

  -- Rose Pine
  if n:find("rose[ %-]?pine") then
    -- Variants: main, moon, dawn. We default to main.
    return colorscheme_safe("rose-pine")
  end

  -- One Dark / One Light
  if n:find("one[ %-]?dark") or n:find("onedark") then
    return colorscheme_safe("onedark")
  end
  if n:find("one[ %-]?light") then
    -- onelight still maps to onedark with light style in the plugin; using base scheme
    vim.o.background = "light"
    return colorscheme_safe("onedark")
  end

  return false
end

function M.setup()
  local theme = read_ghostty_theme()
  if theme then
    apply_from_name(theme)
  end
end

-- Run immediately on load (safe if plugins missing; it will no-op with a warning)
M.setup()

return M
