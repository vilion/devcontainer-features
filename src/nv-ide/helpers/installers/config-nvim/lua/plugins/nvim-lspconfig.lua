local M = {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "hrsh7th/cmp-nvim-lsp" },
    {
      "SmiteshP/nvim-navbuddy",
      dependencies = {
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim"
      },
      opts = { lsp = { auto_attach = true } }
    }
  },
}

local tbl_isempty = vim.tbl_isempty

function M.has_capability(capability, filter)
  local clients = vim.lsp.get_active_clients(filter)
  return not tbl_isempty(vim.tbl_map(function(client) return client.server_capabilities[capability] end, clients))
end

local function del_buffer_autocmd(augroup, bufnr)
  local cmds_found, cmds = pcall(vim.api.nvim_get_autocmds, { group = augroup, buffer = bufnr })
  if cmds_found then vim.tbl_map(function(cmd) vim.api.nvim_del_autocmd(cmd.id) end, cmds) end
end

local function add_buffer_autocmd(augroup, bufnr, autocmds)
  if not vim.tbl_islist(autocmds) then autocmds = { autocmds } end
  local cmds_found, cmds = pcall(vim.api.nvim_get_autocmds, { group = augroup, buffer = bufnr })
  if not cmds_found or vim.tbl_isempty(cmds) then
    vim.api.nvim_create_augroup(augroup, { clear = false })
    for _, autocmd in ipairs(autocmds) do
      local events = autocmd.events
      autocmd.events = nil
      autocmd.group = augroup
      autocmd.buffer = bufnr
      vim.api.nvim_create_autocmd(events, autocmd)
    end
  end
end

function M.on_attach(client, bufnr)
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.lsp.commands["rubyLsp.openFile"] = function(command)
    print("rubyLsp.openFile called") -- デバッグ用メッセージ
    if not command.arguments or not command.arguments[1] then
      vim.notify("No arguments provided for rubyLsp.openFile", vim.log.levels.ERROR)
      return
    end

    -- URIを取得
    local uris = command.arguments[1]
    if not uris or #uris == 0 then
      vim.notify("No URIs provided for rubyLsp.openFile", vim.log.levels.ERROR)
      return
    end

    -- ファイル選択のプロンプトを表示
    vim.ui.select(uris, {
      prompt = 'Select a file to open:',
      format_item = function(uri)
        return vim.uri_to_fname(uri)
      end,
    }, function(selected_uri)
      if not selected_uri then
        vim.notify("No file selected", vim.log.levels.WARN)
        return
      end

      local bufnr = vim.uri_to_bufnr(selected_uri)
      vim.api.nvim_buf_set_option(bufnr, 'buflisted', true)
      vim.api.nvim_set_current_buf(bufnr)
    end)
  end

  vim.lsp.commands["rubyLsp.runTest"] = function(command)
    if not command.arguments or not command.arguments[1] then
      vim.notify("No arguments provided for rubyLsp.runTest", vim.log.levels.ERROR)
      return
    end

    local test_name = command.arguments[1]
    local cmd = { "bundle", "exec", "rspec", test_name }

    vim.fn.jobstart(cmd, {
      on_stdout = function(_, data)
        for _, line in ipairs(data) do
          print(line)
        end
      end,
      on_stderr = function(_, data)
        for _, line in ipairs(data) do
          vim.notify(line, vim.log.levels.ERROR)
        end
      end,
      on_exit = function(_, code)
        if code == 0 then
          vim.notify("Test passed", vim.log.levels.INFO)
        else
          vim.notify("Test failed", vim.log.levels.ERROR)
        end
      end,
    })
  end

  vim.api.nvim_buf_create_user_command(bufnr, "ShowRubyDeps", function(opts)
      local params = vim.lsp.util.make_text_document_params()
      local showAll = opts.args == "all"

      client.request("rubyLsp/workspace/dependencies", params, function(error, result)
        if error then
          print("Error showing deps: " .. error)
          return
        end

        local qf_list = {}
        for _, item in ipairs(result) do
          if showAll or item.dependency then
            table.insert(qf_list, {
              text = string.format("%s (%s) - %s", item.name, item.version, item.dependency),
              filename = item.path
            })
          end
        end

        vim.fn.setqflist(qf_list)
        vim.cmd('copen')
      end, bufnr)
    end,
    { nargs = "?", complete = function() return { "all" } end }
  )
  local navic = require("nvim-navic")
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<space>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, bufopts)
  -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  -- vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  -- vim.keymap.set('n', '<space>gW', vim.lsp.buf.workspace_symbol, bufopts)
  -- vim.keymap.set('n', '<space>ds', vim.lsp.buf.document_symbol, bufopts)

  vim.api.nvim_buf_create_user_command(bufnr, "RunCodeLensAction", function()
    local codelens = vim.lsp.codelens.get(bufnr)
    if not codelens or vim.tbl_isempty(codelens) then
      print("No CodeLens actions available")
      return
    end

    vim.ui.select(codelens, {
      prompt = 'Select a CodeLens action to run:',
      format_item = function(item)
        return item.command.title
      end,
    }, function(selected_action)
      if not selected_action then
        print("No action selected")
        return
      end

      print(vim.inspect(selected_action.command)) -- デバッグ用: commandの内容を表示

      -- デバッグ用メッセージ
      print("Executing command: " .. selected_action.command.command)

      -- コマンドを実行
      local success, err = pcall(vim.lsp.buf.execute_command, selected_action.command)

      -- デバッグ用メッセージ
      if success then
        print("Command executed successfully")
      else
        print("Error executing command: " .. err)
      end
    end)
  end, { desc = "Select and run a CodeLens action" })

  if client.server_capabilities.documentSymbolProvider then
    -- if not navic.is_attached(bufnr) then
    if client.name ~= "solargraph" then
      navic.attach(client, bufnr)
    end
    -- end
  end
  client.server_capabilities.documentFormattingProvider = true
  if client.supports_method("textDocument/codeLens") then
    local silent_refresh = function()
      local _notify = vim.notify
      vim.notify = function() end
      pcall(vim.lsp.codelens.refresh)
      vim.notify = _notify
    end

    local group = vim.api.nvim_create_augroup("lsp_codelens_refresh", { clear = true })
    vim.api.nvim_create_autocmd({ "InsertLeave", "BufEnter", "CursorHold" }, {
      group = group,
      buffer = bufnr,
      callback = function()
        if not client.supports_method("textDocument/codeLens") then
          vim.api.nvim_del_augroup_by_name("lsp_codelens_refresh")
          return
        end
        silent_refresh()
      end,
    })

    silent_refresh()
  end
  if client.server_capabilities.codeActionProvider and client.name ~= 'none-ls' then
    local kinds = {}
    if type(client.server_capabilities.codeActionProvider) == "table" and client.server_capabilities.codeActionProvider.codeActionKinds then
      for _, kind in ipairs(client.server_capabilities.codeActionProvider.codeActionKinds) do
        table.insert(kinds, kind)
      end
    end
    require("navigator.codeAction").code_action_prompt(bufnr, kinds)
  end
  require("navigator.lspclient.mapping").setup({ client = client, bufnr = bufnr }) -- setup navigator keymaps here,
  require("navigator.dochighlight").documentHighlight(bufnr)
