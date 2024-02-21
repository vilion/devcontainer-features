local M = {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  dependencies = {
    "suketa/nvim-dap-ruby"
  },
  config = function()
    vim.fn.sign_define('DapBreakpoint', {text='', texthl='error', linehl='', numhl=''})
    require("dap-ruby").setup()
  end
}
--function M.config()
--  local dap, dapui = require("dap")
--
--  vim.fn.sign_define('DapBreakpoint', {text='', texthl='error', linehl='', numhl=''})
--  -- ADAPTERS
--  dap.adapters.node2 = {
--    type = 'executable',
--    command = 'node-debug2-adapter',
--    -- args = {os.getenv('HOME') .. '/.zinit/plugins/microsoft---vscode-node-debug2.git/out/src/nodeDebug.js'},
--    -- args =  { vim.fn.stdpath('data') .. '/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' },
--    args = {},
--  }
--  dap.configurations.javascript = {
--    {
--      name = 'Launch',
--      type = 'node2',
--      request = 'launch',
--      program = '${file}',
--      cwd = vim.fn.getcwd(),
--      sourceMaps = true,
--      protocol = 'inspector',
--      console = 'integratedTerminal',
--    },
--    {
--      -- For this to work you need to make sure the node process is started with the `--inspect` flag.
--      name = 'Attach to process',
--      type = 'node2',
--      request = 'attach',
--      restart = true,
--      -- port = 9229
--      processId = require'dap.utils'.pick_process,
--    },
--  }

 --  dap.adapters.ruby = function(callback, config)
 --    callback({
 --      type = "server",
 --      host = "127.0.0.1",
 --      port = "${port}",
 --      executable = {
 --        command = "bundle",
 --        args = {
 --          "exec",
 --          "rdbg",
 --          "-n",
 --          "--open",
 --          "--port",
 --          "${port}",
 --          "-c",
 --          "--",
 --          "bundle",
 --          "exec",
 --          "rails",
 --          "server",
 --          "-b",
 --          "0.0.0.0",
 --          "-p",
 --          "3000",
 --        },
 --      },
 --    })
 --  end

 --  dap.configurations.ruby = {
 --    {
 --      type = "ruby",
 --      name = "debug rails server",
 --      bundle = "bundle",
 --      request = "attach",
 --      command = "rails",
 --      script = "server",
 --      port = 3000,
 --      server = "0.0.0.0",
 --      options = {
 --        source_filetype = "ruby",
 --      },
 --      localfs = true,
 --      waiting = 1000,
 --    },
 --  }
-- end
return M
