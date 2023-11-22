-- Tokyo Night
-- {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {},
--   config = function()
--     vim.cmd.colorscheme("tokyonight")
--     local tokyo = require("tokyonight")
--     tokyo.setup({
--       style = "night",
--     })
--     tokyo.load()
--   end,
-- },

-- VS Code Dark+ Theme
-- {
--   "rockyzhang24/arctic.nvim",
--   dependencies = { "rktjmp/lush.nvim" },
--   name = "arctic",
--   branch = "main",
--   priority = 1000,
--   config = function()
--     vim.cmd("colorscheme arctic")
--   end,
-- },

-- Theme inspired by Atom
return {
  "navarasu/onedark.nvim",
  priority = 1000,
  config = function()
    local onedark = require("onedark")
    onedark.setup({
      style = "deep",
    })
    onedark.load()
    vim.cmd.colorscheme("onedark")
  end,
}

-- Catppuccin
-- return {
--   "catppuccin/nvim",
--   name = "catppuccin",
--   priority = 1000,
--   config = function()
--     require("catppuccin").setup({
--       flavour = "macchiato", -- latte, frappe, macchiato, mocha
--       background = { -- :h background
--         light = "latte",
--         dark = "mocha",
--       },
--       transparent_background = false, -- disables setting the background color.
--       show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
--       term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
--       dim_inactive = {
--         enabled = false, -- dims the background color of inactive window
--         shade = "dark",
--         percentage = 0.15, -- percentage of the shade to apply to the inactive window
--       },
--       no_italic = false, -- Force no italic
--       no_bold = false, -- Force no bold
--       no_underline = false, -- Force no underline
--       styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
--         comments = { "italic" }, -- Change the style of comments
--         conditionals = { "italic" },
--         loops = {},
--         functions = {},
--         keywords = {},
--         strings = {},
--         variables = {},
--         numbers = {},
--         booleans = {},
--         properties = {},
--         types = {},
--         operators = {},
--       },
--       color_overrides = {},
--       custom_highlights = {},
--       integrations = {
--         cmp = true,
--         gitsigns = true,
--         nvimtree = true,
--         treesitter = true,
--         notify = false,
--         mini = {
--           enabled = true,
--           indentscope_color = "",
--         },
--         -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
--       },
--     })
--
--     -- setup must be called before loading
--     vim.cmd.colorscheme("catppuccin")
--   end,
-- }
