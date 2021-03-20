return {
  -- TODO: needed here?
  {'nvim-lua/plenary.nvim'},

  {'svermeulen/vimpeccable'},

  -- basic {{{
  {'airblade/vim-rooter'},

  -- TODO: https://github.com/antoinemadec/FixCursorHold.nvim
  {
    'antoinemadec/FixCursorHold.nvim',
    config = [[vim.g.cursorhold_updatetime = 100]],
  },

  'delphinus/artify.nvim',

  {
    'delphinus/characterize.nvim',
    config = function()
      require'characterize'.setup{}
    end,
  },

  {'delphinus/vim-auto-cursorline'},
  {'delphinus/vim-quickfix-height'},

  {
    'direnv/direnv.vim',
    config = function() vim.g.direnv_silent_load = 1 end,
  },

  {
    'hoob3rt/lualine.nvim',
    requires = {
      {'kyazdani42/nvim-web-devicons', opt = true},
    },
    config = function()
      require'augroups'.set{
         redraw_tabline = {
            {'CursorMoved', '*', 'redrawtabline'},
         },
      }

      local characterize = require'characterize'
      local function char_info()
        local char = characterize.cursor_char()
        local results = characterize.info_table(char)
        if #results == 0 then return 'NUL' end
        local r = results[1]
        local text = ('<%s> %s'):format(r.char, r.codepoint)
        if r.digraphs and #r.digraphs > 0 then
          text = text..', \\<C-K>'..r.digraphs[1]
        end
        return text
      end
      local artify = require'artify'
      local monospace = function(f)
        return function() return artify(f(), 'monospace') end
      end
      require'lualine'.setup{
        options = {
          theme = 'nord',
          section_separators = '',
          component_separators = '❘',
        },
        sections = {
          lualine_a = {monospace(require'lualine.components.mode')},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {},
          lualine_y = {'filetype'},
          lualine_z = {'location'},
        },
        tabline = {
          lualine_a = {},
          lualine_b = {
            monospace(require'lualine.components.branch'.init{}),
            {
              'diff',
              symbols = {
                added = '↑',
                modified = '→',
                removed = '↓',
              },
            },
            {
              'diagnostics',
              sources = {'nvim_lsp'},
              color_error = '#e5989f',
              color_warn = '#ebcb8b',
              color_info = '#8ca9cd',
              symbols = {
                error = '●', -- U+25CF
                warn = '○', -- U+25CB
                info = '■', -- U+25A0
              },
            },
          },
          lualine_c = {monospace(require'lualine.components.filename'.init{})},
          lualine_x = {
            {char_info, separator = '❘'},
            'encoding',
            {'fileformat', right_padding = 2},
          },
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
  },

  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      -- TODO: use Lua for this block
      local do_hlslens = function(map, need_count1)
        return function()
          local count1 = need_count1 and (vim.v.count1 or '1') or ''
          local ok, err = pcall(vim.cmd, 'normal! '..count1..map)
          if ok then
            require'hlslens'.start()
          else
            vim.api.nvim_err_writeln(err)
          end
        end
      end
      vimp.nnoremap({'silent'}, 'n', do_hlslens('n', true))
      vimp.nnoremap({'silent'}, 'N', do_hlslens('N', true))
      vimp.nnoremap('g*', do_hlslens('g*', true))
      vimp.nnoremap('g#', do_hlslens('g#', true))
      -- Use with vim-visualstar
      vimp.nmap('*', [[*<Cmd>lua require('hlslens').start()<CR>]])
      -- # will be used in telescope
      -- vimp.nnoremap('#', do_hlslens('#', true))
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require'gitsigns'.setup{
        signs = {
          add = {hl = 'GitSignsAdd'},
          change = {hl = 'GitSignsChange'},
          delete = {hl = 'GitSignsDelete', text = '✗'},
          topdelete = {hl = 'GitSignsDelete', text = '↑'},
          changedelete = {hl = 'GitSignsChange', text = '•'},
        },
        numhl = true,
        use_decoration_api = true,
      }
    end,
  },

  {
    'raghur/vim-ghost',
    run = ':GhostInstall',
    setup = function()
      vim.g.ghost_darwin_app = 'iTerm2'
      vim.g.ghost_cmd = 'split'
      vim.g.ghost_autostart = true
    end,
    config = function()
      local augroups = require'augroups'
      augroups.set{
        my_vim_ghost = {
          {
            'User', 'vim-ghost#connected', function()
              vim.bo.filetype = 'markdown'
              local bufnr = vim.fn.bufnr()
              augroups.set{
                my_vim_ghost_buffer = {
                  {
                    'BufLeave', '<buffer>', function()
                      vim.cmd[[bdelete!]]
                      vim.fn.GhostNotify('closed', bufnr)
                    end,
                  },
                },
              }
            end,
          },
        },
      }
    end,
  },

  {
    'tpope/vim-eunuch',
    config = function()
      vim.env.SUDO_ASKPASS = vim.loop.os_homedir()..'/git/dotfiles/bin/macos-askpass'
    end,
  },

  {
    'tpope/vim-fugitive',
    config = function()
      local vimp = require'vimp'
      vimp.nnoremap('git', [[<Cmd>Git<CR>]])
      vimp.nnoremap('g<Space>', [[<Cmd>Git<CR>]])
      vimp.nnoremap('d<', [[<Cmd>diffget //2<CR>]])
      vimp.nnoremap('d>', [[<Cmd>diffget //3<CR>]])
      vimp.nnoremap('gs', [[<Cmd>Gstatus<CR>]])
      vimp.nnoremap('gc', [[<Cmd>Gbrowse<CR>]])
      vimp.vnoremap('gc', [[<Cmd>Gbrowse<CR>]])
    end,
  },

  {'tpope/vim-repeat'},
  {'tpope/vim-rhubarb'},

  {
    -- 'tpope/vim-unimpaired',
    'delphinus/vim-unimpaired',
    config = function()
      local vimp = require'vimp'
      vimp.nnoremap('[w', [[<Cmd>colder<CR>]])
      vimp.nnoremap(']w', [[<Cmd>cnewer<CR>]])
      vimp.nnoremap('[O', [[<Cmd>lopen<CR>]])
      vimp.nnoremap(']O', [[<Cmd>lclose<CR>]])
    end,
  },


  {'vim-jp/vimdoc-ja'},
  --{'wincent/terminus'},
  {'delphinus/terminus'},
  -- }}}

  -- Syntax {{{
  {'Glench/Vim-Jinja2-Syntax'},
  {'aklt/plantuml-syntax'},
  {'isobit/vim-caddyfile'},

  {'nikvdp/ejs-syntax'},
  {'digitaltoad/vim-pug'},
  {'motemen/xslate-vim'},
  {'moznion/vim-cpanfile'},

  {
    'vim-perl/vim-perl',
    config = function()
      vim.g.perl_include_pod = 1
      vim.g.perl_string_as_statement = 1
      vim.g.perl_sync_dist = 1000
      vim.g.perl_fold = 1
      vim.g.perl_nofold_packages = 1
      vim.g.perl_fold_anonymous_subs = 1
      vim.g.perl_sub_signatures = 1
    end,
  },
  -- }}}

  -- Filetype {{{
  -- {'dag/vim-fish'},
  {'blankname/vim-fish'},
  {'delphinus/vim-firestore'},

  {
    'gisphm/vim-gitignore',
    config = function()
      require'augroups'.set{
        detect_other_ignores = {
          {
            'BufNewFile,BufRead',
            '.gcloudignore',
            '<Cmd>setfiletype gitignore<CR>',
          },
        },
      }
    end,
  },

  {
    'kchmck/vim-coffee-script',
    config = function()
      require'augroups'.set{
        detect_cson = {
          {
            'BufNewFile,BufRead',
            '*.cson',
            '<Cmd>setfiletype coffee<CR>',
          },
        },
      }
    end,
  },

  {'neoclide/jsonc.vim'},
  {'leafo/moonscript-vim'},
  {'mustache/vim-mustache-handlebars'},

  {
    'pearofducks/ansible-vim',
    config = function()
      vim.g.ansible_name_highlight = 'b'
      vim.g.ansible_extra_keywords_highlight = 1
    end,
  },
  -- }}}

  -- vim-script {{{
  {'vim-scripts/HiColors'},

  {
    'vim-scripts/autodate.vim',
    config = [[vim.g.autodate_format = '%FT%T%z']]
  },
  -- }}}

  -- lua-script {{{
  {
    'LumaKernel/nvim-visual-eof.lua',
    config = function()
      require'visual-eof'.setup{
        text_EOL = ' ',
        text_NOEOL = ' ',
        ft_ng = {
          'denite',
          'denite-filter',
          'floaterm',
          'fugitive.*',
          'git.*',
          'packer',
        },
        buf_filter = function(bufnr)
          return vim.api.nvim_buf_get_option(bufnr, 'buftype') == ''
        end,
      }
    end,
  },

  {
    'Xuyuanp/scrollbar.nvim',
    config = function()
      vim.g.scrollbar_shape = {
        head = '╽',
        body = '┃',
        tail = '╿',
      }
      vim.g.scrollbar_highlight = {
        head = 'Todo',
        body = 'Todo',
        tail = 'Todo',
      }
      vim.g.scrollbar_excluded_filetypes = {'denite-filter'}

      local vimp = require'vimp'
      local scrollbar = require'scrollbar'
      local augroups = require'augroups'
      local enabled = false

      vimp.map_command('ToggleScrollbar', function()
        if enabled then
          scrollbar.clear()
          augroups.set{my_scrollbar_nvim = {}}
          enabled = false
        else
          scrollbar.show()
          augroups.set{
            my_scrollbar_nvim = {
              {
                'WinEnter,FocusGained,CursorMoved,VimResized',
                '*',
                scrollbar.show,
              },
              {
                'WinLeave,FocusLost,BufLeave',
                '*',
                scrollbar.clear,
              },
            },
          }
          enabled = true
        end
      end)

      -- TODO: deal with :only in this plugin
      vimp.nnoremap('<C-w>o', function()
        vim.cmd[[only]]
        scrollbar.show()
      end)

      -- start scrollbar
      vim.cmd[[ToggleScrollbar]]
    end,
  },

  {'f-person/git-blame.nvim'},
  -- }}}
}

-- vim:se fdm=marker:
