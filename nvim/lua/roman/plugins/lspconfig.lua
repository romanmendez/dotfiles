return {
  -- LSP Configuration & Plugins
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { "j-hui/fidget.nvim", tag = "legacy", opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    "folke/neodev.nvim",
  },
  config = function()
    local keymap = vim.keymap -- for conciseness

    local opts = { noremap = true, silent = true }
    local on_attach = function(_, bufnr)
      opts.buffer = bufnr

      -- set keybinds

      keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "[G]o to [D]efinition" })
      keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "[G]o to [R]eferences" })
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "[G]o to [I]mplementation" })
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "[G]o to [T]ype definition" })
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
      keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
      keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
      keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation for what is under cursor" })
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" })
      keymap.set("n", "<leader>bf", vim.lsp.buf.format, { desc = "[B]uffer [F]ormat" })
    end

    require("mason").setup()
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local lspconfig = require("lspconfig")
    local servers = {
      cssls = {},
      tailwindcss = {},
      graphql = {},
      prismals = {},
      tsserver = {},
      html = { filetypes = { "html", "twig", "hbs" } },
      sqlls = {},

      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    }

    -- Setup neovim lua configuration
    require("neodev").setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    -- Ensure the servers above are installed
    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        })
      end,
    })
  end,
}