end

function M.config()
  local lspconfig = require("lspconfig")
  local mason_lspconfig = require("mason-lspconfig")
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    -- lineFoldingOnly = true
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

  local slim_lint = require('efmls-configs.linters.slim_lint')

  require("mason").setup({
    ui = {
      border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
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
      'ts_ls',
      'cssls',
      'dockerls',
      'jsonls',
      'vimls',
      'rust_analyzer',
      'clangd',
      'pyright',
      'bashls',
      'svelte',
      'tailwindcss',
      'eslint',
      'graphql',
      'phpactor',
      'terraformls',
      'kotlin_language_server',
      'elixirls',
      'volar',
      'jdtls',
      'marksman',
      'angularls',
      'lua_ls',
      'prismals',
      'solang',
      -- 'solargraph',
      'ruby_lsp',
      'rubocop',
      'efm'
    },
  }

  mason_lspconfig.setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
      if server_name == "tsserver" then
        server_name = "ts_ls"
      end
      lspconfig[server_name].setup {
        on_attach = M.on_attach,
        capabilities,
      }
    end,
    ["html"] = function()
      lspconfig.html.setup({
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "html" }
      })
    end,
    -- ["solargraph"] = function()
    --   lspconfig.solargraph.setup({
    --     on_attach = M.on_attach,
    --     cmd = { "bundle", "exec", "solargraph", "stdio" },
    --     capabilities,
    --     settings = {
    --       solargraph = {
    --         completion = false,
    --         hover = false,
    --         symbols = false,
    --         references = true,
    --         rename = false,
    --         formatting = false,
    --         diagnostics = false,
    --         codeActions = false,
    --         foldingRange = false,
    --         selectionRange = false,
    --         documentHighlight = false,
    --         documentLink = false,
    --         documentSymbol = false,
    --         workspaceSymbol = false,
    --         codeLens = false,
    --         semanticTokens = false,
    --         inlayHints = false,
    --         callHierarchy = true,
    --         linkedEditingRange = false,
    --         typeHierarchy = false,
    --         inlineValue = false,
    --         moniker = true,
    --         declaration = false,
    --         definition = false,
    --         typeDefinition = false,
    --         implementation = false,
    --         signatureHelp = false,
    --         hoverProvider = false,
    --         completionProvider = {
    --           triggerCharacters = { ".", ":", ">", "<", "=", "-", "(", "[", "{", " " },
    --           resolveProvider = false,
    --         },
    --         documentFormattingProvider = false,
    --         documentRangeFormattingProvider = false,
    --         documentOnTypeFormattingProvider = {
    --           firstTriggerCharacter = ";",
    --           moreTriggerCharacter = { "}", "]", ")" },
    --         },
    --         renameProvider = {
    --           prepareProvider = false,
    --         },
    --         codeActionProvider = {
    --           codeActionKinds = { "quickfix", "refactor", "source.organizeImports" },
    --         },
    --         executeCommandProvider = false,
    --         workspace = {
    --           workspaceFolders = {
    --             supported = false,
    --             changeNotifications = false,
    --           },
    --         },
    --         experimental = {},
    --       }
    --     }
    --   })
    -- end,
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
              vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
            end
          }
        }
      })
    end,
    ["ruby_lsp"] = function()
      local util = require("lspconfig.util")
      lspconfig.ruby_lsp.commands = {
        FormatRuby = {
          function()
            vim.lsp.buf.format({
              name = "ruby_lsp",
              async = true,
            })
          end,
          description = "Format using ruby-lsp",
        },
      }
      lspconfig.ruby_lsp.setup({
        cmd = { "/usr/local/bundle/gems/ruby-lsp-0.20.1/exe/ruby-lsp" },
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "ruby", "erb" },
        root_dir = util.root_pattern("Gemfile", ".git"),
        init_options = {
          enabledFeatures = {
            "codeActions",
            "codeLens",
            "completion",
            "definition",
            "diagnostics",
            "documentHighlights",
            "documentLink",
            "documentSymbols",
            "foldingRanges",
            "formatting",
            "hover",
            "inlayHint",
            "onTypeFormatting",
            "selectionRanges",
            "semanticHighlighting",
            "signatureHelp",
            "typeHierarchy",
            "workspaceSymbol",
            "references"
          }
        }
      })
    end,
    ["pyright"] = function()
      lspconfig.pyright.setup({
        on_attach = M.on_attach,
        capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "strict",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true
            }
          }
        }
      })
    end,
    ["lua_ls"] = function()
      lspconfig.lua_ls.setup({
        on_attach = M.on_attach,
        capabilities,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
    end,
    ["bashls"] = function()
      lspconfig.bashls.setup({
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "sh", "bash" },
        settings = {
          bash = {
            explainShell = {
              enable = true
            }
          }
        }
      })
    end,
    ["cssls"] = function()
      lspconfig.cssls.setup({
        on_attach = M.on_attach,
        capabilities,
        settings = {
          css = {
            validate = true,
          },
          less = {
            validate = true,
          },
          scss = {
            validate = true,
          },
        },
      })
    end,
    ["css_variables"] = function()
      lspconfig.css_variables.setup({
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "css", "scss", "less" },
        settings = {
          css = {
            validate = true,
          },
          less = {
            validate = true,
          },
          scss = {
            validate = true,
          },
        },
      })
    end,
    ["cssmodules_ls"] = function()
      lspconfig.cssmodules_ls.setup({
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "css", "scss", "less" },
        settings = {
          cssmodules = {
            validate = true,
          },
        },
      })
    end,
    ["rubocop"] = function()
      lspconfig.rubocop.setup({
        cmd = { "bundle", "exec", "rubocop", "--lsp" },
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "ruby", "erb" },
        settings = {
          rubocop = {
            diagnostics = {
              enable = true,
            },
            lint = {
              enabled = true,
            },
            completion = {
              enabled = true,
            },
            hover = {
              enabled = true,
            },
          },
        },
      })
    end,
    ["sqlls"] = function()
      lspconfig.sqlls.setup({
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "sql" },
        settings = {
          sql = {
            lint = {
              enabled = true,
            },
            format = {
              enabled = true,
            },
          },
        },
      })
    end,
    ["dockerls"] = function()
      lspconfig.dockerls.setup({
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "Dockerfile", "dockerfile" },
        settings = {
          docker = {
            languageserver = {
              diagnostics = {
                enabled = true,
              },
            },
          },
        },
      })
    end,
    ["yamlls"] = function()
      lspconfig.yamlls.setup({
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "yaml", "yaml.ansible", "ansible" },
        settings = {
          yaml = {
            hover = true,
            completion = true,
            validate = true,
          },
        },
      })
    end,
    ["ts_ls"] = function()
      lspconfig.ts_ls.setup({
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "tsx", "typescript", "typescriptreact", "typescript.tsx" },
        cmd = { "typescript-language-server", "--stdio" },
        settings = {
          completions = {
            completeFunctionCalls = true
          }
        }
      })
    end,
    ["svelte"] = function()
      lspconfig.svelte.setup({
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "svelte" },
        settings = {
          svelte = {
            plugin = {
              svelte = {
                enable = true,
              },
              css = {
                enable = true,
              },
              html = {
                enable = true,
              },
              javascript = {
                enable = true,
              },
              typescript = {
                enable = true,
              },
            },
          },
        },
      })
    end,
    ["tailwindcss"] = function()
      lspconfig.tailwindcss.setup({
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
        settings = {
          tailwindCSS = {
            lint = {
              cssConflict = "warning",
              invalidApply = "error",
              invalidScreen = "error",
              invalidVariant = "error",
              invalidConfigPath = "error"
            },
            experimental = {
              classRegex = {
                "tw`([^`]*)",
                "tw\\(([^)]*)\\)",
                "tw\\.\\w+`([^`]*)",
                "tw\\(.*?\\)`([^`]*)"
              }
            }
          }
        }
      })
    end,
    ["eslint"] = function()
      lspconfig.eslint.setup({
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        settings = {
          codeAction = {
            disableRuleComment = {
              enable = true,
              location = "separateLine"
            },
            showDocumentation = {
              enable = true
            }
          },
          format = true,
          lintTask = {
            enable = true
          },
          packageManager = "npm",
          quiet = false,
          run = "onType",
          useESLintClass = false,
          validate = "on",
          workingDirectory = {
            mode = "location"
          }
        }
      })
    end,
    ["graphql"] = function()
      lspconfig.graphql.setup({
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "graphql", "typescriptreact", "javascriptreact" },
        settings = {
          graphql = {
            validate = true,
            completion = true,
            hover = true,
          },
        },
      })
    end,
    ["phpactor"] = function()
      lspconfig.phpactor.setup({
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "php" },
        settings = {
          phpactor = {
            completion = {
              insertUse = true,
            },
            diagnostics = {
              enable = true,
            },
            indexer = {
              enabled = true,
            },
          },
        },
      })
    end,
    ["terraformls"] = function()
      lspconfig.terraformls.setup({
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "terraform", "tf" },
        settings = {
          terraform = {
            validate = true,
          },
        },
      })
    end,
    ["kotlin_language_server"] = function()
      lspconfig.kotlin_language_server.setup({
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "kotlin" },
        cmd = { "kotlin-language-server" },
        settings = {
          kotlin = {
            linting = {
              enabled = true,
            },
            completion = {
              enabled = true,
            },
            hover = {
              enabled = true,
            },
          },
        },
      })
    end,
    ["elixirls"] = function()
      lspconfig.elixirls.setup({
        on_attach = M.on_attach,
        capabilities,
        cmd = { "elixir-ls" },
        settings = {
          elixirLS = {
            dialyzerEnabled = true,
            fetchDeps = false,
            enableTestLenses = true,
          },
        },
      })
    end,
    ["volar"] = function()
      lspconfig.volar.setup({
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "vue" },
        settings = {
          volar = {
            codeLens = {
              references = true,
              pugTools = true,
            },
            completion = {
              autoImport = true,
              tagCasing = "kebab",
              useScaffoldSnippets = true,
            },
            format = {
              enable = true,
            },
            validation = {
              template = true,
              style = true,
              script = true,
            },
          },
        },
      })
    end,
    ["jdtls"] = function()
      lspconfig.jdtls.setup({
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "java" },
        cmd = { "jdtls" },
        settings = {
          java = {
            format = {
              enabled = true,
            },
            completion = {
              enabled = true,
            },
            hover = {
              enabled = true,
            },
          },
        },
      })
    end,
    ["marksman"] = function()
      lspconfig.marksman.setup({
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "markdown" },
        settings = {
          marksman = {
            lint = {
              enabled = true,
            },
            completion = {
              enabled = true,
            },
            hover = {
              enabled = true,
            },
          },
        },
      })
    end,
    ["angularls"] = function()
      lspconfig.angularls.setup({
        on_attach = M.on_attach,
        capabilities,
        filetypes = { "typescript", "html", "typescriptreact" },
        cmd = { "ngserver", "--stdio" },
        settings = {
          angular = {
            enableIvy = true,
            validate = true,
          },
        },
      })
    end,
    ["efm"] = function()
      print("Debugging efm setup")
      lspconfig.efm.setup({
        on_attach = M.on_attach,
        capabilities,
        init_options = { documentFormatting = true },
        settings = {
          languages = {
            slim = { slim_lint }
          }
        }
      })
    end
  }
  require("ufo").setup()
end

return M
