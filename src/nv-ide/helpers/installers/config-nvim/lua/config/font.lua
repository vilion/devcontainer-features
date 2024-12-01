if vim.fn.has('unix') == 1 then
  local uname = vim.fn.system('uname')
  if uname == "Darwin\n" then
    -- vim.opt.guifont = 'JetBrains Mono:h12'
    -- vim.opt.guifont = 'Hack Nerd Font Mono:h13'
    -- vim.opt.guifont = 'HackGen Console NF:h13'
    vim.opt.guifont = 'FiraCode Nerd Font:h13'
  elseif vim.g.neovide then
    vim.opt.guifont = 'Hack Nerd Font Mono:h13'
  else
    -- vim.opt.guifont = 'Hack Nerd Font Mono:h13'
    vim.opt.guifont = 'FiraCode Nerd Font:h13'
    if not vim.fn.has('FiraCode Nerd Font') then
      vim.opt.guifont = 'Hack Nerd Font Mono:h13'
    end
  end
end
