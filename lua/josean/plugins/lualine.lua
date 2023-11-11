return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      icons_enabled = false,
      theme = "onedark",
      component_separators = "|",
      section_separators = "",
    },
  },
  -- configure lualine with modified theme
}