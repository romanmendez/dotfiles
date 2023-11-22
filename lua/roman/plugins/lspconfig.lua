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
      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

      opts.desc = "[G]o to [D]efinition"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

      opts.desc = "[G]o to [R]eferences"
      keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- show lsp definitions

      opts.desc = "[G]o to [I]mplementation"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

      opts.desc = "[G]o to [T]ype definition"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

      opts.desc = "[C]ode [A]ctions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

      opts.desc = "[R]e[n]ame"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

      opts.desc = "[B]uffer [D]iagnostics"
      keymap.set("n", "<leader>bd", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

      opts.desc = "[L]ine [D]iagnostics"
      keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts) -- show diagnostics for line

      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

      opts.desc = "Go to next diagnostic"
      keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

      opts.desc = "[B]uffer [F]ormat"
      keymap.set("n", "<leader>bf", vim.lsp.buf.format, opts) -- mapping to restart lsp if necessary
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

-- return {
--   {
--     "williamboman/mason.nvim",
--     dependencies = {
--       "williamboman/mason-lspconfig.nvim",
--       "WhoIsSethDaniel/mason-tool-installer.nvim",
--     },
--     config = function()
--       -- import mason
--       local mason = require("mason")
--
--       -- import mason-lspconfig
--       local mason_lspconfig = require("mason-lspconfig")
--
--       local mason_tool_installer = require("mason-tool-installer")
--
--       -- enable mason and configure icons
--       mason.setup({
--         ui = {
--           icons = {
--             package_installed = "✓",
--             package_pending = "➜",
--             package_uninstalled = "✗",
--           },
--         },
--       })
--
--       mason_lspconfig.setup({
--         -- list of servers for mason to install
--         ensure_installed = {
--           "tsserver",
--           "html",
--           "cssls",
--           "tailwindcss",
--           "svelte",
--           "lua_ls",
--           "graphql",
--           "emmet_ls",
--           "prismals",
--           "pyright",
--         },
--         -- auto-install configured servers (with lspconfig)
--         automatic_installation = true, -- not the same as ensure_installed
--       })
--
--       mason_tool_installer.setup({
--         ensure_installed = {
--           "prettier", -- prettier formatter
--           "stylua", -- lua formatter
--           "isort", -- python formatter
--           "black", -- python formatter
--           "pylint", -- python linter
--           "eslint_d", -- js linter
--         },
--       })
--     end,
--   },
--   {
--     "neovim/nvim-lspconfig",
--     event = { "BufReadPre", "BufNewFile" },
--     dependencies = {
--       "williamboman/mason.nvim",
--       "williamboman/mason-lspconfig.nvim",
--       "hrsh7th/cmp-nvim-lsp",
--       { "antosha417/nvim-lsp-file-operations", config = true },
--     },
--     config = function()
--       -- import lspconfig plugin
--       local lspconfig = require("lspconfig")
--
--       -- import cmp-nvim-lsp plugin
--       local cmp_nvim_lsp = require("cmp_nvim_lsp")
--
--       local keymap = vim.keymap -- for conciseness
--
--       local opts = { noremap = true, silent = true }
--       local on_attach = function(_, bufnr)
--         opts.buffer = bufnr
--
--         -- set keybinds
--         opts.desc = "Show LSP references"
--         keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
--
--         opts.desc = "Go to declaration"
--         keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
--
--         opts.desc = "Show LSP definitions"
--         keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions
--
--         opts.desc = "Show LSP implementations"
--         keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations
--
--         opts.desc = "Show LSP type definitions"
--         keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions
--
--         opts.desc = "See available code actions"
--         keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
--
--         opts.desc = "Smart rename"
--         keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename
--
--         opts.desc = "Show buffer diagnostics"
--         keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
--
--         opts.desc = "Show line diagnostics"
--         keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
--
--         opts.desc = "Go to previous diagnostic"
--         keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
--
--         opts.desc = "Go to next diagnostic"
--         keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
--
--         opts.desc = "Show documentation for what is under cursor"
--         keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
--
--         opts.desc = "Restart LSP"
--         keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
--       end
--
--       -- used to enable autocompletion (assign to every lsp server config)
--       local capabilities = cmp_nvim_lsp.default_capabilities()
--
--       -- configure html server
--       lspconfig["html"].setup({
--         capabilities = capabilities,
--         on_attach = on_attach,
--       })
--
--       -- configure typescript server with plugin
--       lspconfig["tsserver"].setup({
--         capabilities = capabilities,
--         on_attach = on_attach,
--       })
--
--       -- configure css server
--       lspconfig["cssls"].setup({
--         capabilities = capabilities,
--         on_attach = on_attach,
--       })
--
--       -- configure tailwindcss server
--       lspconfig["tailwindcss"].setup({
--         capabilities = capabilities,
--         on_attach = on_attach,
--       })
--
--       -- configure svelte server
--       lspconfig["svelte"].setup({
--         capabilities = capabilities,
--         on_attach = function(client, bufnr)
--           on_attach(client, bufnr)
--
--           vim.api.nvim_create_autocmd("BufWritePost", {
--             pattern = { "*.js", "*.ts" },
--             callback = function(ctx)
--               if client.name == "svelte" then
--                 client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
--               end
--             end,
--           })
--         end,
--       })
--
--       -- configure prisma orm server
--       lspconfig["prismals"].setup({
--         capabilities = capabilities,
--         on_attach = on_attach,
--       })
--
--       -- configure graphql language server
--       lspconfig["graphql"].setup({
--         capabilities = capabilities,
--         on_attach = on_attach,
--         filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
--       })
--
--       -- configure emmet language server
--       lspconfig["emmet_ls"].setup({
--         capabilities = capabilities,
--         on_attach = on_attach,
--         filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
--       })
--
--       -- configure python server
--       lspconfig["pyright"].setup({
--         capabilities = capabilities,
--         on_attach = on_attach,
--       })
--
--       -- configure lua server (with special settings)
--       lspconfig["lua_ls"].setup({
--         capabilities = capabilities,
--         on_attach = on_attach,
--         settings = { -- custom settings for lua
--           Lua = {
--             -- make the language server recognize "vim" global
--             diagnostics = {
--               globals = { "vim" },
--             },
--             workspace = {
--               -- make language server aware of runtime files
--               library = {
--                 [vim.fn.expand("$VIMRUNTIME/lua")] = true,
--                 [vim.fn.stdpath("config") .. "/lua"] = true,
--               },
--             },
--           },
--         },
--       })
--     end,
--   },
-- }
