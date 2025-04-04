-- <F1> help
vim.keymap.set('n', '<F3>', ':set nu! rnu!<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<F4>', ':set list! list?<CR>', { noremap = false, silent = true })
-- <F7> Yazi
vim.keymap.set('n', '<F8>', ':ZenMode<CR>', { noremap = false, silent = true })
vim.keymap.set('n', '<leader>nm', ':Dispatch npm start<CR>', { noremap = false, silent = true })
-- Buffers
vim.keymap.set('n', '<leader>bn', ':BufSurfForward<CR>', { noremap = false, silent = true })
vim.keymap.set('n', '<leader>bp', ':BufSurfBack<CR>', { noremap = false, silent = true })
vim.keymap.set('n', '<leader>bl', ':BufSurfList<CR>', { noremap = false, silent = true })
-- Diff
vim.keymap.set('n', '<leader>dd', ':windo diffthis<CR>', { noremap = false, silent = true })
-- LSP
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { noremap = true, silent = true })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap = true, silent = true })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap = true, silent = true })
-- Trouble
vim.keymap.set('n', '<leader>tt', ':Trouble todo filter = { tag = {TODO} }<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tf', ':Trouble todo filter = { tag = {FIX,FIXME} }<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tn', ':Trouble todo filter = { tag = {NOTE} }<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tr", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>tw", "<cmd>Trouble workspace_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>td", "<cmd>Trouble document_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>tll", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>tq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>tl", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })
-- Nvim-dap
vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>ds", "<cmd>lua require'dap'.step_over()<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>dsi", "<cmd>lua require'dap'.step_into()<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>dso", "<cmd>lua require'dap'.step_out()<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>dui", ":lua require('dapui').toggle()<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>dro", "<cmd>lua require'dap'.repl.open()<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>dcc", "<cmd>lua require'telescope'.extensions.dap.commands{}<CR>",
  { silent = true, noremap = true })
vim.keymap.set("n", "<leader>dlb", "<cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>",
  { silent = true, noremap = true })
vim.keymap.set("n", "<leader>dv", "<cmd>lua require'telescope'.extensions.dap.variables{}<CR>",
  { silent = true, noremap = true })
vim.keymap.set("n", "<leader>df", "<cmd>lua require'telescope'.extensions.dap.frames{}<CR>",
  { silent = true, noremap = true })
-- Notes & Todo
vim.keymap.set('n', '<leader>tv', ":lua require('util.scratches').open_scratch_file()<CR>",
  { noremap = true, silent = true })
vim.keymap.set('n', '<leader>nt', ":lua require('util.scratches').open_scratch_file_floating()<CR>",
  { noremap = true, silent = true })
vim.keymap.set('n', '<leader>n', ":lua require('plugins.telescope').my_note()<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>nn', ":lua NewNote()<CR>", { noremap = true, silent = true })
-- ROR
vim.keymap.set("n", "<Leader>ror", ":lua require('ror.commands').list_commands()<CR>", { silent = true })
vim.keymap.set("n", "<Leader>or", ":! overmind restart<CR>", { silent = true })
