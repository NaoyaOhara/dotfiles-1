local config = require "modules.lsp.config"

local function ts(plugin)
  plugin.event = { "BufNewFile", "BufRead" }
  plugin.wants = { "nvim-treesitter" }
  return plugin
end

return {
  { "folke/neodev.nvim", opt = true },

  { -- {{{ nvim-lspconfig
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    module = { "lsp_lines" },
  },

  {
    "neovim/nvim-lspconfig",
    event = { "FocusLost", "CursorHold" },
    ft = {
      "c",
      "cpp",
      "css",
      "dockerfile",
      "go",
      "html",
      "javascript",
      "json",
      "jsonnet",
      "lua",
      "perl",
      "php",
      "python",
      "ruby",
      "sh",
      "swift",
      "teal",
      "terraform",
      "typescript",
      "vim",
      "vue",
      "yaml",
    },
    wants = {
      "neodev.nvim",
      "mason.nvim",
      "mason-lspconfig.nvim",
      -- needs these plugins to setup capabilities
      "cmp-nvim-lsp",
    },
    config = config.lspconfig,
  },

  {
    "williamboman/mason.nvim",
    module = { "mason" },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    module = { "mason-lspconfig" },
  }, -- }}}

  ts { "RRethy/nvim-treesitter-endwise" },

  ts {
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup { color = "#d08770" }
    end,
  },

  ts {
    "mfussenegger/nvim-treehopper",
    modules = { "tsht" },
    setup = config.treehopper.setup,
  },

  ts { "nvim-treesitter/nvim-treesitter-refactor" },
  ts { "nvim-treesitter/nvim-treesitter-textobjects" },
  ts { "nvim-treesitter/playground" },
  ts { "romgrk/nvim-treesitter-context" },
  ts { "p00f/nvim-ts-rainbow", config = config.ts_rainbow },

  { -- {{{ nvim-treesitter
    "nvim-treesitter/nvim-treesitter",
    config = config.treesitter,
    run = ":TSUpdate",
  }, -- }}}

  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "FocusLost", "CursorHold" },
    config = config.null_ls.config,
    run = config.null_ls.run,
  },
}

-- vim:se fdm=marker:
