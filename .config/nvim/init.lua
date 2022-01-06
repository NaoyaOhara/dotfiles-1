-- Define utility functions in global
_G.fn = vim.fn
_G.loop = vim.loop
_G.api = setmetatable({ _cache = {} }, {
  __index = function(self, name)
    if not self._cache[name] then
      local func = vim.api["nvim_" .. name]
      if func then
        self._cache[name] = func
      else
        error("Unknown api func: " .. name, 2)
      end
    end
    return self._cache[name]
  end,
})

-- https://www.reddit.com/r/neovim/comments/rvwsl3/introducing_filetypelua_and_a_call_for_help/
-- Enable filetype.lua
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

vim.env.PATH = vim.env.PATH or "/usr/local/bin:/usr/bin:/bin"
-- TODO: impatient.nvim
if not pcall(require, "impatient") then
  local dir = fn.stdpath "data" .. "/site/pack/packer/start/impatient.nvim"
  os.execute("git clone https://github.com/lewis6991/impatient.nvim " .. dir)
  vim.opt.runtimepath:append(dir)
  require "impatient"
end
if vim.env.IMPATIENT_PROFILE then
  require("impatient").enable_profile()
end

if vim.env.NVIM_PROFILE then
  require("plenary.profile").start("/tmp/profile.log", { flame = true })
  vim.cmd [[au VimEnter * lua require'plenary.profile'.stop()]]
end

pcall(require, "packer_compiled") -- TODO: impatient.nvim

require "setup"
require "packers"
require "set"
require "mapping"
require "term"
require "commands"

vim.g.loaded_getscriptPlugin = true
vim.g.loaded_logiPat = true
vim.g.loaded_rrhelper = true
vim.g.loaded_vimballPlugin = true
if fn.has "gui_running" ~= 1 then
  vim.g.plugin_scrnmode_disable = true
end

local local_vimrc = loop.os_homedir() .. "/.vimrc-local"
local st = loop.fs_stat(local_vimrc)
if st and st.type == "file" then
  vim.cmd("source " .. local_vimrc)
end
