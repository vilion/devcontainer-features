return {
  --[[ COLORSCHEME ]]
  {
    "folke/tokyonight.nvim",
    -- "loctvl842/monokai-pro.nvim",
    -- "rebelot/kanagawa.nvim",
    -- "sainnhe/gruvbox-material",
    -- "olimorris/onedarkpro.nvim",
    -- "projekt0n/github-nvim-theme",
    -- "Shatur/neovim-ayu",
    -- "scottmckendry/cyberdream.nvim",
    -- "e-q/okcolors.nvim", name = "okcolors",
    -- enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require('config.colorschemes.tokyonight')
      -- require('config.colorschemes.monokai_pro')
      -- require('config.colorschemes.kanagawa')
      -- require('config.colorschemes.gruvbox_material')
      -- require('config.colorschemes.cyberdream')
      -- vim.cmd [[colorscheme onedark]]
      -- vim.cmd [[colorscheme github_dark_dimmed]]
      -- vim.cmd [[colorscheme ayu-dark]]
      -- vim.cmd [[colorscheme okcolors-smooth]]
    end,
  },
  --[[ END COLORSCHEME ]]
  --[[ UI ]]
  {
    "nvim-lua/popup.nvim",
    lazy = false,
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
  },
  {
    "MunifTanjim/nui.nvim",
    lazy = false,
  },
  {
    "stevearc/dressing.nvim",
    lazy = false,
  },
  {
    "onsails/lspkind-nvim",
    lazy = false,
  },
  --[[ END UI ]]
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup({
        -- add any options here, or leave empty to use the default settings
      })
    end
  },
  {
    "hrsh7th/nvim-cmp",
    priority = 1000,
    lazy = false,
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-cmdline",
      "ray-x/cmp-treesitter",
      "lukas-reineke/cmp-rg",
      "quangnguyen30192/cmp-nvim-tags",
      "rafamadriz/friendly-snippets",
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        auto_install = true,
        ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          --[[ disable = { "embedded_template" } ]]
        },
        indent = {
          enable = true
        },
        matchup = {
          enable = true
        }
      }
    end,
  },
  {
    "luukvbaal/statuscol.nvim",
    lazy = false,
    config = function()
      require("statuscol").setup({
        separator = " ",
        setopt = true,
      })
    end
  },
  --{
  --  'lukas-reineke/indent-blankline.nvim',
  --  main = 'ibl',
  --  event = 'UIEnter',
  --  opts = {
  --    exclude = {
  --      -- stylua: ignore
  --      filetypes = {
  --        'dbout', 'neo-tree-popup', 'log', 'gitcommit',
  --        'txt', 'help', 'NvimTree', 'git', 'flutterToolsOutline',
  --        'undotree', 'markdown', 'norg', 'org', 'orgagenda',
  --      },
  --    },
  --    indent = {
  --      char = '│', -- ▏┆ ┊ 
  --      tab_char = '│',
  --    },
  --    scope = {
  --      char = '▎',
  --    },
  --  },
  --  config = function(_, opts)
  --    require('ibl').setup(opts)
  --    local hooks = require('ibl.hooks')
  --    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  --    hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
  --  end,
  --},
  {
    "AckslD/nvim-neoclip.lua",
    config = function()
      require("neoclip").setup()
    end
  },
  {
    "nacro90/numb.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("numb").setup {
        show_numbers = true,   -- Enable 'number' for the window while peeking
        show_cursorline = true -- Enable 'cursorline' for the window while peeking
      }
    end,
  },
  {
    'weizheheng/ror.nvim'
  },
  {
    "tpope/vim-rails",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "tpope/vim-abolish",
      "tpope/vim-bundler",
      "tpope/vim-endwise",
      "tpope/vim-dispatch",
    },
    config = function()
      -- disable autocmd set filetype=eruby.yaml
      vim.api.nvim_create_autocmd(
        { 'BufNewFile', 'BufReadPost' },
        {
          pattern = { '*.yml' },
          callback = function()
            vim.bo.filetype = 'yaml'
          end
        }
      )
    end
  },
  {
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "tpope/vim-repeat",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  -- {
  --   "ludovicchabant/vim-gutentags",
  --   lazy = false,
  --   config = function()
  --     vim.cmd('set tags+=tags,.git/tags')
  --     vim.g.gutentags_enabled = 1
  --     vim.g.gutentags_generate_on_missing = 1
  --     vim.g.gutentags_generate_on_write = 1
  --     vim.g.gutentags_resolve_symlinks = 1
  --     vim.g.gutentags_ctags_tagfile = '.git/tags'
  --     vim.g.gutentags_project_root = { '.git' }
  --     vim.g.gutentags_ctags_extra_args = { '--fields=+l' }
  --     vim.g.gutentags_add_default_project_roots = 0
  --     vim.g.gutentags_ctags_executable_ruby = 'ripper-tags'
  --     vim.g.gutentags_ctags_extra_args_ruby = { '--ignore-unsupported-options', '--recursive' }
  --     -- vim.g.gutentags_trace = 1
  --   end,
  -- },
  {
    "folke/todo-comments.nvim",
    event = 'VeryLazy',
    config = function()
      require("todo-comments").setup {}
    end,
  },
  {
    "folke/which-key.nvim",
    event = 'VeryLazy',
    config = function()
      require("which-key").setup({
        timeoutlen = 500,
        delay = 500,
        win = {
          border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
        },
      })
    end,
  },
  {
    "airblade/vim-rooter",
    lazy = false,
    config = function()
      vim.g.rooter_silent_chdir = 1
      vim.g.rooter_cd_cmd = 'lcd'
      vim.g.rooter_resolve_links = 1
      vim.g.rooter_patterns = { '.git', '.git/' }
    end,
  },
  {
    "jeffkreeftmeijer/vim-numbertoggle",
    lazy = false,
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = false,
        tmux = false,
        twilight = true,
      },
    },
  },
  {
    "lambdalisue/suda.vim",
    event = 'VeryLazy',
  },
  {
    "chrisbra/csv.vim",
    event = 'VeryLazy',
  },
  {
    "kazhala/close-buffers.nvim",
    event = 'VeryLazy',
  },
  {
    "folke/twilight.nvim",
    event = 'VeryLazy',
  },
  {
    "zdharma-continuum/zinit-vim-syntax",
    event = 'VeryLazy',
  },
  {
    "nvim-tree/nvim-web-devicons",
    event = 'VeryLazy',
  },
  {
    "chrisgrieser/nvim-spider",
    event = 'VeryLazy',
    keys = {
      {
        "w",
        "<cmd>lua require('spider').motion('w')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "e",
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "b",
        "<cmd>lua require('spider').motion('b')<CR>",
        mode = { "n", "o", "x" },
      },
    },
    config = function()
      require("spider").setup {
        skipInsignificantPunctuation = false,
      }
    end
  },
  {
    'MagicDuck/grug-far.nvim',
    event = 'VeryLazy',
    keys = {
      {
        "<leader>sr",
        "<cmd>lua require('grug-far').toggle_instance({ instanceName='far', staticTitle='Search and Replace' })<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "<leader>srw",
        "<cmd>lua require('grug-far').grug_far({ prefills = { search = vim.fn.expand('<cword>') } })<CR>",
        mode = { "n", "o", "x" },
      },
      -- I use nvim-rip-substitute for file search and replace
      -- {
      --   "<leader>srf",
      --   "<cmd>lua require('grug-far').grug_far({ prefills = { flags = vim.fn.expand('%') } })<CR>",
      --   mode = { "n", "o", "x" },
      -- },
    },
    config = function()
      require('grug-far').setup({
        -- startInInsertMode = false,
      });
    end
  },
  {
    "folke/trouble.nvim",
    event = 'VeryLazy',
    config = function()
      require('trouble').setup({
      })
    end
  },
  {
    "RRethy/vim-illuminate",
    event = 'VeryLazy',
  },
  {
    "folke/edgy.nvim",
    event = "BufReadPost",
    opts = {
      fix_win_height = vim.fn.has "nvim-0.10.0" == 0,
      options = {
        left = { size = 40 },
        bottom = { size = 10 },
        right = { size = 40 },
        top = { size = 10 },
      },
      right = {
      },
      bottom = {
        {
          ft = "spectre_panel",
          title = "SPECTRE",
          size = { height = 0.4 },
        },
        {
          ft = "toggleterm",
          title = "TERMINAL",
          size = { height = 0.4 },
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
        {
          ft = "Trouble",
          title = "TROUBLE",
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
        { ft = "qf", title = "QUICKFIX" },
        {
          ft = "noice",
          size = { height = 0.4 },
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
        {
          ft = "help",
          size = { height = 20 },
          -- only show help buffers
          filter = function(buf)
            return vim.bo[buf].buftype == "help"
          end,
        },
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        search = {
          incremental = true,
          enabled = true,
          jump = {
            autojump = false,
          },
        }
      }
    },
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'smoka7/hydra.nvim',
    },
    opts = function()
      local N = require 'multicursors.normal_mode'
      local I = require 'multicursors.insert_mode'
      return {
        normal_keys = {
          -- to change default lhs of key mapping change the key
          [','] = {
            -- assigning nil to method exits from multi cursor mode
            method = N.clear_others,
            -- you can pass :map-arguments here
            opts = { desc = 'Clear others' },
          },
        },
        insert_keys = {
          -- to change default lhs of key mapping change the key
          ['<CR>'] = {
            -- assigning nil to method exits from multi cursor mode
            method = I.Cr_method,
            -- you can pass :map-arguments here
            opts = { desc = 'New line' },
          },
        },
        hint_config = {
          border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
        },
        generate_hints = {
          normal = true,
          insert = true,
          extend = true,
        },
      }
    end,
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    keys = {
      {
        mode = { 'v', 'n' },
        '<Leader>mc',
        '<cmd>MCstart<cr>',
        desc = 'Create a selection for selcted text or word under the cursor',
      },
    },
  },
  {
    "otavioschwanck/arrow.nvim",
    event = 'VeryLazy',
    opts = {
      show_icons = true,
      leader_key = '-'
    }
  },
  {
    "ton/vim-bufsurf",
    event = 'VeryLazy'
  },
  {
    "brenoprata10/nvim-highlight-colors",
    event = 'VeryLazy',
    config = function()
      require('nvim-highlight-colors').setup({
        render = "virtual",
        virtual_symbol = '■',
        -- virtual_symbol = '',
        -- virtual_symbol = '',
        -- virtual_symbol = '󰉦',
      })
    end
  },
  {
    "sindrets/diffview.nvim",
    lazy = true,
    cmd = { "DiffviewOpen", "DiffviewClose" },
    keys = {
      {
        "<leader>gd",
        function()
          if next(require('diffview.lib').views) == nil then
            vim.cmd('DiffviewOpen')
          else
            vim.cmd(
              'DiffviewClose')
          end
        end,
        desc = "Git diff"
      },
    },
    config = function()
      require("diffview").setup({
        view = {
          file_history = {
            layout = "diff2_vertical",
          },
        },
      })
    end
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    config = function()
      require("marks").setup({})
    end
  },
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    lazy = false,
    enabled = true,
    config = function()
      require("hardtime").setup({
        disable_mouse = false,
      })
    end
  },
  {
    "gen740/SmoothCursor.nvim",
    event = "VeryLazy",
    config = function()
      require("smoothcursor").setup({
        disable_float_win = true,
        disabled_filetypes = { "TelescopePrompt" },
        cursor = "",
        texthl = "String",
      })
    end
  },
  {
    "FabijanZulj/blame.nvim",
    lazy = false,
    keys = {
      { "<leader>gb", "<cmd>BlameToggle virtual<CR>", desc = "Git blame" },
    },
    config = function()
      require("blame").setup()
    end
  },
  {
    "chrisgrieser/nvim-rip-substitute",
    lazy = "VeryLazy",
    keys = {
      {
        "<leader>srf",
        function() require("rip-substitute").sub() end,
        mode = { "n", "x" },
        desc = " rip substitute",
      },
    },
  },
  {
    "yetone/avante.nvim",
    lazy = false,
    -- event = "VeryLazy",
    version = false,
    opts = {
      provider = "openai",
      -- add any opts here
      -- openai = {
      --  model = "gpt-4o-mini"
      --}
    },
    build = "make",
    keys = {
      { "<leader>aa", function() require("avante.api").ask() end,     desc = "avante: ask",    mode = { "n", "v" } },
      { "<leader>ar", function() require("avante.api").refresh() end, desc = "avante: refresh" },
      { "<leader>ae", function() require("avante.api").edit() end,    desc = "avante: edit",   mode = "v" },
    },
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to setup it properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    "magicalne/nvim.ai",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      provider = "openai", -- You can configure your provider, model or keymaps here.
    }
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup({
        openai_params = {
          model = "gpt-4o-mini"
        },
        openai_edit_params = {
          model = "gpt-4o-mini"
        },
        use_openai_functions_for_edits = true,
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "folke/trouble.nvim",
    },
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    lazy = false,
    config = true
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
  },
  {
    "sindrets/diffview.nvim",
    lazy = false,
  },
  {
    "aaronhallaert/advanced-git-search.nvim",
    cmd = { "AdvancedGitSearch" },
    lazy = false,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- to show diff splits and open commits in browser
      "tpope/vim-fugitive",
      -- to open commits in browser with fugitive
      "tpope/vim-rhubarb",
      -- optional: to replace the diff from fugitive with diffview.nvim
      -- (fugitive is still needed to open in browser)
      "sindrets/diffview.nvim",
    },
  },
  {
    "rshkarin/mason-nvim-lint",
    event = 'VeryLazy',
    lazy = true,
    dependencies = { "mason.nvim", "mfussenegger/nvim-lint" },
    opts = {
      -- Event to trigger linters
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        sql = { "sqlfluff" },
        -- Use the "*" filetype to run linters on all filetypes.
        -- ['*'] = { 'global linter' },
        -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
        -- ['_'] = { 'fallback linter' },
      },
      linters = {}
    },
    config = function(_, opts)
      local M = {}

      local lint = require("lint")
      for name, linter in pairs(opts.linters) do
        if type(linter) == "table" and type(lint.linters[name]) == "table" then
          lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
        else
          lint.linters[name] = linter
        end
      end

      local rubocop = lint.linters.rubocop
      rubocop.cmd = 'bundle exec rubocop'
      rubocop.args = { '--lsp' }
      rubocop.stdin = false
      print(rubocop.cmd)
      print(rubocop.args[0])
      print(rubocop.args[1])
      print(rubocop.args[2])
      print(rubocop.args[3])
      print(rubocop.args[4])

      lint.linters_by_ft = opts.linters_by_ft

      function M.debounce(ms, fn)
        local timer = vim.loop.new_timer()
        return function(...)
          local argv = { ... }
          timer:start(ms, 0, function()
            timer:stop()
            vim.schedule_wrap(fn)(unpack(argv))
          end)
        end
      end

      function M.lint()
        local names = lint._resolve_linter_by_ft(vim.bo.filetype)

        -- Add fallback linters.
        if #names == 0 then
          vim.list_extend(names, lint.linters_by_ft["_"] or {})
        end

        -- Add global linters.
        vim.list_extend(names, lint.linters_by_ft["*"] or {})

        -- Filter out linters that don't exist or don't match the condition.
        local ctx = { filename = vim.api.nvim_buf_get_name(0) }
        ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
        names = vim.tbl_filter(function(name)
          local linter = lint.linters[name]
          if not linter then
            print("Linter not found: " .. name)
          end
          return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
        end, names)

        -- Run linters.
        if #names > 0 then
          lint.try_lint(names)
        end
      end

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = M.debounce(100, M.lint),
      })

      require('mason-nvim-lint').setup()
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      require("null-ls").setup({
        sources = {
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.rubocop,
          null_ls.builtins.diagnostics.write_good,
          null_ls.builtins.diagnostics.sqlfluff,
          null_ls.builtins.code_actions.gitsigns,
          -- null_ls.builtins.completion.spell,
          null_ls.builtins.completion.tags,
          null_ls.builtins.completion.luasnip,
          require("none-ls.diagnostics.eslint"),
          require("none-ls.code_actions.eslint"),
        },
      })
    end,
    dependencies = { "nvim-lua/plenary.nvim", "vim-test/vim-test", "nvimtools/none-ls-extras.nvim" }
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = false,
  },
  {
    "SmiteshP/nvim-gps",
    config = function()
      require("nvim-gps").setup({
        icons = {
          ["class-name"] = ' ', -- Classes and class-like objects
          ["function-name"] = ' ', -- Functions
          ["method-name"] = ' ', -- Methods (functions inside class-like objects)
          ["container-name"] = '⛶ ', -- Containers (example: lua tables)
          ["tag-name"] = '炙' -- Tags (example: html tags)
        }
      })
    end
  },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  },
  { 'saadparwaiz1/cmp_luasnip' },
  {
    "ray-x/navigator.lua",
    lazy = false,
    dependencies = {
      { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("navigator").setup({
        mason = true,
        lsp = {
          disable_lsp = 'all'
        }
      })
    end,
  },
  {
    'creativenull/efmls-configs-nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
  },
  {
    'kolen/tree-sitter-slim',
    lazy = false
  },
  -- {
  --   "OXY2DEV/markview.nvim",
  --   enabled = true,
  --   lazy = false,
  --   ft = { "markdown", "norg", "rmd", "org", "vimwiki", "Avante" },
  --   opts = {
  --     filetypes = { "markdown", "norg", "rmd", "org", "vimwiki", "Avante" },
  --     buf_ignore = {},
  --     max_length = 99999,
  --   },
  -- },
}
