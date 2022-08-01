local config = require "modules.start.config"

return {
  -- TODO: needed here?
  { "nvim-lua/plenary.nvim" },

  -- basic {{{
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        ignore_lsp = { "bashls", "null-ls", "tsserver" },
        patterns = { ".git" },
        show_hidden = true,
      }
    end,
  },

  -- TODO: https://github.com/antoinemadec/FixCursorHold.nvim
  {
    "antoinemadec/FixCursorHold.nvim",
    config = [[vim.g.cursorhold_updatetime = 100]],
  },

  "delphinus/artify.nvim",
  "delphinus/f_meta.nvim",

  {
    "delphinus/characterize.nvim",
    config = function()
      require("characterize").setup {}
    end,
  },

  { "delphinus/vim-quickfix-height" },

  {
    "direnv/direnv.vim",
    config = function()
      vim.g.direnv_silent_load = 1
    end,
  },

  { "editorconfig/editorconfig-vim" },

  {
    "nvim-lualine/lualine.nvim",
    requires = {
      { "kyazdani42/nvim-web-devicons", opt = true },
      --{ "arkav/lualine-lsp-progress" },
      { "delphinus/lualine-lsp-progress", branch = "hotfix/escape-progress" },
    },
    config = require "modules.start.config.lualine",
  },

  { "lambdalisue/suda.vim" },

  {
    "rcarriga/nvim-notify",
    config = config.notify,
  },

  {
    "tpope/vim-eunuch",
    config = function()
      local fn, uv, api = require("core.utils").globals()
      vim.env.SUDO_ASKPASS = uv.os_homedir() .. "/git/dotfiles/bin/macos-askpass"
    end,
  },

  {
    "tpope/vim-fugitive",
    config = config.fugitive,
  },

  { "tpope/vim-repeat" },
  { "tpope/vim-rhubarb" },

  {
    -- 'tpope/vim-unimpaired',
    "delphinus/vim-unimpaired",
    config = config.unimpaired,
  },

  { "vim-jp/vimdoc-ja" },
  -- }}}

  -- vim-script {{{
  { "vim-scripts/HiColors" },
  -- }}}

  -- lua-script {{{
  {
    "LumaKernel/nvim-visual-eof.lua",
    config = config.visual_eof,
  },

  { "folke/todo-comments.nvim" },
  -- }}}
}

-- vim:se fdm=marker:
