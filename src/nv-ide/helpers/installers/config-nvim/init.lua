require('config.settings')
require('config.color')
-- Lazy
require('config.lazy')
--
-- require('util.hjkl_notifier')
require('util.new_note')
--
require('config.font')
require('config.completion')
-- Keymap
require('config.mappings')

local dap, dapui = require("dap"), require("dapui")
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

