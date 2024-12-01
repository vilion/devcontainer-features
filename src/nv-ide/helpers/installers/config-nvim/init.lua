require('config.settings')
-- Lazy
require('config.lazy')
require('config.color')
--
--require('util.hjkl_notifier')
require('util.new_note')
-- --
require('config.font')
-- LAZY
-- require('config.lazy')
-- UTIL
-- require('util.hjkl_notifier')
-- require('util.new_note')
-- COMPLETION
require('config.completion')
-- KEYMAP
require('config.mappings')
-- vim.cmd [[colorscheme okcolors-smooth]]
require('avante_lib').load()
require('avante').setup()
