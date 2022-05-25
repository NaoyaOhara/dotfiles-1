local function i(p)
  p.event = { "InsertEnter" }
  return p
end

local function c(p)
  p.event = { "CmdlineEnter" }
  return p
end

return {
  {
    "vim-skk/skkeleton",
    keys = {
      { "i", "<Plug>(skkeleton-enable)" },
      { "i", "<Plug>(skkeleton-disable)" },
      { "c", "<Plug>(skkeleton-enable)" },
      { "c", "<Plug>(skkeleton-disable)" },
      { "l", "<Plug>(skkeleton-enable)" },
      { "l", "<Plug>(skkeleton-disable)" },
    },
    wants = {
      "denops.vim",
    },

    setup = function()
      -- Use these mappings in Karabiner-Elements
      vim.keymap.set({ "i", "c", "l" }, "<F10>", "<Plug>(skkeleton-disable)")
      vim.keymap.set({ "i", "c", "l" }, "<F13>", "<Plug>(skkeleton-enable)")
      vim.keymap.set({ "i", "c", "l" }, "<C-j>", "<Plug>(skkeleton-enable)")
      vim.keymap.set("i", "<C-x><C-o>", function()
        require("cmp").complete()
      end)

      local Job = require "plenary.job"
      local karabiner_cli = "/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli"
      local function set_karabiner(val)
        return function()
          Job
            :new({
              command = karabiner_cli,
              args = {
                "--set-variables",
                ('{"neovim_in_insert_mode":%d}'):format(val),
              },
            })
            :start()
        end
      end

      local pre_config

      local g1 = api.create_augroup("skkeleton_callbacks", {})
      api.create_autocmd("User", {
        group = g1,
        pattern = "skkeleton-enable-pre",
        callback = function()
          pre_config = require("cmp.config").get()
          require("cmp").setup.buffer {
            sources = { { name = "skkeleton" } },
            view = { entries = "native" },
          }
        end,
      })
      api.create_autocmd("User", {
        group = g1,
        pattern = "skkeleton-disable-pre",
        callback = function()
          if pre_config then
            require("cmp").setup.buffer(pre_config)
            pre_config = nil
          end
        end,
      })

      local g2 = api.create_augroup("skkeleton_karabiner_elements", {})
      api.create_autocmd({ "InsertEnter", "CmdlineEnter" }, { group = g2, callback = set_karabiner(1) })
      api.create_autocmd({ "InsertLeave", "CmdlineLeave", "FocusLost" }, { group = g2, callback = set_karabiner(0) })
      api.create_autocmd("FocusGained", {
        group = g2,
        callback = function()
          local val = fn.mode():match "[icrR]" and 1 or 0
          set_karabiner(val)()
        end,
      })
    end,

    config = function()
      fn["skkeleton#config"] {
        globalJisyo = "~/Library/Application Support/AquaSKK/SKK-JISYO.L",
        userJisyo = "~/Library/Application Support/AquaSKK/skk-jisyo.utf8",
        markerHenkan = "□",
        eggLikeNewline = true,
        useSkkServer = true,
        immediatelyCancel = false,
        registerConvertResult = true,
      }
      fn["skkeleton#register_kanatable"]("rom", {
        ["("] = { "（", "" },
        [")"] = { "）", "" },
        ["z "] = { "　", "" },
        ["z1"] = { "①", "" },
        ["z2"] = { "②", "" },
        ["z3"] = { "③", "" },
        ["z4"] = { "④", "" },
        ["z5"] = { "⑤", "" },
        ["z6"] = { "⑥", "" },
        ["z7"] = { "⑦", "" },
        ["z8"] = { "⑧", "" },
        ["z9"] = { "⑨", "" },
        ["/"] = { "・", "" },
        ["<s-q>"] = "henkanPoint",
      })
    end,

    requires = {
      i {
        "delphinus/skkeleton_indicator.nvim",
        setup = function()
          api.create_autocmd("ColorScheme", {
            group = api.create_augroup("skkeleton_indicator_nord", {}),
            pattern = "nord",
            callback = function()
              vim.cmd [[
                hi SkkeletonIndicatorEiji guifg=#88c0d0 guibg=#2e3440 gui=bold
                hi SkkeletonIndicatorHira guifg=#2e3440 guibg=#a3be8c gui=bold
                hi SkkeletonIndicatorKata guifg=#2e3440 guibg=#ebcb8b gui=bold
                hi SkkeletonIndicatorHankata guifg=#2e3440 guibg=#b48ead gui=bold
                hi SkkeletonIndicatorZenkaku guifg=#2e3440 guibg=#88c0d0 gui=bold
              ]]
            end,
          })
        end,
        config = function()
          require("skkeleton_indicator").setup()
        end,
      },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    module = { "cmp" },
    setup = function()
      api.create_autocmd("ColorScheme", {
        group = api.create_augroup("cmp_nord", {}),
        pattern = "nord",
        callback = function()
          vim.cmd [[
            hi CmpItemAbbrDeprecated guifg=#616e88 gui=bold
            hi CmpItemAbbrMatch guifg=#ebcb8b
            hi CmpItemAbbrMatchFuzzy guifg=#d08770
            hi CmpItemMenu gui=bold guifg=#616e88

            hi CmpItemKindText guifg=#81a1c1
            hi CmpItemKindMethod guifg=#b48ead
            hi CmpItemKindFunction guifg=#b48ead
            hi CmpItemKindConstructor guifg=#b48ead gui=bold
            hi CmpItemKindField guifg=#a3be8c
            hi CmpItemKindVariable guifg=#88c0d0
            hi CmpItemKindClass guifg=#ebcb8b
            hi CmpItemKindInterface guifg=#8fbcbb
            hi CmpItemKindModule guifg=#ebcb8b
            hi CmpItemKindProperty guifg=#a3be8c
            hi CmpItemKindUnit guifg=#b48ead
            hi CmpItemKindValue guifg=#8fbcbb
            hi CmpItemKindEnum guifg=#8fbcbb
            hi CmpItemKindKeyword guifg=#5e81ac
            hi CmpItemKindSnippet guifg=#d08770
            hi CmpItemKindColor guifg=#ebcb8b
            hi CmpItemKindFile guifg=#a3be8c
            hi CmpItemKindReference guifg=#b48ead
            hi CmpItemKindFolder guifg=#a3be8c
            hi CmpItemKindEnumMember guifg=#8fbcbb
            hi CmpItemKindConstant guifg=#5e81ac
            hi CmpItemKindStruct guifg=#8fbcbb
            hi CmpItemKindEvent guifg=#d08770
            hi CmpItemKindOperator guifg=#b48ead
            hi CmpItemKindTypeParameter guifg=#8fbcbb
          ]]
        end,
      })
    end,

    config = function()
      local ignore_duplicated_items = { ctags = true, buffer = true, tmux = true, rg = true, look = true }

      local lspkind_format = require("lspkind").cmp_format {
        mode = "symbol_text",
        maxwidth = 50,
        menu = {
          buffer = "[B]",
          emoji = "[E]",
          look = "[LK]",
          nvim_lsp = "[L]",
          path = "[P]",
          rg = "[R]",
          snippy = "[S]",
          tmux = "[T]",
          ctags = "[C]",
        },
        symbol_map = {
          Text = "󾪓", -- 0xFEA93
          Method = "󾪌", -- 0xFEA8C
          Function = "󾪌", -- 0xFEA8C
          Constructor = "󾪌", -- 0xFEA8C
          Field = "󾭟", -- 0xFEB5F
          Variable = "󾪈", -- 0xFEA88
          Class = "󾭛", -- 0xFEB5B
          Interface = "󾭡", -- 0xFEB61
          Module = "󾪋", -- 0xFEA8B
          Property = "󾭥", -- 0xFEB65
          Unit = "󾪖", -- 0xFEA96
          Value = "󾪕", -- 0xFEA95
          Enum = "󾪕", -- 0xFEA95
          Keyword = "󾭢", -- 0xFEB62
          Snippet = "󾭦", -- 0xFEB66
          Color = "󾭜", -- 0xFEB5C
          File = "󾩻", -- 0xFEA7B
          Reference = "󾪔", -- 0xFEA94
          Folder = "󾪃", -- 0xFEA83
          EnumMember = "󾪕", -- 0xFEA95
          Constant = "󾭝", -- 0xFEB5D
          Struct = "󾪑", -- 0xFEA91
          Event = "󾪆", -- 0xFEA86
          Operator = "󾭤", -- 0xFEB64
          TypeParameter = "󾪒", -- 0xFEA92
        },
      }

      local cmp = require "cmp"
      cmp.setup {
        snippet = {
          expand = function(args)
            require("snippy").expand_snippet(args.body)
          end,
        },
        mapping = {
          ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
          ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
          ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "ctags" },
          { name = "snippy" },
          { name = "tmux", keyword_length = 2, option = { trigger_characters = {}, all_panes = true } },
          {
            name = "buffer",
            option = {
              --keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%([\-.]\w*\)*\)]],
              --keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h[\-:\w]*\%([\-.][:\w]*\)*\)]],
              --keyword_pattern = [[\k\+]],
              -- Allow Foo::Bar & foo-bar
              --keyword_pattern = [[\h\w*\%(\%(-\|::\)\h\w*\)*]],
              --keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(\%(-\|::\)\h\w*\)*\)]],
              keyword_pattern = [[\%(#[\da-fA-F]\{6}\>\|-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(\%(-\|::\)\h\w*\)*\)]],
              get_bufnrs = api.list_bufs,
            },
          },
          { name = "rg" },
          { name = "emoji" },
          { name = "look", keyword_length = 2, option = { convert_case = true, loud = true } },
        },
        formatting = {
          format = function(entry, vim_item)
            if ignore_duplicated_items[entry.source.name] then
              vim_item.dup = true
            end
            return lspkind_format(entry, vim_item)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      }
      cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })
      cmp.setup.cmdline(":", { sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }) })

      require("cmp.utils.debug").flag = vim.env.CMP_DEBUG ~= nil
    end,

    requires = {
      { "onsails/lspkind-nvim", module = { "lspkind" } },

      c { "hrsh7th/cmp-cmdline" },
      c { "hrsh7th/cmp-path" },

      i { "andersevenrud/cmp-tmux" },
      i { "delphinus/cmp-ctags" },
      i { "hrsh7th/cmp-buffer" },
      i { "hrsh7th/cmp-emoji" },
      i { "hrsh7th/cmp-nvim-lsp" },
      i { "lukas-reineke/cmp-rg" },
      i { "octaltree/cmp-look" },
      i { "rinx/cmp-skkeleton" },

      i {
        "dcampos/cmp-snippy",
        requires = {
          { "dcampos/nvim-snippy", module = { "snippy" } },
          { "honza/vim-snippets", opt = true },
        },
        wants = { "vim-snippets" },
        config = function()
          require("snippy").setup {}
        end,
      },
    },
  },
}
