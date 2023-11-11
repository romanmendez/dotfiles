return {
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
  {
    "rockyzhang24/arctic.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    name = "arctic",
    branch = "main",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme arctic")
    end,
  },
}
