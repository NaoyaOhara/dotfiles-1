return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      local vimp = require'vimp'

      vim.cmd[[sign define LspDiagnosticsSignError text=● texthl=LspDiagnosticsDefaultError linehl= numhl=]]
      vim.cmd[[sign define LspDiagnosticsSignWarning text=○ texthl=LspDiagnosticsDefaultWarning linehl= numhl=]]
      vim.cmd[[sign define LspDiagnosticsSignInformation text=■ texthl=LspDiagnosticsDefaultInformation linehl= numhl=]]
      vim.cmd[[sign define LspDiagnosticsSignHint text=□ texthl=LspDiagnosticsDefaultHint linehl= numhl=]]

      vimp.map_command('ShowLSPSettings', function()
        print(vim.inspect(vim.lsp.buf_get_clients()))
      end)
      vimp.map_command('ReloadLSPSettings', function()
        vim.lsp.stop_client(vim.lsp.get_active_clients())
        vim.cmd[[edit]]
      end)

      local lsp_on_attach = function(client)
        print('LSP & completion started.')
        require'completion'.on_attach()

        if client.config.flags then
          client.config.flags.allow_incremental_sync = true
        end

        vimp.add_buffer_maps(function()
          vimp.nnoremap('1gD', vim.lsp.buf.type_definition)
          vimp.nnoremap('<A-J>', vim.lsp.diagnostic.goto_next)
          vimp.nnoremap('<A-K>', vim.lsp.diagnostic.goto_prev)
          vimp.nnoremap('<C-]>', vim.lsp.buf.definition)
          vimp.nnoremap('<C-w><C-]>', function()
            vim.cmd[[split]]
            vim.lsp.buf.definition()
          end)
          vimp.nnoremap('<C-x><C-k>', vim.lsp.buf.signature_help)
          vimp.nnoremap('K', vim.lsp.buf.hover)
          vimp.nnoremap('g0', vim.lsp.buf.document_symbol)
          vimp.nnoremap('g=', vim.lsp.buf.formatting)
          vimp.nnoremap('gA', vim.lsp.buf.code_action)
          vimp.nnoremap('gD', vim.lsp.buf.implementation)
          vimp.nnoremap('gK', vim.lsp.util.show_line_diagnostics)
          vimp.nnoremap('gR', vim.lsp.buf.rename)
          vimp.nnoremap('gW', vim.lsp.buf.workspace_symbol)
          vimp.nnoremap('gd', vim.lsp.buf.declaration)
          vimp.nnoremap('gli', vim.lsp.buf.incoming_calls)
          vimp.nnoremap('glo', vim.lsp.buf.outgoing_calls)
          vimp.nnoremap('gr', vim.lsp.buf.references)
        end)
      end

      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
          underline = true,
          virtual_text = true,
          signs = true,
        }
      )

      local lsp = require'lspconfig'
      lsp.bashls.setup{on_attach = lsp_on_attach}
      lsp.clangd.setup{on_attach = lsp_on_attach}
      lsp.cssls.setup{on_attach = lsp_on_attach}
      lsp.dockerls.setup{on_attach = lsp_on_attach}
      -- lsp.efm.setup{on_attach = lsp_on_attach}
      lsp.html.setup{on_attach = lsp_on_attach}
      lsp.jsonls.setup{on_attach = lsp_on_attach}
      lsp.pyright.setup{on_attach = lsp_on_attach}
      lsp.solargraph.setup{on_attach = lsp_on_attach}
      lsp.tsserver.setup{on_attach = lsp_on_attach}
      lsp.vimls.setup{on_attach = lsp_on_attach}
      lsp.yamlls.setup{on_attach = lsp_on_attach}

      lsp.gopls.setup{
        on_attach = lsp_on_attach,
        settings = {
          hoverKind = 'NoDocumentation',
          deepCompletion = true,
          fuzzyMatching = true,
          completeUnimported = true,
          usePlaceholders = true,
        },
      }

      local sumneko_root_path = vim.env.HOME..'/git/github.com/sumneko/lua-language-server'
      local sumneko_binary = sumneko_root_path..'/bin/macOS/lua-language-server'

      lsp.sumneko_lua.setup{
        on_attach = lsp_on_attach,
        cmd = {sumneko_binary, '-E', sumneko_root_path..'/main.lua'},
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
              path = vim.split(package.path, ';'),
            },
            completion = {
              keywordSnippet = 'Disable',
            },
            diagnostics = {
              enable = true,
              globals = {
                'vim', 'describe', 'it', 'before_each', 'after_each',
              },
            },
            workspace = {
              library = {
                [vim.fn.expand'$VIMRUNTIME/lua'] = true,
                [vim.fn.expand'$VIMRUNTIME/lua/vim/lsp'] = true,
                -- TODO: use robust way to detect plugins
                [vim.fn.expand'~/.local/share/nvim/site/pack/packer/start/vimpeccable/lua'] = true,
              },
            },
          }
        }
      }
    end,
    run = function()
      -- TODO: update sumneko_lua automatically
      vim.cmd[[!gem install --user-install solargraph]]
      vim.cmd[[!go get -v -u golang.org/x/tools/gopls@latest]]
      vim.cmd[[!npm i -g bash-language-server]]
      vim.cmd[[!npm i -g dockerfile-language-server-nodejs]]
      vim.cmd[[!npm i -g pyright]]
      vim.cmd[[!npm i -g typescript typescript-language-server]]
      vim.cmd[[!npm i -g vim-language-server]]
      vim.cmd[[!npm i -g vscode-css-languageserver-bin]]
      vim.cmd[[!npm i -g vscode-html-languageserver-bin]]
      vim.cmd[[!npm i -g vscode-json-languageserver]]
      vim.cmd[[!npm i -g yaml-language-server]]
    end,
  },

  {
    'nvim-lua/completion-nvim',
    requires = {
      {'steelsojka/completion-buffers'},
      {'nvim-treesitter/completion-treesitter'},
      {'kristijanhusak/completion-tags'},
      {'albertoCaroM/completion-tmux'},
    },
    config = function()
      for _, name in ipairs{
        'completion-buffers',
        'completion-treesitter',
        'completion-tags',
        'completion-tmux',
      } do vim.cmd('packadd '..name) end

      local vimp = require'vimp'

      require'augroups'.set{
        enable_completion_nvim = {
          {'BufEnter', '*', require'completion'.on_attach},
        },
      }

      vimp.inoremap({'expr'}, '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
      vimp.inoremap({'expr'}, '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])
      vimp.imap('<C-j>', [[<Plug>(completion_next_source)]])
      vimp.imap('<C-k>', [[<Plug>(completion_prev_source)]])

      vim.o.completeopt = 'menuone,noinsert,noselect'
      vim.g.completion_auto_change_source = 1
      vim.g.completion_confirm_key = [[\<C-y>]]
      vim.g.completion_matching_strategy_list = {'exact', 'fuzzy'}
      vim.g.completion_chain_complete_list = {
        default = {
          default = {
            {complete_items = {'lsp', 'tags'}},
            {complete_items = {'ts', 'buffers', 'tmux'}},
            {complete_items = {'path'}, triggered_only = {'/'}},
            {mode = 'omni'},
            {mode = '<C-p>'},
            {mode = '<C-n>'},
            {mode = 'keyn'},
            {mode = 'keyp'},
            {mode = 'file'},
            {mode = 'dict'},
          },
          comment = {},
        },
      }
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      {
        'delphinus/nvim-treesitter-refactor',
        branch = 'hotfix/help-tags',
      },

      {'nvim-treesitter/nvim-treesitter-textobjects'},
      {'nvim-treesitter/playground'},
      {'p00f/nvim-ts-rainbow'},
      {'romgrk/nvim-treesitter-context'},
    },
    config = function()
      for _, name in ipairs{
        'nvim-treesitter-context',
        'nvim-treesitter-textobjects',
        'nvim-treesitter-refactor',
        'nvim-ts-rainbow',
        'playground',
      } do vim.cmd('packadd '..name) end

      require'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true,
          disable = { 'toml' },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
          },
        },
        ensure_installed = 'all',
        playground = {
          enable = true,
          disable = {},
          updatetime = 25,
          persist_queries = false,
        },
        refactor = {
          highlight_definitions = { enable = true },
          highlight_current_scope = { enable = true },
          smart_rename = {
            enable = true,
            keymaps = {
              smart_rename = 'grr',
            },
          },
          navigation = {
            enable = true,
            keymaps = {
              goto_definition = 'gnd',
              list_definition = 'gnD',
              list_definition_toc = 'gO',
              goto_next_usage = '<A-*>',
              goto_previous_usage = '<A-#>',
            },
          },
        },
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['aC'] = '@class.outer',
              ['iC'] = '@class.inner',
              ['ac'] = '@conditional.outer',
              ['ic'] = '@conditional.inner',
              ['ae'] = '@block.outer',
              ['ie'] = '@block.inner',
              ['al'] = '@loop.outer',
              ['il'] = '@loop.inner',
              ['is'] = '@statement.inner',
              ['as'] = '@statement.outer',
              ['ad'] = '@comment.outer',
              ['am'] = '@call.outer',
              ['im'] = '@call.inner',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
          move = {
            enable = true,
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          lsp_interop = {
            enable = true,
            peek_definition_code = {
              ['Df'] = '@function.outer',
              ['DF'] = '@class.outer',
            },
          },
        },
        rainbow = {
          enable = false,
          -- See https://github.com/p00f/nvim-ts-rainbow/issues/1
          disable = {'bash'},
        },
      }
    end,
    run = ':TSUpdate'
  },
}
