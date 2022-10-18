return {
  noice = {
    setup = function()
      local orig = vim.notify
      vim.notify = function(...)
        vim.notify = orig
        require "notify"
        require "noice"
        vim.notify(...)
      end
    end,

    config = function()
      require("noice").setup {
        cmdline = {
          icons = {
            ["/"] = { icon = "", hl_group = "DiagnosticWarn" },
            ["?"] = { icon = "", hl_group = "DiagnosticWarn" },
            [":"] = { icon = "", hl_group = "DiagnosticInfo" },
          },
        },
        popupmenu = {
          backend = "cmp",
        },
        lsp_progress = {
          enabled = true,
        },
        hacks = {
          skip_duplicate_messages = true,
        },
      }
    end,
  },

  notify = function()
    vim.opt.termguicolors = true
    require("notify").setup {
      render = "minimal",
      background_colour = "#3b4252",
      level = "trace",
      on_open = function(win)
        api.win_set_config(win, { focusable = false })
      end,
    }
  end,

  fugitive = function()
    local keymap = vim.keymap
    keymap.set("n", "git", [[<Cmd>Git<CR>]])
    keymap.set("n", "g<Space>", [[<Cmd>Git<CR>]])
    keymap.set("n", "d<", [[<Cmd>diffget //2<CR>]])
    keymap.set("n", "d>", [[<Cmd>diffget //3<CR>]])
    keymap.set("n", "gs", [[<Cmd>Gstatus<CR>]])
  end,

  unimpaired = function()
    local keymap = vim.keymap
    keymap.set("n", "[w", [[<Cmd>colder<CR>]])
    keymap.set("n", "]w", [[<Cmd>cnewer<CR>]])
    keymap.set("n", "[O", [[<Cmd>lopen<CR>]])
    keymap.set("n", "]O", [[<Cmd>lclose<CR>]])
  end,

  visual_eof = function()
    local api = require("core.utils").api
    api.create_autocmd("ColorScheme", {
      group = api.create_augroup("nord_visual_eof", {}),
      pattern = "nord",
      callback = function()
        api.set_hl(0, "VisualEOL", { fg = "#a3be8c" })
        api.set_hl(0, "VisualNoEOL", { fg = "#bf616a" })
      end,
    })
    require("visual-eof").setup {
      text_EOL = " ",
      text_NOEOL = " ",
      ft_ng = {
        "FTerm",
        "denite",
        "denite-filter",
        "fugitive.*",
        "git.*",
        "packer",
      },
      buf_filter = function(bufnr)
        return api.buf_get_option(bufnr, "buftype") == ""
      end,
    }
  end,

  cellwidths = {
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
        end,
      }
    end,
    run = function()
      vim.cmd.CellWidthsRemove()
    end,
  },
}
