return {
  'nvim-telescope/telescope.nvim',
  --'delphinus/telescope.nvim',
  --branch = 'file_browser',
  requires = {
    {'delphinus/telescope-memo.nvim', opt = true},
    {'kyazdani42/nvim-web-devicons', opt = true},
    {'nvim-lua/popup.nvim', opt = true},
    {'nvim-telescope/telescope-ghq.nvim', opt = true},
    {'nvim-telescope/telescope-github.nvim', opt = true},
    {'nvim-telescope/telescope-node-modules.nvim', opt = true},
    {'nvim-telescope/telescope-packer.nvim', opt = true},
    {'nvim-telescope/telescope-symbols.nvim', opt = true},
    {'nvim-telescope/telescope-z.nvim', opt = true},
    {'plenary.nvim'},

    {
      'nvim-telescope/telescope-frecency.nvim',
      requires = {'tami5/sql.nvim'},
      opt = true,
    },

    {
      --'nvim-telescope/telescope-fzf-writer.nvim',
      'delphinus/telescope-fzf-writer.nvim',
      branch = 'feature/use-cwd',
      opt = true,
    },
  },
  cmd = {'Telescope'},
  keys = {
    '<Leader>ff',
    '<Leader>fg',
    '<Leader>fb',
    '<Leader>fh',
    '<Leader>fH',
    '<Leader>fm',
    '<Leader>fo',
    '<Leader>fp',
    '<Leader>fq',
    '<Leader>fz',
    '<Leader>f:',
    '<Leader>mm',
    '<Leader>mg',
    '<Leader>sr',
    '<Leader>sd',
    '<Leader>sw',
    '<Leader>sc',
    '<Leader>gc',
    '<Leader>gb',
    '<Leader>gr',
    '<Leader>gs',
    '#',
  },
  config = function()
    for _, name in pairs{
      'nvim-web-devicons',
      'popup.nvim',
      'sql.nvim',
      'telescope-frecency.nvim',
      'telescope-fzf-writer.nvim',
      'telescope-ghq.nvim',
      'telescope-github.nvim',
      'telescope-memo.nvim',
      'telescope-node-modules.nvim',
      'telescope-packer.nvim',
      'telescope-symbols.nvim',
      'telescope-z.nvim',
    } do
      vim.cmd('packadd '..name)
    end

    local actions = require'telescope.actions'
    local builtin = require'telescope.builtin'
    local telescope = require'telescope'
    local extensions = telescope.extensions
    local m = require'mapper'

    local run_find_files = function(prompt_bufnr)
      local selection = actions.get_selected_entry()
      actions.close(prompt_bufnr)
      builtin.find_files{cwd = selection.value}
    end

    local run_live_grep = function(prompt_bufnr)
      local selection = actions.get_selected_entry()
      if vim.fn.isdirectory(selection.value) == 1 then
        actions.close(prompt_bufnr)
        extensions.fzf_writer.staged_grep{cwd = selection.value}
      else
        vim.api.nvim_echo({{'This is not a directory.', 'WarningMsg'}}, true, {})
      end
    end

    local preview_scroll = function(direction)
      return function(prompt_bufnr)
        actions.get_current_picker(prompt_bufnr).previewer:scroll_fn(direction)
      end
    end

    telescope.setup{
      defaults = {
        mappings = {
          i = {
            ['<C-a>'] = run_find_files,
            ['<C-c>'] = actions.close,
            ['<C-g>'] = run_live_grep,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-s>'] = actions.select_horizontal,
            ['<C-n>'] = actions.select_horizontal,
            ['<C-d>'] = preview_scroll(3),
            ['<C-u>'] = preview_scroll(-3),
            ['<C-f>'] = preview_scroll(30),
            ['<C-b>'] = preview_scroll(-30),
          },
          n = {
            ['<C-a>'] = run_find_files,
            ['<C-c>'] = actions.close,
            ['<C-g>'] = run_live_grep,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-s>'] = actions.select_horizontal,
            ['<C-n>'] = actions.select_horizontal,
            ['<C-d>'] = preview_scroll(3),
            ['<C-u>'] = preview_scroll(-3),
          },
        },
        vimgrep_arguments = {
          'pt',
          '--nocolor',
          '--nogroup',
          '--column',
          '--smart-case',
          '--hidden',
        },
        winblend = 10,
        file_sorter = require'telescope.sorters'.get_fzy_sorter,
      },
      extensions = {
        frecency = {
          show_scores = true,
          show_unindexed = false,
          ignore_patterns = {'/.git/'},
          workspaces = {
            vimrc = vim.loop.os_homedir()..'/git/github.com/delphinus/dotfiles/.vim',
          },
        },
      },
    }
    -- TODO: how to use this?
    -- telescope.load_extension'packer'

    -- for telescope-frecency
    vim.api.nvim_exec([[
      hi link TelescopeBufferLoaded String
      hi link TelescopePathSeparator None
      hi link TelescopeFrecencyScores TelescopeResultsIdentifier
      hi link TelescopeQueryFilter Type
    ]], false)

    telescope.load_extension'frecency'
    telescope.load_extension'fzf_writer'
    telescope.load_extension'gh'
    telescope.load_extension'ghq'
    telescope.load_extension'memo'
    telescope.load_extension'node_modules'
    telescope.load_extension'z'

    -- file finders
    m.nnoremap('<Leader>ff', function()
      -- TODO: stopgap measure
      local cwd = vim.fn.getcwd()
      if cwd == vim.loop.os_homedir() then
        vim.api.nvim_echo({
          {'find_files on $HOME is danger. Launch ghq instead.', 'WarningMsg'},
        }, true, {})
        extensions.ghq.list{}
      elseif vim.fn.isdirectory(cwd..'/.git') then
        builtin.git_files{}
      else
        builtin.find_files{}
      end
    end)

    m.nnoremap('<Leader>fa', function()
      builtin.find_files{hidden = true}
    end)
    m.nnoremap('<Leader>fb', function() builtin.file_browser{cwd = '%:h'} end)
    m.nnoremap('<Leader>fg', function()
      builtin.grep_string{
        only_sort_text = true,
        search = vim.fn.input('Grep For > '),
      }
    end)
    m.nnoremap('<Leader>fG', builtin.grep_string)
    m.nnoremap('<Leader>fh', builtin.help_tags)
    m.nnoremap('<Leader>fH', function() builtin.help_tags{lang = 'en'} end)
    m.nnoremap('<Leader>fm', function() builtin.man_pages{sections = {'ALL'}} end)
    m.nnoremap('<Leader>fo', extensions.frecency.frecency)
    m.nnoremap('<Leader>fp', extensions.node_modules.list)
    m.nnoremap('<Leader>fq', extensions.ghq.list)
    m.nnoremap('<Leader>fz', extensions.z.list)
    m.nnoremap('<Leader>f:', builtin.command_history)

    -- for Memo
    m.nnoremap('<Leader>mm', extensions.memo.list)
    m.nnoremap('<Leader>mg', function()
      extensions.memo.grep_string{
        only_sort_text = true,
        search = vim.fn.input('Memo Grep For > '),
      }
    end)

    -- for LSP
    m.nnoremap('<Leader>sr', builtin.lsp_references)
    m.nnoremap('<Leader>sd', builtin.lsp_document_symbols)
    m.nnoremap('<Leader>sw', builtin.lsp_workspace_symbols)
    m.nnoremap('<Leader>sc', builtin.lsp_code_actions)

    -- for Git
    m.nnoremap('<Leader>gc', builtin.git_commits)
    m.nnoremap('<Leader>gb', builtin.git_bcommits)
    m.nnoremap('<Leader>gr', builtin.git_branches)
    m.nnoremap('<Leader>gs', builtin.git_status)

    -- for buffer
    m.nnoremap('#', builtin.current_buffer_fuzzy_find)
  end,
}
