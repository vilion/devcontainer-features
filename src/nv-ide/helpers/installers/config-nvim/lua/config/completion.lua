-- vim.api.nvim_exec([[
-- autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
-- autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
-- " autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global=1
-- " autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
-- " autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
-- " autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
-- " autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
-- " autocmd FileType php set omnifunc=phpcomplete#CompletePHP
-- " autocmd BufRead,BufNewFile *.md setlocal spell
-- ]], true)
-- --
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require 'cmp'
local lspkind = require 'lspkind'
local luasnip = require 'luasnip'
--
-- local function border(hl_name)
--   --[[ { "┏", "━", "┓", "┃", "┛","━", "┗", "┃" }, ]]
--   --[[ {"─", "│", "─", "│", "┌", "┐", "┘", "└"}, ]]
--   return {
--     { "┌", hl_name },
--     { "─", hl_name },
--     { "┐", hl_name },
--     { "│", hl_name },
--     { "┘", hl_name },
--     { "─", hl_name },
--     { "└", hl_name },
--     { "│", hl_name },
--   }
-- end
--
cmp.setup({ enable = false })
-- cmp.setup({
--   window = {
--     completion = {
--       border = border "FloatBorder",
--       winhighlight = "Normal:NormalFloat,CursorLine:PmenuSel,Search:None",
--     },
--     documentation = {
--       border = border "FloatBorder",
--     },
--   },
--   snippet = {
--     expand = function(args)
--       vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
--       require 'luasnip'.lsp_expand(args.body)
--     end,
--   },
--   mapping = {
--     ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
--     ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
--     ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
--     ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
--     ['<C-e>'] = cmp.mapping({
--       i = cmp.mapping.abort(),
--       c = cmp.mapping.close(),
--     }),
--     ['<CR>'] = cmp.mapping.confirm({ select = true }),
--     ['<Up>'] = cmp.mapping.select_prev_item(),
--     ['<Down>'] = cmp.mapping.select_next_item(),
--     ['<Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       elseif luasnip.expand_or_jumpable() then
--         luasnip.expand_or_jump()
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--     ['<S-Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       elseif luasnip.jumpable(-1) then
--         luasnip.jump(-1)
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--   },
--   formatting = {
--     format = lspkind.cmp_format({
--       mode = 'symbol',
--       maxwidth = 50,
--
--       before = function(entry, vim_item)
--         return vim_item
--       end
--     })
--   },
--   sources = cmp.config.sources({
--     { name = 'luasnip' },
--     { name = 'nvim_lsp' },
--     { name = 'vsnip' },
--     { name = 'path' },
--     { name = 'calc' },
--     { name = 'treesitter' },
--     { name = 'tags' },
--     { name = 'rg' },
--   }, {
--     { name = 'buffer' },
--   }),
-- })
-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
--
-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- cmp.event:on(
--   'confirm_done',
--   cmp_autopairs.on_confirm_done()
-- )
--
-- -- local lsp_ai_init_options_json = [[
-- -- {
-- --   "memory": {
-- --     "file_store": {}
-- --   },
-- --   "models": {
-- --     "model1": {
-- --         "type": "open_ai",
-- --         "chat_endpoint": "https://api.openai.com/v1/chat/completions",
-- --         "model": "gpt-4o-mini",
-- --         "auth_token_env_var_name": "OPENAI_API_KEY"
-- --     }
-- --   },
-- --   "completion": {
-- --     "model": "model1",
-- --     "parameters": {
-- --         "max_context": 2048,
-- --         "max_new_tokens": 128,
-- --         "messages": [
-- --           {
-- --             "role": "system",
-- --             "content": "You are a chat completion system like GitHub Copilot. You will be given a context and a code snippet. You should generate a response that is a continuation of the context and code snippet."
-- --           },
-- --           {
-- --             "role": "user",
-- --             "content": "Context: {CONTEXT} - Code: {CODE}"
-- --           }
-- --         ]
-- --     }
-- --   }
-- -- }
-- -- ]]
--
-- -- local lsp_ai_config = {
-- --   cmd = { 'lsp-ai' },
-- --   root_dir = vim.loop.cwd(),
-- --   capabilities = require('cmp_nvim_lsp').default_capabilities(),
-- --   init_options = vim.fn.json_decode(lsp_ai_init_options_json),
-- -- }
-- --
-- -- -- Start lsp-ai when opening a buffer
-- -- local augroup = vim.api.nvim_create_augroup("lsp-ai", { clear = true })
-- -- local ns_id = vim.api.nvim_create_namespace("lsp-ai")
-- -- local opts = {
-- --   id = 1,
-- --   hl_mode = "combine",
-- -- }
-- --
-- -- vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
-- --   group = augroup,
-- --   callback = function() vim.lsp.start(lsp_ai_config) end,
-- --   -- callback = function(args)
-- --   --   local bufnr = args.buf
-- --   --   local client = vim.lsp.get_active_clients({bufnr = bufnr, name = "lsp-ai"})
-- --   --   if #client == 0 then
-- --   --     vim.lsp.start(lsp_ai_config, {bufnr = bufnr})
-- --   --   end
-- --   -- end,
-- -- })
-- --
-- -- -- Register key shortcut
-- -- vim.keymap.set(
-- --     "n",
-- --     "<leader>co",
-- --     function()
-- --         print("Loading completion...")
-- --
-- --         local x = vim.lsp.util.make_position_params(0)
-- --         local y = vim.lsp.util.make_text_document_params(0)
-- --
-- --         local combined = vim.tbl_extend("force", x, y)
-- --
-- --         local result = vim.lsp.buf_request_sync(
-- --             0,
-- --             "textDocument/completion",
-- --             combined,
-- --             10000
-- --         )
-- --
-- --         print(vim.inspect(result))
-- --         vim.api.nvim_buf_set_extmark(0, ns_id, vim.fn.line(".") - 1, vim.fn.col(".") - 1, opts)
-- --     end,
-- --     {
-- --         noremap = true,
-- --     }
-- -- )
-- -- vim.api.nvim_set_keymap('n', '<leader>c', '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true, silent = true})
