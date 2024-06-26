local M = {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "SmiteshP/nvim-navic" },
  },
}

function M.on_attach(client, bufnr)
  local navic = require("nvim-navic")
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

function M.config()
  local lspconfig = require("lspconfig")
  -- lspconfig.efm.setup({
  --   init_options = { documentFormatting = true },
  --   settings = {
  --     languages = {
  --       slim = {
  --         lintCommand = "slim-lint --stdin-file-path ${INPUT}",
  --         lintStdin = true,
  --         lintFormats = { '%f:%l [%t] %m' },
  --       }
  --     }
  --   }
  -- })
  local mason_lspconfig = require("mason-lspconfig")
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }
  vim.diagnostic.config({
    virtual_text = false,
  })


  -- Diagnostics symbols for display in the sign column.
  local signs = { Error = "", Warn = "", Hint = "", Info = "" }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  print 'mason'
  require("mason").setup({
    ui = {
      border = {"┏", "━", "┓", "┃", "┛", "━", "┗", "┃"},
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  })
  mason_lspconfig.setup {
    ensure_installed = {
      'html',
      'tsserver',
      'solargraph',
      'cssls',
      'dockerls',
      'jsonls',
      --[[ 'yamlls', ]]
      'vimls',
      'rust_analyzer',
      'clangd',
      'pyright',
      'bashls',
    },
  }
  mason_lspconfig.setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
      lspconfig[server_name].setup {
        on_attach = M.on_attach,
        capabilities,
      }
    end,
    --[[ ["yamlls"] = function() ]]
    --[[   lspconfig.yamlls.setup { ]]
    --[[     on_attach = M.on_attach, ]]
    --[[     capabilities, ]]
    --[[     filetypes = { ]]
    --[[       "yaml", "yaml.ansible", "ansible" ]]
    --[[     }, ]]
    --[[     settings = { ]]
    --[[       yaml = { ]]
    --[[         hover = true, ]]
    --[[         completion = true, ]]
    --[[         validate = true, ]]
    --[[       }, ]]
    --[[     }, ]]
    --[[   } ]]
    --[[ end, ]]
    ["html"] = function()
      lspconfig.html.setup({
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "html" }
      })
    end,
    ["solargraph"] = function()
      lspconfig.solargraph.setup({
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "ruby", "eruby" },
        cmd = {"bundle", "exec", "solargraph", "stdio"},
        settings = {
          solargraph = {
            useBundler = true,
            diagnostics = true,
            completion = true,
            hover = true,
            formatting = true,
            symbols = true,
            definitions = true,
            rename = true,
            references = true,
            folding = true
          }
        }
      })
    end,
    --[[ ["lua_ls"] = function() ]]
    --[[   lspconfig.lua_ls.setup({ ]]
    --[[ on_attach, ]]
    --[[ capabilities, ]]
    --[[     settings = { ]]
    --[[       Lua = { ]]
    --[[         runtime = { ]]
    --[[           -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim) ]]
    --[[           version = 'LuaJIT', ]]
    --[[         }, ]]
    --[[         diagnostics = { ]]
    --[[           -- Get the language server to recognize the `vim` global ]]
    --[[           globals = {'vim'}, ]]
    --[[         }, ]]
    --[[         workspace = { ]]
    --[[           -- Make the server aware of Neovim runtime files ]]
    --[[           library = vim.api.nvim_get_runtime_file("", true), ]]
    --[[         }, ]]
    --[[         -- Do not send telemetry data containing a randomized but unique identifier ]]
    --[[         telemetry = { ]]
    --[[           enable = false, ]]
    --[[         }, ]]
    --[[       }, ]]
    --[[     } ]]
    --[[   }) ]]
    --[[ end, ]]
    ["rust_analyzer"] = function(server_name)
      lspconfig.rust_analyzer.setup({
        on_attach = M.on_attach,
        capabilities,
        settings = {
          ["rust-analyzer"] = {
            assist = {
              importMergeBehavior = "last",
              importPrefix = "by_self",
            },
            diagnostics = {
              disabled = { "unresolved-import" }
            },
            cargo = {
              loadOutDirsFromCheck = true
            },
            procMacro = {
              enable = true
            },
            checkOnSave = {
              command = "clippy"
            },
          }
        }
      })
    end,
    ["jsonls"] = function(server_name)
      lspconfig.jsonls.setup({
        on_attach = M.on_attach,
        capabilities,
        commands = {
          Format = {
            function()
              vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
            end
          }
        }
      })
    end,
  }
  require("ufo").setup()
  local configs = require("lspconfig.configs")
  configs.dbt = {
    default_config = {
      cmd = { "dbt-language-server", "--stdio" },
      root_dir = require("lspconfig.util").root_pattern("dbt_project.yml", "dbt_project.yaml"),
      filetypes = { "sql", "yml" },
      init_options = {
        pythonInfo = {
          path = "python",
        },
        lspMode = "dbtProject",
        enableSnowflakeSyntaxCheck = true,
      },
    },
  }

  require("lspconfig").dbt.setup({
    on_attach = M.on_attach,
    capabilities
  })
end

return M
