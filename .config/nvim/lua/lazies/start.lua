local function non_lazy(plugin)
  plugin.lazy = false
  return plugin
end

return {
  non_lazy {
    "direnv/direnv.vim",
    config = function()
      vim.g.direnv_silent_load = 1
    end,
  },

  non_lazy {
    "tpope/vim-unimpaired",
    --"delphinus/vim-unimpaired",
    config = function()
      local km = vim.keymap
      km.set("n", "[w", [[<Cmd>colder<CR>]])
      km.set("n", "]w", [[<Cmd>cnewer<CR>]])
      km.set("n", "[O", [[<Cmd>lopen<CR>]])
      km.set("n", "]O", [[<Cmd>lclose<CR>]])
    end,
  },

  non_lazy { "vim-jp/vimdoc-ja" },

  non_lazy { "vim-scripts/HiColors" },

  non_lazy {
    "delphinus/cellwidths.nvim",
    build = ":CellWidthsRemove",
    config = function()
      --[[
      local function measure(name, f)
        local s = os.clock()
        f()
        vim.notify(("%s took %f ms"):format(name, (os.clock() - s) * 1000))
      end
      ]]

      vim.opt.listchars = {
        tab = "▓░",
        trail = "↔",
        eol = "⏎",
        extends = "→",
        precedes = "←",
        nbsp = "␣",
      }
      vim.opt.fillchars = {
        diff = "░",
        eob = "‣",
        fold = "░",
        foldopen = "▾",
        foldsep = "│",
        foldclose = "▸",
      }
      require("cellwidths").setup {
        name = "user/custom",
        --log_level = "DEBUG",
        ---@param cw cellwidths
        fallback = function(cw)
          cw.load "sfmono_square"
          cw.add { 0xf0000, 0x10ffff, 2 }
          cw.add(0x25bd, 1)
          cw.add(0x25A3, 1)
          cw.add(0x25B3, 1)
          cw.add(0x25B5, 1)
          cw.add(0x25B6, 1)
          cw.add(0x25B7, 1)
          cw.add(0x25BD, 1)
          cw.add(0x25BF, 1)
          cw.add(0x25C1, 1)
          cw.add(0x25C3, 1)
          cw.add(0x25C9, 1)
          cw.add(0x25CE, 1)
          return cw
        end,
      }
    end,
  },

  non_lazy { "delphinus/rtr.nvim", config = true },

  non_lazy { "delphinus/unimpaired.nvim", branch = "feature/first-implementation", dev = true },

  non_lazy { "vim-denops/denops.vim" },
}
