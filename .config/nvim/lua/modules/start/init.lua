local config = require "modules.start.config"

return {
  -- TODO: needed here?
  { "nvim-lua/plenary.nvim", module_pattern = { "plenary.*" } },

  -- basic {{{
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

  {
    "folke/noice.nvim",
    event = { "BufRead", "BufNewFile", "InsertEnter", "CmdlineEnter" },
    module = { "noice" },
    requires = {
      { "MunifTanjim/nui.nvim" },
      {
        "rcarriga/nvim-notify",
        module = { "notify" },
        config = config.notify,
      },
    },
    setup = config.noice.setup,
    config = config.noice.config,
  },

  {
    "nvim-lualine/lualine.nvim",
    requires = {
      --{ "kyazdani42/nvim-web-devicons", opt = true },
      { "delphinus/nvim-web-devicons", branch = "feature/sfmono-square", opt = true },
      { "delphinus/eaw.nvim", module = { "eaw" } },
    },
    config = require "modules.start.config.lualine",
  },

  { "lambdalisue/suda.vim" },

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

  {
    "delphinus/cellwidths.nvim",
    config = config.cellwidths.config,
    run = config.cellwidths.run,
  },

  { "folke/todo-comments.nvim" },
  -- }}}
}

-- vim:se fdm=marker:
