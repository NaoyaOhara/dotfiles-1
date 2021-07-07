function _G.run_packer(method)
  vim.cmd[[packadd packer.nvim]]
  require'packers.load'[method]()
end

vim.cmd[[command! PackerInstall lua run_packer'install']]
vim.cmd[[command! PackerUpdate  lua run_packer'update']]
vim.cmd[[command! PackerSync    lua run_packer'sync']]
vim.cmd[[command! PackerClean   lua run_packer'clean']]
vim.cmd[[command! PackerCompile lua run_packer'compile']]
vim.cmd[[command! PackerProfile lua run_packer'profile_output']]

local m = require'mappy'
m.nnoremap('<Leader>ps', function() _G.run_packer'sync' end)
m.nnoremap('<Leader>po', function()
  _G.run_packer'compile'
  vim.api.nvim_echo({
    {'[packer] Compile complete!', 'WarningMsg'},
  }, true, {})
end)
