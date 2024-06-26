return {
  --[[ COLORSCHEME ]]
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup({
        -- add any options here, or leave empty to use the default settings
      })
    end
  },
  {
    "folke/tokyonight.nvim",
    -- "olimorris/onedarkpro.nvim",
    -- "loctvl842/monokai-pro.nvim",
    -- "rebelot/kanagawa.nvim",
    -- "sainnhe/gruvbox-material",
    -- "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
     config = function()
       require('config.colorschemes.tokyonight')
       -- require('config.colorschemes.onedarkpro')
       -- require('config.colorschemes.monokai_pro')
       -- require('config.colorschemes.kanagawa')
       -- require('config.colorschemes.gruvbox_material')
       -- require('config.colorschemes.github_nvim_theme')
     end,
  },
  --[[ END COLORSCHEME ]]
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
  {
    "hrsh7th/nvim-cmp",
    priority = 1000,
    lazy = false,
  },
  {
    "hrsh7th/cmp-buffer",
    lazy = false,
  },
  {
    "hrsh7th/cmp-vsnip",
    lazy = false,
  },
  {
    "hrsh7th/vim-vsnip",
    lazy = false,
  },
  {
    "hrsh7th/cmp-path",
    lazy = false,
  },
  {
    "hrsh7th/cmp-calc",
    lazy = false,
  },
  {
    "hrsh7th/cmp-cmdline",
    lazy = false,
  },
  {
    "ray-x/cmp-treesitter",
    lazy = false,
  },
  {
    "lukas-reineke/cmp-rg",
    lazy = false,
  },
  {
    "quangnguyen30192/cmp-nvim-tags",
    lazy = false,
  },
  {
    "rafamadriz/friendly-snippets",
    lazy = false,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        highlight = {
          enable = true,
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
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'UIEnter',
    opts = {
      exclude = {
        -- stylua: ignore
        filetypes = {
          'dbout', 'neo-tree-popup', 'log', 'gitcommit',
          'txt', 'help', 'NvimTree', 'git', 'flutterToolsOutline',
          'undotree', 'markdown', 'norg', 'org', 'orgagenda',
        },
      },
      indent = {
        char = '│', -- ▏┆ ┊ 
        tab_char = '│',
      },
      scope = {
        char = '▎',
      },
    },
    config = function(_, opts)
      require('ibl').setup(opts)
      local hooks = require('ibl.hooks')
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = false,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
  },
  {
    "SmiteshP/nvim-gps",
    config = function()
      require("nvim-gps").setup({
        icons = {
          ["class-name"] = ' ',      -- Classes and class-like objects
          ["function-name"] = ' ',   -- Functions
          ["method-name"] = ' ',     -- Methods (functions inside class-like objects)
          ["container-name"] = '⛶ ',  -- Containers (example: lua tables)
          ["tag-name"] = '炙'         -- Tags (example: html tags)
        }
      })
    end
  },
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
      require("numb").setup{
        show_numbers = true, -- Enable 'number' for the window while peeking
        show_cursorline = true -- Enable 'cursorline' for the window while peeking
      }
    end,
  },
  {
    "tpope/vim-rails",
    event = { "BufReadPre", "BufNewFile" },
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
    "tpope/vim-abolish",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "tpope/vim-bundler",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "tpope/vim-capslock",
    lazy = false,
  },
  {
    "tpope/vim-repeat",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "tpope/vim-endwise",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "tpope/vim-dispatch",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = false,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end
  },
  {
    "ludovicchabant/vim-gutentags",
    lazy = false,
    config = function()
      vim.cmd('set tags+=tags,.git/tags')
      vim.g.gutentags_enabled = 1
      vim.g.gutentags_generate_on_missing = 1
      vim.g.gutentags_generate_on_write = 1
      vim.g.gutentags_resolve_symlinks = 1
      vim.g.gutentags_ctags_tagfile = '.git/tags'
      vim.g.gutentags_project_root = { '.git' }
      vim.g.gutentags_ctags_extra_args = { '--fields=+l' }
      vim.g.gutentags_add_default_project_roots = 0
      vim.g.gutentags_ctags_executable_ruby = 'ripper-tags'
      vim.g.gutentags_ctags_extra_args_ruby = { '--ignore-unsupported-options', '--recursive' }
      -- vim.g.gutentags_trace = 1
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    event = 'VeryLazy',
    config = function()
      require("dapui").setup()
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    event = 'VeryLazy',
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
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
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      window = {
        border = { "┏", "━", "┓", "┃", "┛","━", "┗", "┃" },
      }
    },
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
    "chaoren/vim-wordmotion",
    event = 'VeryLazy',
  },
  {
    "nvim-pack/nvim-spectre",
    event = 'VeryLazy',
  },
  {
    "folke/trouble.nvim",
    event = 'VeryLazy',
  },
  {
    "mrbjarksen/neo-tree-diagnostics.nvim",
    event = 'VeryLazy',
  },
  {
    "RRethy/vim-illuminate",
    event = 'VeryLazy',
  },
  {
    "folke/edgy.nvim",
    event = "BufReadPost",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
    end,
    opts = {
      fix_win_height = vim.fn.has "nvim-0.10.0" == 0,
      options = {
        left = { size = 40 },
        bottom = { size = 10 },
        right = { size = 40 },
        top = { size = 10 },
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
      left = {
        {
          title = "  FILE",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          size = { height = 0.7 },
        },
        {
          title = "  GIT",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "git_status"
          end,
          pinned = true,
          open = "Neotree position=right git_status",
        },
        {
          title = "  BUFFERS",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "buffers"
          end,
          pinned = true,
          open = "Neotree position=top buffers",
        },
        {
          ft = "裂 DIAGNOSTICS",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "diagnostics"
          end,
          pinned = true,
          open = "Neotree position=right diagnostics",
        },
        "neo-tree",
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          -- default options: exact mode, multi window, all directions, with a backdrop
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          -- show labeled treesitter nodes around the cursor
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          -- jump to a remote location to execute the operator
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "n", "o", "x" },
        function()
          -- show labeled treesitter nodes around the search matches
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      }
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
          border = { "┏", "━", "┓", "┃", "┛","━", "┗", "┃" },
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
    '2kabhishek/co-author.nvim',
    dependencies = { 'stevearc/dressing.nvim' },
    cmd = 'GitCoAuthors',
  },
  {
    'weizheheng/ror.nvim'
  },
  {
    "SR-Mystar/yazi.nvim",
    event = 'VeryLazy',
    cmd = "Yazi",
    opts = {
      title = "",
      border = { "┏", "━", "┓", "┃", "┛","━", "┗", "┃" },
    },
    keys = {
      { "<F5>", "<cmd>Yazi<CR>", desc = "Toggle Yazi" },
    },
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
        require("null-ls").setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.diagnostics.sqlfluff,
          null_ls.builtins.completion.spell,
        },
      })
    end,
    dependencies = {"nvim-lua/plenary.nvim", "vim-test/vim-test"}
  },
  {
   'sindrets/diffview.nvim',
    lazy = false,
  },
  {
    "mfussenegger/nvim-lint",
    lazy = false,
  },
  {
    "rshkarin/mason-nvim-lint",
    event = 'VeryLazy',
    lazy = true,
    dependencies = {"mason.nvim", "mfussenegger/nvim-lint"},
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
    -- local rubocop = require("lint").linters.rubocop
    -- rubocop.cmd = 'bundle exec rubocop'
    -- rubocop.args = {'--lsp'}
    -- rubocop.stdin = false

    local lint = require("lint")
    for name, linter in pairs(opts.linters) do
      if type(linter) == "table" and type(lint.linters[name]) == "table" then
        lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
      else
        lint.linters[name] = linter
      end
    end

    local rubocop = lint.linters.rubocop
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

      -- require('mason-nvim-lint').setup()
  end,
  }
}
