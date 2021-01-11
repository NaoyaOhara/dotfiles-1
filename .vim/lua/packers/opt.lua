return {
  {'wbthomason/packer.nvim', opt = true},

  -- Colorscheme {{{
  {
    'arcticicestudio/nord-vim',
    opt = true,
    setup = function()
      vim.g.nord_italic = 1
      vim.g.nord_italic_comments = 1
      vim.g.nord_underline = 1
      vim.g.nord_uniform_diff_background = 1
      vim.g.nord_uniform_status_lines = 1
      vim.g.nord_cursor_line_number_background = 1

      require'augroups'.set{
        nord_overrides = {
          {'ColorScheme', 'nord', function()
            vim.cmd[[hi Comment guifg=#CDD0BB]]
            vim.cmd[[hi CursorLine guibg=#313743]]
            vim.cmd[[hi Delimiter guifg=#81A1C1]]
            vim.cmd[[hi DeniteFilter guifg=#D8DEE9 guibg=#183203 ctermfg=NONE ctermbg=0 gui=NONE]]
            vim.cmd[[hi FloatPreview guifg=#D8DEE9 guibg=#183203 ctermfg=NONE ctermbg=0 gui=NONE]]
            vim.cmd[[hi FloatPreviewTransparent guifg=#183203 guibg=#183203 ctermfg=NONE ctermbg=0 gui=NONE]]
            vim.cmd[[hi Folded guifg=#D08770 gui=NONE]]
            vim.cmd[[hi Identifier guifg=#8FBCBB]]
            vim.cmd[[hi NormalFloat guifg=#D8DEE9 guibg=#0B1900 ctermfg=NONE ctermbg=0 gui=NONE]]
            vim.cmd[[hi Special guifg=#D08770]]
            vim.cmd[[hi Title gui=bold cterm=bold]]
            vim.cmd[[hi FloatermBorder gui=bold guifg=#5e81ac]]

            -- for gitgutter
            vim.cmd[[hi SignifyLineAdd ctermbg=233 guibg=#122b0c]]
            vim.cmd[[hi SignifyLineChange ctermbg=236 guibg=#342e0e]]
            vim.cmd[[hi SignifyLineDelete ctermbg=235 guibg=#4e2728]]

            -- for vim-go
            -- See https://github.com/arcticicestudio/nord-vim/pull/219
            vim.cmd[[hi goDeclaration  guifg=#b48ead]]
            vim.cmd[[hi goBuiltins     guifg=#88c0d0]]
            vim.cmd[[hi goFunctionCall guifg=#5e81ac]]
            vim.cmd[[hi goVarDefs      guifg=#bf616a]]
            vim.cmd[[hi goVarAssign    guifg=#bf616a]]
            vim.cmd[[hi goVar          guifg=#b48ead]]
            vim.cmd[[hi goConst        guifg=#b48ead]]
            vim.cmd[[hi goType         guifg=#ebcb8b]]
            vim.cmd[[hi goTypeName     guifg=#ebcb8b]]
            vim.cmd[[hi goDeclType     guifg=#88c0d0]]
            vim.cmd[[hi goTypeDecl     guifg=#b48ead]]

            -- for visual-eof.lua
            vim.cmd[[hi VisualEOL   guifg=#a3be8c]]
            vim.cmd[[hi VisualNoEOL guifg=#bf616a]]

            vim.cmd[[hi GitGutterAddLineNr guifg=#a3be8c guibg=#163601 gui=bold]]
            vim.cmd[[hi GitGutterChangeDeleteLineNr guifg=#ebcb8b guibg=#432d00 gui=bold]]
            vim.cmd[[hi GitGutterChangeLineNr guifg=#ebcb8b guibg=#432d00 gui=bold]]
            vim.cmd[[hi GitGutterDeleteLineNr guifg=#bf616a guibg=#52050c gui=bold]]

            -- for ALE
            vim.cmd[[hi ALEErrorSignLineNr guifg=#bf616a guibg=#52050c gui=bold]]
            vim.cmd[[hi ALEInfoSignLineNr guifg=#5e81ac guibg=#153b68 gui=bold]]
            vim.cmd[[hi ALEStyleErrorSignLineNr guifg=#bf616a guibg=NONE gui=bold]]
            vim.cmd[[hi ALEStyleWarningSignLineNr guifg=#ebcb8b guibg=NONE gui=bold]]
            vim.cmd[[hi ALEWarningSignLineNr guifg=#ebcb8b guibg=#432d00 gui=bold]]
            vim.cmd[[hi ALEErrorSign guifg=#bf616a guibg=#52050c gui=bold]]
            vim.cmd[[hi ALEInfoSign guifg=#5e81ac guibg=#153b68 gui=bold]]
            vim.cmd[[hi ALEStyleErrorSign guifg=#bf616a guibg=NONE gui=bold]]
            vim.cmd[[hi ALEStyleWarningSign guifg=#ebcb8b guibg=NONE gui=bold]]
            vim.cmd[[hi ALEWarningSign guifg=#ebcb8b guibg=#432d00 gui=bold]]
            vim.cmd[[hi ALEVirtualTextError guifg=#bf616a guibg=#52050c gui=bold]]
            vim.cmd[[hi ALEVirtualTextInfo guifg=#5e81ac guibg=#153b68]]
            vim.cmd[[hi ALEVirtualTextStyleError guifg=#bf616a guibg=NONE]]
            vim.cmd[[hi ALEVirtualTextStyleWarning guifg=#ebcb8b guibg=NONE]]
            vim.cmd[[hi ALEVirtualTextWarning guifg=#ebcb8b guibg=#432d00]]

            -- LSP diagnostics
            vim.cmd[[hi LspDiagnosticsDefaultError guifg=#bf616a guibg=#52050c gui=bold]]
            vim.cmd[[hi LspDiagnosticsFloatingError guifg=#bf616a guibg=NONE gui=bold]]
            vim.cmd[[hi LspDiagnosticsUnderlineError guifg=#bf616a guibg=NONE gui=underline]]
            vim.cmd[[hi LspDiagnosticsDefaultHint guifg=#a3be8c guibg=#456c26]]
            vim.cmd[[hi LspDiagnosticsFloatingHint guifg=#a3be8c guibg=NONE]]
            vim.cmd[[hi LspDiagnosticsUnderlineHint guifg=#a3be8c guibg=NONE]]
            vim.cmd[[hi LspDiagnosticsDefaultInformation guifg=#5e81ac guibg=#153b68]]
            vim.cmd[[hi LspDiagnosticsFloatingInformation guifg=#5e81ac guibg=NONE]]
            vim.cmd[[hi LspDiagnosticsUnderlineInformation guifg=#5e81ac guibg=NONE gui=underline]]
            vim.cmd[[hi LspDiagnosticsDefaultWarning guifg=#ebcb8b guibg=#432d00]]
            vim.cmd[[hi LspDiagnosticsFloatingWarning guifg=#ebcb8b guibg=NONE]]
            vim.cmd[[hi LspDiagnosticsUnderlineWarning guifg=#ebcb8b guibg=NONE gui=underline]]
            vim.cmd[[hi link LspReferenceText LspDiagnosticsDefaultInformation]]
            vim.cmd[[hi link LspReferenceRead LspDiagnosticsDefaultHint]]
            vim.cmd[[hi link LspReferenceWrite LspDiagnosticsDefaultWarning]]

            -- for git-blame.nvim
            vim.cmd[[hi gitblame guifg=#4c566a gui=italic]]

            -- nvim-treesitter
            vim.cmd[[hi TSCurrentScope guibg=#313743]]
            vim.cmd[[hi rainbowcol1 guifg=#bf616a]]
            vim.cmd[[hi rainbowcol2 guifg=#d08770]]
            vim.cmd[[hi rainbowcol3 guifg=#b48ead]]
            vim.cmd[[hi rainbowcol4 guifg=#ebcb8b]]
            vim.cmd[[hi rainbowcol5 guifg=#a3b812]]
            vim.cmd[[hi rainbowcol6 guifg=#81a1c1]]
            vim.cmd[[hi rainbowcol7 guifg=#8fbcbb]]

            vim.cmd[[hi TSConditional guifg=#88c0d0]]
            vim.cmd[[hi TSConstant guifg=#d8dee9 gui=bold]]
            vim.cmd[[hi TSConstructor guifg=#ebcb8b gui=bold]]
            vim.cmd[[hi TSException guifg=#88c0d0 gui=italic]]
            vim.cmd[[hi TSKeyword guifg=#9a6590 gui=bold]]
            vim.cmd[[hi TSMethod guifg=#ebcb8b]]
            vim.cmd[[hi TSProperty guifg=#8fbcbb gui=italic]]
            vim.cmd[[hi TSRepeat guifg=#88c0d0]]
            vim.cmd[[hi TSTypeBuiltin guifg=#81a1c1 gui=bold]]
            vim.cmd[[hi TSVariableBuiltin guifg=#d08770]]
          end},
        },
      }
    end,
  },
  -- }}}

  -- cmd {{{
  {'cocopon/colorswatch.vim', cmd = {'ColorSwatchGenerate'}},

  {
    'cocopon/inspecthi.vim',
    cmd = {'Inspecthi', 'InspecthiShowInspector', 'InspecthiHideInspector'}
  },

  {
    'dhruvasagar/vim-table-mode',
    cmd = {'TableModeToggle'},
    setup = function()
      vim.g.table_mode_corner = '|'
      require'vimp'.nnoremap('`tm', [[<Cmd>TableModeToggle<CR>]])
    end,
  },

  {'fuenor/JpFormat.vim', cmd = {'JpFormatAll', 'JpJoinAll'}},

  {
    'iberianpig/tig-explorer.vim',
    requires = {{'rbgrouleff/bclose.vim'}},
    cmd = {
      'Tig',
      'TigOpenCurrentFile',
      'TigOpenProjectRootDir',
      'TigGrep',
      'TigBlame',
      'TigGrepResume',
      'TigStatus',
      'TigOpenFileWithCommit',
    },
    setup = function()
      local vimp = require'vimp'
      vimp.nnoremap('<Leader>T', [[<Cmd>TigOpenCurrentFile<CR>]])
      vimp.nnoremap('<Leader>t', [[<Cmd>TigOpenProjectRootDir<CR>]])
      vimp.nnoremap('<Leader>g', [[<Cmd>TigGrep<CR>]])
      vimp.nnoremap('<Leader>r', [[<Cmd>TigGrepResume<CR>]])
      vimp.vnoremap('<Leader>g', [[y<Cmd>TigGrep<Space><C-R>"<CR>]])
      vimp.nnoremap('<Leader>cg', [[<Cmd><C-u>:TigGrep<Space><C-R><C-W><CR>]])
      vimp.nnoremap('<Leader>b', [[<Cmd>TigBlame<CR>]])
    end,
  },

  {
    'lambdalisue/vim-gista',
    cmd = {'Gista'},
    setup = function()
      local vimp = require'vimp'
      vim.g['gista#command#list#enable_default_mappings'] = 0
      vimp.nnoremap('gl', [[<Cmd>Gista list<CR>]])
      vimp.nnoremap('gL', [[<Cmd>Gista list ]])
    end,
    config = function()
      local vimp = require'vimp'
      require'augroups'.set{
        gista_mappings = {
          {'User', 'GistaList', function()
            -- nmap <buffer> <F5>   <Plug>(gista-update)
            -- nmap <buffer> <S-F5> <Plug>(gista-UPDATE)
            vimp.add_buffer_maps(function()
              vimp.nmap('q', [[<Plug>(gista-quit)]])
              vimp.nmap('<C-n>', [[<Plug>(gista-next-mode)]])
              vimp.nmap('<C-p>', [[<Plug>(gista-prev-mode)]])
              vimp.nmap('?', [[<Plug>(gista-toggle-mapping-visibility)]])
              vimp.nmap('<C-l>', [[<Plug>(gista-redraw)]])
              vimp.nmap('uu', [[<Plug>(gista-update)]])
              vimp.nmap('UU', [[<Plug>(gista-UPDATE)]])
              vimp.nmap('<Return>', [[<Plug>(gista-edit)]])
              vimp.nmap('ee', [[<Plug>(gista-edit)]])
              vimp.nmap('EE', [[<Plug>(gista-edit-right)]])
              vimp.nmap('tt', [[<Plug>(gista-edit-tab)]])
              vimp.nmap('pp', [[<Plug>(gista-edit-preview)]])
              vimp.nmap('ej', [[<Plug>(gista-json)]])
              vimp.nmap('EJ', [[<Plug>(gista-json-right)]])
              vimp.nmap('tj', [[<Plug>(gista-json-tab)]])
              vimp.nmap('pj', [[<Plug>(gista-json-preview)]])
              vimp.nmap('bb', [[<Plug>(gista-browse-open)]])
              vimp.nmap('yy', [[<Plug>(gista-browse-yank)]])
              vimp.nmap('rr', [[<Plug>(gista-rename)]])
              vimp.nmap('RR', [[<Plug>(gista-RENAME)]])
              vimp.nmap('df', [[<Plug>(gista-remove)]])
              vimp.nmap('DF', [[<Plug>(gista-REMOVE)]])
              vimp.nmap('dd', [[<Plug>(gista-delete)]])
              vimp.nmap('DD', [[<Plug>(gista-DELETE)]])
              vimp.nmap('++', [[<Plug>(gista-star)]])
              vimp.nmap('--', [[<Plug>(gista-unstar)]])
              vimp.nmap('ff', [[<Plug>(gista-fork)]])
              vimp.nmap('cc', [[<Plug>(gista-commits)]])
            end)
          end},
        },
      }

      if vim.fn.exists('g:gista_github_api_path') then
        local apinames = vim.fn['gista#client#get_available_apinames']()
        for _, n in ipairs(apinames) do
          if n == 'GHE' then
            vim.fn['gista#client#register'](n, vim.g.gista_github_api_path)
            break
          end
        end
      end
    end,
  },

  {
    'mbbill/undotree',
    cmd = {'UndotreeToggle'},
    setup = function()
      vim.g.undotree_HelpLine = 0
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_ShortIndicators = 1
      vim.g.undotree_TreeNodeShape = '●'
      vim.g.undotree_WindowLayout = 2
      require'vimp'.nnoremap('<A-u>', [[<Cmd>UndotreeToggle<CR>]])
    end,
  },

  {
    'norcalli/nvim-colorizer.lua',
    cmd = {
      'ColorizerAttachToBuffer',
      'ColorizerDetachFromBuffer',
      'ColorizerReloadAllBuffers',
    },
    setup = function()
      require'vimp'.nnoremap({'silent'}, '<A-C>', function()
        if vim.b.colorizer_enabled then
          vim.cmd[[ColorizerDetachFromBuffer]]
          vim.b.colorizer_enabled = false
          vim.cmd[[echohl Debug]]
          vim.cmd[[echomsg 'colorizer.lua disabled']]
          vim.cmd[[echohl None]]
        else
          vim.cmd[[ColorizerAttachToBuffer]]
          vim.b.colorizer_enabled = 1
          vim.cmd[[echohl Debug]]
          vim.cmd[[echomsg 'colorizer.lua enabled']]
          vim.cmd[[echohl None]]
        end
      end)
    end,
  },

  {
    'npxbr/glow.nvim',
    cmd = {'Glow', 'GlowInstall'},
    setup = [=[require'vimp'.nnoremap('<Leader>p', [[<Cmd>Glow<CR>]])]=],
    run = [[:GlowInstall]],
  },

  {'powerman/vim-plugin-AnsiEsc', cmd = {'AnsiEsc'}},

  {
    'rhysd/ghpr-blame.vim',
    cmd = {'GHPRBlame'},
    config = function()
      local settings = vim.fn.expand'~/.ghpr-blame.vim'
      if vim.fn.filereadable(settings) == 1 then
        vim.cmd('source '..settings)
        vim.g.ghpr_show_pr_mapping = '<A-g>'
        vim.g.ghpr_show_pr_in_message = 1
      else
        vim.cmd[[echohl WarningMsg]]
        vim.cmd('file not found: '..settings)
        vim.cmd[[echohl None]]
      end
    end,
  },

  {
    'rhysd/git-messenger.vim',
    cmd = {'GitMessenger'},
    setup = function()
      vim.g.git_messenger_no_default_mappings = true
      require'vimp'.nnoremap('<A-b>', [[<Cmd>GitMessenger<CR>]])
    end,
  },

  {
    'tyru/capture.vim',
    requires = {
      {'thinca/vim-prettyprint', cmd = {'PP', 'PrettyPrint'}},
    },
    cmd = {'Capture'},
  },

  {
    'tyru/open-browser.vim',
    cmd = {'OpenBrowser', 'OpenBrowserSearch'},
    keys = {
      'g<CR>',
      {'v', 'g<CR>'},
    },
    setup = function()
      require'augroups'.set{
        load_open_browser = {
          {'FuncUndefined', 'openbrowser#open', 'packadd open-browser.vim'},
        },
      }
    end,
    config = function()
      require'vimp'.rbind('nv', 'g<CR>', [[<Plug>(openbrowser-smart-search)]])
    end,
  },

  {'tweekmonster/startuptime.vim', cmd = {'StartupTime'}},

  {
    'vifm/vifm.vim',
    cmd = {'EditVifm', 'VsplitVifm', 'SplitVifm', 'DiffVifm', 'TabVifm'},
    ft = {'vifm'},
  },

  {
    'voldikss/vim-floaterm',
    cmd = {
      'FloatermNew', 'FloatermPrev', 'FloatermNext',
      'FloatermToggle', 'FloatermInfo',
    },
    setup = function()
      vim.g.floaterm_borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'}
      vim.g.floaterm_open_command = 'split'
      vim.g.floaterm_position = 'center'
      local vimp = require'vimp'
      vimp.tnoremap('<BS><C-n>', [[<C-\><C-n>]])
      vimp.nnoremap([[<C-\><C-n>]], [[<Cmd>FloatermToggle<CR>]])
      vimp.nnoremap('<BS><C-n>', [[<Cmd>FloatermToggle<CR>]])
      vimp.nnoremap('<A-c>', [[<Cmd>FloatermToggle<CR>]])
      vimp.tnoremap('<A-c>', [[<Cmd>FloatermToggle<CR>]])
      vimp.nnoremap('<A-n>', [[<Cmd>FloatermNew<CR>]])
      vimp.tnoremap('<A-n>', [[<Cmd>FloatermNew<CR>]])
      vimp.nnoremap('<A-f>', [[<Cmd>FloatermNext<CR>]])
      vimp.tnoremap('<A-f>', [[<Cmd>FloatermNext<CR>]])
    end,
  },
  -- }}}

  -- event {{{
  -- TODO: use CmdlineEnter
  -- {'delphinus/vim-emacscommandline', event = {'CmdlineEnter'}},
  {'delphinus/vim-emacscommandline'},

  {
    'delphinus/vim-unimpaired',
    event = {'FocusLost', 'CursorHold'},
    setup = function()
      local vimp = require'vimp'
      vimp.nnoremap('[w', [[<Cmd>colder<CR>]])
      vimp.nnoremap(']w', [[<Cmd>cnewer<CR>]])
      vimp.nnoremap('[O', [[<Cmd>lopen<CR>]])
      vimp.nnoremap(']O', [[<Cmd>lclose<CR>]])
    end,
  },

  {'itchyny/vim-cursorword', event = {'FocusLost', 'CursorHold'}},

  {
    'itchyny/vim-parenmatch',
    event = {'FocusLost', 'CursorHold'},
    setup = [[vim.g.loaded_matchparen = 1]],
    config = [[vim.fn['parenmatch#highlight']()]]
  },

  {
    'preservim/tagbar',
    event = {'FocusLost', 'CursorHold'},
    setup = function()
      vim.g.tagbar_autoclose = 1
      vim.g.tagbar_autofocus = 1
      vim.g.tagbar_autopreview = 1
      vim.g.tagbar_iconchars = {' ', ' '} -- 0xe5ff, 0xe5fe
      vim.g.tagbar_left = 1
      vim.g.tagbar_show_linenumbers = 1
      -- public:    ○
      -- protected: □
      -- private:   ●
      vim.g.tagbar_visibility_symbols = {
        public = '○ ', -- 0x25cb
        protected = '□ ', -- 0x25a1
        private = '● ', -- 0x25cf
      }

      require'augroups'.set{
        tagbar_window = {
          {'BufWinEnter', '*', function()
            if vim.wo.previewwindow == 1 then
              vim.wo.number = false
              vim.wo.relativenumber = false
            end
          end},
        },
      }

      require'vimp'.nmap('<C-t>', [[<Cmd>TagbarToggle<CR>]])
    end,
  },
  -- }}}

  -- ft {{{
  {'Vimjas/vim-python-pep8-indent', ft = {'python'}},
  {'aliou/bats.vim', ft = {'bats'}},
  {'c9s/perlomni.vim', ft = {'perl'}},
  {'cespare/vim-toml', ft = {'toml'}},
  {'dNitro/vim-pug-complete', ft = {'pug'}},
  {'delphinus/vim-data-section-simple', ft = {'perl'}},
  {'delphinus/vim-toml-dein', ft = {'toml'}},

  {
    'dense-analysis/ale',
    ft = {
      'javascript',
      'json',
      'perl',
      'python',
      'ruby',
      'sh',
      'typescript',
      'vim',
    },
    setup = function()
      vim.g.ale_fixers = {
        javascript = {'eslint'},
        json = {'eslint'},
        python = {'black'},
        ruby = {'rubocop'},
        typescript = {'eslint'},
      }
      vim.g.ale_linters = {
        go = {},
        javascript = {},
        json = {},
        typescript = {},
        perl = {'perl'},
        python = {},
        sh = {'shellcheck'},
        vim = {'vint'},
      }
      vim.g.ale_completion_autoimport = 1
      vim.g.ale_echo_msg_error_str = '▸' -- 0x25b8"
      vim.g.ale_echo_msg_format = '%severity%  %linter% - %s'
      vim.g.ale_echo_msg_info_str = '▴' -- 0x25b4
      vim.g.ale_echo_msg_warning_str = '▹' -- 0x25b9
      vim.g.ale_fix_on_save = 1
      vim.g.ale_go_golangci_lint_options = '--enable-all -D gochecknoglobals,gochecknoinits'
      vim.g.ale_go_golangci_lint_package = 1
      vim.g.ale_javascript_eslint_suppress_eslintignore = 1
      vim.g.ale_javascript_eslint_suppress_missing_config = 1
      vim.g.ale_perl_perl_executable = vim.env.HOME..'/.plenv/shims/perl'
      vim.g.ale_python_mypy_detect_notes = 1
      vim.g.ale_python_mypy_options = '--show-column-numbers --strict'
      vim.g.ale_python_pylint_change_directory = 0
      vim.g.ale_set_loclist = 1
      vim.g.ale_sh_shellcheck_options = '-x'
      vim.g.ale_sign_column_always = 1
      vim.g.ale_sign_error =  '▸' -- 0x25b8
      vim.g.ale_sign_highlight_linenrs = 1
      vim.g.ale_sign_warning =  '▹' -- 0x25b9
      vim.g.ale_statusline_format = {'▸ %d', '▹ %d', '▴ %d'} -- 0x25b8, 0x25b9, 0x25b4
      vim.g.ale_virtualtext_cursor = 1
      vim.g.ale_virtualtext_delay = 100
      vim.g.ale_virtualtext_prefix = '■ALE: ' -- 0x25a0
      -- nmap <silent> <A-K> <Plug>(ale_previous_wrap)
      -- nmap <silent> <A-J> <Plug>(ale_next_wrap)
      vim.g.ale_completion_symbols = {
        text = ' ',
        method = '',
        ['function'] = ' ',
        constructor = ' ',
        field = ' ',
        variable = ' ',
        class = ' ',
        interface = ' ',
        module = ' ',
        property = ' ',
        unit = 'unit',
        value = 'val',
        enum = ' ',
        keyword = 'keyword',
        snippet = ' ',
        color = 'color',
        file = ' ',
        reference = 'ref',
        folder = ' ',
        ['enum member'] = ' ',
        constant = ' ',
        struct = ' ',
        event = 'event',
        operator = ' ',
        type_parameter = 'type param',
        ['<default>'] = 'v',
      }
    end,
    run = function()
      vim.cmd[[!gem install --user-install rubocop]]
      vim.cmd[[!npm install -g eslint prettier]]
      vim.cmd[[!pip3 install -U --user black git+https://github.com/Vimjas/vint]]
    end,
  },

  {'derekwyatt/vim-scala', ft = {'scala'}},
  {'dsawardekar/wordpress.vim', ft = {'php'}},

  {
    'fatih/vim-go',
    ft = {'go'},
    setup = function()
      vim.g.go_addtags_transform = 'camelcase'
      vim.g.go_alternate_mode = 'split'
      vim.g.go_auto_sameids = 1
      vim.g.go_auto_type_info = 1
      vim.g.go_autodetect_gopath = 0
      vim.g.go_code_completion_enabled = 0
      vim.g.go_def_mapping_enabled = 0
      vim.g.go_doc_keywordprg_enabled = 0
      vim.g.go_doc_popup_window = 1
      vim.g.go_fmt_command = 'goimports'
      vim.g.go_fmt_experimental = 1
      vim.g.go_fmt_fail_silently = 1
      vim.g.go_fmt_options = {gofmt = '-s'}
      vim.g.go_gocode_unimported_packages = 1
      vim.g.go_gopls_enabled = 1
      vim.g.go_gopls_complete_unimported = 1
      vim.g.go_gopls_deep_completion = 1
      vim.g.go_gopls_fuzzy_matching = 1
      vim.g.go_gopls_use_placeholders = 1
      vim.g.go_highlight_array_whitespace_error = 1
      vim.g.go_highlight_build_constraints = 1
      vim.g.go_highlight_chan_whitespace_error = 1
      vim.g.go_highlight_diagnostic_errors = 1
      vim.g.go_highlight_diagnostic_warnings = 1
      vim.g.go_highlight_extra_types = 1
      vim.g.go_highlight_fields = 1
      vim.g.go_highlight_format_strings = 1
      vim.g.go_highlight_functions = 1
      vim.g.go_highlight_function_parameters = 1
      vim.g.go_highlight_function_calls = 1
      vim.g.go_highlight_generate_tags = 1
      vim.g.go_highlight_operators = 1
      vim.g.go_highlight_space_tab_error = 1
      vim.g.go_highlight_string_spellcheck = 1
      vim.g.go_highlight_types = 1
      vim.g.go_highlight_trailing_whitespace_error = 1
      vim.g.go_highlight_variable_declarations = 1
      vim.g.go_highlight_variable_assignments = 1
      vim.g.go_metalinter_autosave = 0
      vim.g.go_metalinter_deadline = '10s'
      vim.g.go_template_use_pkg = 1
      vim.g.go_updatetime = 1
    end,
  },

  {'hail2u/vim-css3-syntax', ft = {'css'}},
  {'junegunn/vader.vim', ft = {'vader'}},
  {'leafo/moonscript-vim', ft = {'moon'}},

  {
    'motemen/vim-syntax-hatena',
    ft = {'hatena'},
    config = [[vim.g.hatena_syntax_html = true]],
  },

  {'msanders/cocoa.vim', ft = {'objc'}},
  {'pboettch/vim-cmake-syntax', ft = {'cmake'}},
  {'posva/vim-vue', ft = {'vue'}},
  {'tmux-plugins/vim-tmux', ft = {'tmux'}},

  {
    'rhysd/vim-textobj-ruby',
    requires = {{'kana/vim-textobj-user'}},
    ft = {'ruby'},
  },

  {'rust-lang/rust.vim', ft = {'rust'}},

  {
    'tpope/vim-endwise',
    ft = {
      'lua', 'elixir', 'ruby', 'crystal', 'sh', 'zsh', 'vb', 'vbnet', 'aspvbs',
      'vim', 'c', 'cpp', 'xdefaults', 'objc', 'matlab',
    },
  },

  {'uarun/vim-protobuf', ft = {'proto'}},

  {
    'delphinus/vim-rails',
    branch = 'feature/recognize-ridgepole',
    ft = {'ruby'},
  },

  {'vim-scripts/a.vim', ft = {'c', 'cpp'}},
  {'vim-scripts/applescript.vim', ft = {'applescript'}},
  {'vim-scripts/fontforge_script.vim', ft = {'fontforge_script'}},
  {'vim-scripts/nginx.vim', ft = {'nginx'}},
  -- }}}

  -- keys {{{
  {
    'arecarn/vim-fold-cycle',
    keys = {'<A-l>', '<A-h>'},
    config = function()
      vim.g.fold_cycle_default_mapping = 0
      local vimp = require'vimp'
      vimp.nmap('<A-l>', [[<Plug>(fold-cycle-open)]])
      vimp.nmap('<A-h>', [[<Plug>(fold-cycle-close)]])
    end,
  },

  {
    'bfredl/nvim-miniyank',
    keys = {'p', 'P', '<A-p>', '<A-P>'},
    config = function()
      vim.g.miniyank_maxitems = 100
      local vimp = require'vimp'
      vimp.nmap('p', [[<Plug>(miniyank-autoput)]])
      vimp.nmap('P', [[<Plug>(miniyank-autoPut)]])
      vimp.nmap('<A-p>', [[<Plug>(miniyank-cycle)]])
      vimp.nmap('<A-P>', [[<Plug>(miniyank-cycleback)]])
    end,
  },

  {
    'chikatoike/concealedyank.vim',
    keys = {{'x', 'Y'}},
    config = function()
      require'vimp'.xmap('Y', [[<Plug>(operator-concealedyank)]])
    end
  },

  {
    'delphinus/dwm.vim',
    branch = 'feature/disable',
    keys = {
      '<A-CR>',
      '<A-r>',
      '<C-@>',
      '<C-Space>',
      '<C-c>',
      '<C-j>',
      '<C-k>',
      '<C-l>',
      '<C-n>',
      '<C-q>',
      '<C-s>',
    },
    setup = function()
      vim.g.dwm_map_keys = 0
    end,
    config = function()
      function _G.dwm_preview()
        if vim.wo.previewwindow == 1 then
          vim.b.dwm_disabled = 1
        end
      end

      nvim_create_augroups{
        dwm_preview = {
          {'BufRead', '*', [[lua dwm_preview()]]},
        },
      }

      local vimp = require'vimp'
      vimp.nnoremap({'silent'}, '<Plug>DWMResetPaneWidth', function()
        local half = vim.o.columns / 2
        local width = vim.g.dwm_min_master_pane_width or 9999
        vim.g.dwm_master_pane_width = math.min(width, half)
        vim.fn.DWM_ResizeMasterPaneWidth()
      end)

      vimp.nmap('<A-CR>', [[<Plug>DWMFocus]])
      vimp.nmap('<A-r>', [[<Plug>DWMResetPaneWidth]])
      vimp.nmap('<C-@>', [[<Plug>DWMFocus]])
      vimp.nmap('<C-Space>', [[<Plug>DWMFocus]])
      vimp.nmap('<C-c>', [[<Cmd>lua require'scrollbar'.clear()<CR><Plug>DWMClose]])
      vimp.nnoremap('<C-j>', [[<C-w>w]])
      vimp.nnoremap('<C-k>', [[<C-w>W]])
      vimp.nmap('<C-l>', [[<Plug>DWMGrowMaster]])
      vimp.nmap('<C-n>', [[<Plug>DWMNew]])
      vimp.nmap('<C-q>', [[<Plug>DWMRotateCounterclockwise]])
      vimp.nmap('<C-s>', [[<Plug>DWMRotateClockwise]])
    end,
  },

  {'delphinus/vim-tmux-copy', keys = {'<A-[>'}},

  {
    'easymotion/vim-easymotion',
    cmd = {'EMCommandLineMap', 'EMCommandLineNoreMap', 'EMCommandLineUnMap'},
    keys = {
      [[']],
      {'x', [[']]},
      {'o', [[']]},
      's',
      {'x', 's'},
      {'o', 's'},
    },
    setup = function()
      vim.g.EasyMotion_enter_jump_first = 1
      vim.g.EasyMotion_grouping = 1
      vim.g.EasyMotion_keys = 'hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
      vim.g.EasyMotion_leader_key = [[']]
      vim.g.EasyMotion_space_jump_first = 1
      vim.g.EasyMotion_use_migemo = 1
    end,
    config = function()
      require'vimp'.rbind('nxo', 's', [[<Plug>(easymotion-s2)]])
    end,
  },

  {
    'iamcco/markdown-preview.nvim',
    cmd = {'MarkdownPreview', 'MarkdownPreviewStop'},
    ft = {'markdown'},
    setup = function()
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_echo_preview_url = 1
      vim.g.mkdp_open_to_the_world = 1
    end,
    run = 'cd app && yarn',
  },

  {
    'inkarkat/vim-LineJuggler',
    requires = {
      {'inkarkat/vim-ingo-library'},
      {'vim-repeat'},
      {'vim-scripts/visualrepeat'},
    },
    keys = {
      '[d',
      ']d',
      '[E',
      ']E',
      '[e',
      ']e',
      '[f',
      ']f',
      '[<Space>',
      ']<Space>',
    },
  },

  {
    'junegunn/vim-easy-align',
    keys = {{'v', '<CR>'}},
    setup = function()
      local vimp = require'vimp'
      vimp.vmap('<CR>', '<Plug>(EasyAlign)')

      vim.g.easy_align_delimiters = {
        ['>'] = { pattern = [[>>\|=>\|>]] },
        ['/'] = { pattern = [[//\+\|/\*\|\*/]], ignore_groups = {'String'} },
        ['#'] = {
          pattern = [[#\+]],
          ignore_groups = {'String'},
          delimiter_align = 'l',
        },
        [']'] = {
            pattern = [=[[[\]]]=],
            left_margin = 0,
            right_margin = 0,
            stick_to_left = 0
        },
        [')'] = {
            pattern = '[()]',
            left_margin = 0,
            right_margin = 0,
            stick_to_left = 0
          },
        ['d'] = {
            pattern = [[ \(\S\+\s*[;=]\)\@=]],
            left_margin = 0,
            right_margin = 0
          }
        }
    end
  },

  {
    't9md/vim-quickhl',
    keys = {
      '<Space>m',
      '<Space>M',
      '<Space>t',
      {'x', '<Space>m'},
      {'x', '<Space>M'},
      {'x', '<Space>t'},
    },
    config = function()
      local vimp = require'vimp'
      vimp.rbind('nx', '<Space>m', [[<Plug>(quickhl-manual-this)]])
      vimp.rbind('nx', '<Space>t', [[<Plug>(quickhl-manual-toggle)]])
      vimp.rbind('nx', '<Space>M', [[<Plug>(quickhl-manual-reset)]])
    end,
  },

  {
    'thinca/vim-fontzoom',
    -- TODO: set these mapping in GUI only?
    keys = {'+', '-', '<C-ScrollWheelUp>', '<C-ScrollWheelDown>'},
    cond = [[vim.fn.has('gui') == 1]],
    config = function()
      local vimp = require'vimp'
      vimp.rbind('n', {'unique', 'silent'}, {'+', '<C-ScrollWheelUp>'}, [[<Plug>(fontzoom-larger)]])
      vimp.rbind('n', {'unique', 'silent'}, {'-', '<C-ScrollWheelDown>'}, [[<Plug>(fontzoom-smaller)]])
    end,
  },

  {
    'thinca/vim-visualstar',
    keys = {'*'},
    setup = function()
      vim.g.visualstar_no_default_key_mappings = 1
    end,
    config = function()
      require'vimp'.xmap({'unique'}, '*', [[<Plug>(visualstar-*)]])
    end,
  },

  {
    'tyru/columnskip.vim',
    keys = {
      '[j',
      '[k',
      ']j',
      ']k',
      {'o', '[j'},
      {'o', '[k'},
      {'o', ']j'},
      {'o', ']k'},
      {'x', '[j'},
      {'x', '[k'},
      {'x', ']j'},
      {'x', ']k'},
    },
    config = function()
      local vimp = require'vimp'
      vimp.rbind('nxo', '[j', [[<Plug>(columnskip:nonblank:next)]])
      vimp.rbind('nxo', '[k', [[<Plug>(columnskip:nonblank:prev)]])
      vimp.rbind('nxo', ']j', [[<Plug>(columnskip:first-nonblank:next)]])
      vimp.rbind('nxo', ']k', [[<Plug>(columnskip:first-nonblank:prev)]])
    end,
  },
  -- }}}

  -- func {{{
  {
    'sainnhe/artify.vim',
    opt = true,
    setup = function()
      nvim_create_augroups{
        load_artify = {
          {'FuncUndefined', 'Artify', 'packadd artify.vim'},
        },
      }
    end,
  },

  {
    'vim-jp/vital.vim',
    opt = true,
    setup = function()
      nvim_create_augroups{
        load_vital = {
          {'FuncUndefined', 'vital#vital#new', 'packadd artify.vim'},
        },
      }
    end,
  },
  -- }}}
}

-- vim:se fdm=marker:
