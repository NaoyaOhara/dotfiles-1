return {
  --{'wbthomason/packer.nvim', opt = true},
  { "delphinus/packer.nvim", branch = "feature/denops", opt = true },
  { "vim-denops/denops.vim", opt = true },

  -- Colorscheme {{{
  {
    --"arcticicestudio/nord-vim",
    "delphinus/nord-nvim",
    run = {
      function()
        require("nord").update {
          italic = true,
          uniform_status_lines = true,
          uniform_diff_background = true,
          cursor_line_number_background = true,
          language_specific_highlights = false,
        }
      end,
    },
    config = function()
      api.create_autocmd("ColorScheme", {
        group = api.create_augroup("nord_overrides", {}),
        pattern = "nord",
        callback = function()
          api.set_hl(0, "Comment", { fg = "#72809a", italic = true })
          api.set_hl(0, "Delimiter", { fg = "#81a1c1" })
          api.set_hl(0, "Constant", { fg = "#d8dee9", italic = true })
          -- TODO
          -- hi Folded guifg=#72809a gui=NONE
          api.set_hl(0, "Folded", { fg = "#72809a" })
          api.set_hl(0, "Identifier", { fg = "#8fbcbb" })
          api.set_hl(0, "Special", { fg = "#d08770" })
          api.set_hl(0, "Title", { fg = "#88c0d0", bold = true })
          api.set_hl(0, "PmenuSel", { blend = 0 })
          -- TODO
          -- hi VertSplit gui=NONE
          api.set_hl(0, "NormalFloat", { fg = "#d8dee9", bg = "#3b4252", blend = 10 })
          api.set_hl(0, "FloatBorder", { fg = "#8fbcbb", bg = "#3b4252", blend = 10 })
        end,
      })
    end,
  },

  {
    "lifepillar/vim-solarized8",
    opt = true,
  },
  -- }}}

  -- cmd {{{
  { "cocopon/colorswatch.vim", cmd = { "ColorSwatchGenerate" } },

  {
    "cocopon/inspecthi.vim",
    cmd = { "Inspecthi", "InspecthiShowInspector", "InspecthiHideInspector" },
  },

  {
    "dhruvasagar/vim-table-mode",
    cmd = { "TableModeToggle" },
    setup = function()
      vim.g.table_mode_corner = "|"
      vim.keymap.set("n", "`tm", [[<Cmd>TableModeToggle<CR>]])
    end,
  },

  { "fuenor/JpFormat.vim", cmd = { "JpFormatAll", "JpJoinAll" } },

  {
    "rbgrouleff/bclose.vim",
    -- TODO: cmd does not work?
    keys = {
      { "n", "<Leader>tT" },
      { "n", "<Leader>tt" },
    },
    cmd = {
      "Tig",
      "TigOpenCurrentFile",
      "TigOpenProjectRootDir",
      "TigGrep",
      "TigBlame",
      "TigGrepResume",
      "TigStatus",
      "TigOpenFileWithCommit",
    },
  },

  {
    "iberianpig/tig-explorer.vim",
    after = { "bclose.vim" },
    -- TODO: cmd does not work?
    keys = {
      { "n", "<Leader>tT" },
      { "n", "<Leader>tt" },
    },
    cmd = {
      "Tig",
      "TigOpenCurrentFile",
      "TigOpenProjectRootDir",
      "TigGrep",
      "TigBlame",
      "TigGrepResume",
      "TigStatus",
      "TigOpenFileWithCommit",
    },
    config = function()
      vim.keymap.set("n", "<Leader>tT", [[<Cmd>TigOpenCurrentFile<CR>]])
      vim.keymap.set("n", "<Leader>tt", [[<Cmd>TigOpenProjectRootDir<CR>]])
      vim.keymap.set("n", "<Leader>tg", [[<Cmd>TigGrep<CR>]])
      vim.keymap.set("n", "<Leader>tr", [[<Cmd>TigGrepResume<CR>]])
      vim.keymap.set("v", "<Leader>tG", [[y<Cmd>TigGrep<Space><C-R>"<CR>]])
      vim.keymap.set("n", "<Leader>tc", [[<Cmd><C-u>:TigGrep<Space><C-R><C-W><CR>]])
      vim.keymap.set("n", "<Leader>tb", [[<Cmd>TigBlame<CR>]])
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    setup = function()
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_echo_preview_url = 1
      vim.g.mkdp_open_to_the_world = 1
    end,
    run = "cd app && yarn",
  },

  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle" },
    setup = function()
      vim.g.undotree_HelpLine = 0
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_ShortIndicators = 1
      vim.g.undotree_TreeNodeShape = "●"
      vim.g.undotree_WindowLayout = 2
      vim.keymap.set("n", "<A-u>", [[<Cmd>UndotreeToggle<CR>]])
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    cmd = {
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
      "ColorizerToggle",
    },
    setup = function()
      vim.keymap.set("n", "<A-C>", [[<Cmd>ColorizerToggle<CR>]], { silent = true })
      vim.keymap.set("n", "<A-S-Ç>", [[<Cmd>ColorizerToggle<CR>]], { silent = true })
    end,
  },

  {
    "npxbr/glow.nvim",
    cmd = { "Glow", "GlowInstall" },
    setup = function()
      vim.g.glow_use_pager = true
    end,
  },

  { "powerman/vim-plugin-AnsiEsc", cmd = { "AnsiEsc" } },

  {
    "pwntester/octo.nvim",
    cmd = { "Octo" },
    key = {
      { "n", "<A-O>" },
    },
    setup = function()
      vim.keymap.set("n", "<A-O>", "Octo ")
    end,
    config = function()
      require("octo").setup { github_hostname = vim.g.gh_e_host }
    end,
  },

  {
    "rhysd/ghpr-blame.vim",
    cmd = { "GHPRBlame" },
    config = function()
      local settings = loop.os_homedir() .. "/.ghpr-blame.vim"
      if fn.filereadable(settings) == 1 then
        vim.cmd.source(settings)
        -- TODO: mappings for VV
        vim.g.ghpr_show_pr_mapping = "<A-g>"
        vim.g.ghpr_show_pr_in_message = 1
      else
        vim.notify("file not found: " .. settings, vim.log.levels.WARN)
      end
    end,
  },

  {
    "rhysd/git-messenger.vim",
    cmd = { "GitMessenger" },
    setup = function()
      vim.g.git_messenger_no_default_mappings = true
      vim.keymap.set("n", "<A-b>", [[<Cmd>GitMessenger<CR>]])
      vim.keymap.set("n", "<A-∫>", [[<Cmd>GitMessenger<CR>]])
    end,
  },

  {
    "tyru/capture.vim",
    requires = {
      { "thinca/vim-prettyprint", cmd = { "PP", "PrettyPrint" } },
    },
    cmd = { "Capture" },
  },

  {
    "tyru/open-browser.vim",
    cmd = { "OpenBrowser", "OpenBrowserSearch" },
    keys = { "<Plug>(openbrowser-smart-search)" },
    fn = { "openbrowser#open" },
    setup = function()
      vim.keymap.set({ "n", "v" }, "g<CR>", [[<Plug>(openbrowser-smart-search)]])
    end,
  },

  { "tweekmonster/startuptime.vim", cmd = { "StartupTime" } },

  {
    "vifm/vifm.vim",
    cmd = { "EditVifm", "VsplitVifm", "SplitVifm", "DiffVifm", "TabVifm" },
    ft = { "vifm" },
  },

  {
    "vim-scripts/autodate.vim",
    cmd = { "Autodate", "AutodateOFF", "AutodateON" },
    setup = function()
      vim.g.autodate_format = "%FT%T%z"
      api.create_autocmd(
        { "BufUnload", "FileWritePre", "BufWritePre" },
        { group = api.create_augroup("Autodate", {}), command = "Autodate" }
      )
    end,
  },
  -- }}}

  -- event {{{
  {
    "b0o/incline.nvim",
    event = {
      "WinNew",
      "WinClosed",
      "WinEnter",
      "WinLeave",
      "WinScrolled", -- WinScrolled is used to detect window resizes
      "TabEnter",
      "TabNewEntered",
      "BufWinEnter",
      "BufWinLeave",
    },
    config = function()
      require("incline").setup {}
    end,
  },

  {
    "delphinus/auto-cursorline.nvim",
    event = { "BufRead", "CursorMoved", "CursorMovedI", "WinEnter", "WinLeave" },
    config = function()
      require("auto-cursorline").setup {}
    end,
  },

  {
    "delphinus/dwm.nvim",
    event = { "VimEnter" },
    cond = function()
      -- Do not load when it is loading committia.vim
      local file = fn.expand "%"
      local not_to_load = { "COMMIT_EDITMSG", "MERGE_MSG" }
      for _, name in ipairs(not_to_load) do
        if file:match(name) then
          return false
        end
      end
      return true
    end,
    config = function()
      local dwm = require "dwm"
      dwm.setup {
        key_maps = false,
        master_pane_count = 1,
        master_pane_width = "60%",
      }
      vim.keymap.set("n", "<C-j>", "<C-w>w")
      vim.keymap.set("n", "<C-k>", "<C-w>W")
      vim.keymap.set("n", "<A-CR>", dwm.focus)
      vim.keymap.set("n", "<C-@>", dwm.focus)
      vim.keymap.set("n", "<C-Space>", dwm.focus)
      vim.keymap.set("n", "<C-l>", dwm.grow)
      vim.keymap.set("n", "<C-h>", dwm.shrink)
      vim.keymap.set("n", "<C-n>", dwm.new)
      vim.keymap.set("n", "<C-q>", dwm.rotateLeft)
      vim.keymap.set("n", "<C-s>", dwm.rotate)
      vim.keymap.set("n", "<C-c>", function()
        -- TODO: copied logic from require'scrollbar'.clear
        local state = vim.b.scrollbar_state
        if state and state.winnr then
          local ok = pcall(api.win_close, state.winnr, true)
          if not ok then
            api.echo({
              { "cannot found scrollbar win: " .. state.winnr, "WarningMsg" },
            }, true, {})
          end
          vim.b.scrollbar_state = { size = state.size, bufnr = state.bufnr }
        end
        dwm.close()
      end)

      api.create_autocmd("BufRead", {
        group = api.create_augroup("dwm_preview", {}),
        callback = function()
          -- TODO: vim.opt has no 'previewwindow'?
          if vim.wo.previewwindow then
            vim.b.dwm_disabled = 1
          end
        end,
      })
    end,
  },

  {
    "delphinus/emcl.nvim",
    event = { "CmdlineEnter" },
    config = function()
      require("emcl").setup {}
    end,
  },

  {
    "haringsrob/nvim_context_vt",
    event = { "BufNewFile", "BufRead", "FocusLost", "CursorHold" },
    wants = { "nvim-treesitter" },
    config = function()
      api.set_hl(0, "ContextVt", { fg = "#365f86" })
      require("nvim_context_vt").setup { highlight = "ContextVt" }
    end,
  },

  { "itchyny/vim-cursorword", event = { "FocusLost", "CursorHold" } },

  {
    "itchyny/vim-parenmatch",
    event = { "FocusLost", "CursorHold" },
    setup = [[vim.g.loaded_matchparen = 1]],
    config = [[fn['parenmatch#highlight']()]],
  },

  {
    "lewis6991/foldsigns.nvim",
    event = { "FocusLost", "CursorHold" },
    config = function()
      require("foldsigns").setup {}
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "FocusLost", "CursorHold" },
    config = function()
      api.set_hl(0, "GitSignsAdd", { fg = "#a3be8c" })
      api.set_hl(0, "GitSignsChange", { fg = "#ebcb8b" })
      api.set_hl(0, "GitSignsDelete", { fg = "#bf616a" })
      api.set_hl(0, "GitSignsCurrentLineBlame", { fg = "#616e88" })
      api.set_hl(0, "GitSignsAddInline", { bg = "#183203" })
      api.set_hl(0, "GitSignsChangeInline", { bg = "#432d00" })
      api.set_hl(0, "GitSignsDeleteInline", { bg = "#52050c" })
      local gitsigns = require "gitsigns"
      local function gs(method)
        return function()
          gitsigns[method]()
        end
      end

      gitsigns.setup {
        signs = {
          add = { hl = "GitSignsAdd" },
          change = { hl = "GitSignsChange" },
          delete = { hl = "GitSignsDelete", text = "✗" },
          topdelete = { hl = "GitSignsDelete", text = "↑" },
          changedelete = { hl = "GitSignsChange", text = "•" },
        },
        numhl = true,
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 10,
        },
        word_diff = true,
        on_attach = function(bufnr)
          vim.keymap.set("n", "]c", gs "next_hunk", { buffer = bufnr })
          vim.keymap.set("n", "[c", gs "prev_hunk", { buffer = bufnr })
        end,
      }
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "FocusLost", "CursorHold" },
    setup = function()
      -- │┃┊┋┆┇║⡇⢸
      vim.g.indent_blankline_char = "│"
      vim.g.indent_blankline_space_char = "∙"
      vim.g.indent_blankline_show_current_context = true
      vim.g.indent_blankline_use_treesitter = true
      vim.g.indent_blankline_show_end_of_line = true
      vim.g.indent_blankline_show_foldtext = false
      vim.g.indent_blankline_filetype_exclude = { "help", "packer", "FTerm" }
    end,
  },

  {
    "lukas-reineke/virt-column.nvim",
    event = {
      "FileChangedShellPost,",
      "TextChanged,",
      "TextChangedI,",
      "CompleteChanged,",
      "BufWinEnter,",
      "WinScrolled",
    },
    config = function()
      api.set_hl(0, "ColorColumn", { bg = "NONE" })
      api.set_hl(0, "VirtColumn", { fg = "#616e88" })
      require("virt-column").setup { char = "⡂" }
    end,
  },
  -- }}}

  -- ft {{{
  { "Glench/Vim-Jinja2-Syntax", ft = { "jinja" } },
  { "Vimjas/vim-python-pep8-indent", ft = { "python" } },
  { "aklt/plantuml-syntax", ft = { "plantuml" } },
  { "aliou/bats.vim", ft = { "bats" } },
  -- {'dag/vim-fish' ft = {'fish'}},
  { "blankname/vim-fish", ft = { "fish" } },
  { "c9s/perlomni.vim", ft = { "perl" } },
  { "cespare/vim-toml", ft = { "toml" } },
  { "dNitro/vim-pug-complete", ft = { "pug" } },
  { "delphinus/vim-data-section-simple", ft = { "perl" } },
  { "delphinus/vim-firestore", ft = { "firestore" } },
  { "delphinus/vim-toml-dein", ft = { "toml" } },
  { "derekwyatt/vim-scala", ft = { "scala" } },
  { "digitaltoad/vim-pug", ft = { "pug" } },
  { "dsawardekar/wordpress.vim", ft = { "php" } },

  {
    "gisphm/vim-gitignore",
    ft = { "gitignore" },
    setup = function()
      api.create_autocmd({ "BufNewFile", "BufRead" }, {
        group = api.create_augroup("detect_other_ignores", {}),
        pattern = ".gcloudignore",
        command = [[setf gitignore]],
      })
    end,
  },

  { "google/vim-jsonnet", ft = { "jsonnet" } },
  { "hail2u/vim-css3-syntax", ft = { "css" } },
  { "hashivim/vim-terraform", ft = { "terraform" } },
  { "isobit/vim-caddyfile", ft = { "caddyfile" } },
  { "junegunn/vader.vim", ft = { "vader" } },

  {
    "kchmck/vim-coffee-script",
    ft = { "coffee" },
    setup = function()
      api.create_autocmd({ "BufNewFile", "BufRead" }, {
        group = api.create_augroup("detect_cson", {}),
        pattern = "*.cson",
        command = [[setf coffee]],
      })
    end,
  },

  { "keith/swift.vim", ft = { "swift" } },
  { "kevinhwang91/nvim-bqf", ft = { "qf" } },
  { "leafo/moonscript-vim", ft = { "moonscript" } },
  { "moznion/vim-cpanfile", ft = { "cpanfile" } },

  {
    "motemen/vim-syntax-hatena",
    ft = { "hatena" },
    config = [[vim.g.hatena_syntax_html = true]],
  },

  { "motemen/xslate-vim", ft = { "xslate" } },
  { "msanders/cocoa.vim", ft = { "objc" } },

  {
    "mustache/vim-mustache-handlebars",
    ft = { "mustache", "handlebars", "html.mustache", "html.handlebars" },
  },

  { "neoclide/jsonc.vim", ft = { "jsonc" } },
  { "nikvdp/ejs-syntax", ft = { "ejs" } },
  { "pboettch/vim-cmake-syntax", ft = { "cmake" } },

  {
    "pearofducks/ansible-vim",
    ft = { "ansible", "yaml.ansible" },
    config = function()
      vim.g.ansible_name_highlight = "b"
      vim.g.ansible_extra_keywords_highlight = 1
    end,
  },

  { "posva/vim-vue", ft = { "vue" } },
  { "tmux-plugins/vim-tmux", ft = { "tmux" } },

  {
    "rhysd/vim-textobj-ruby",
    requires = { { "kana/vim-textobj-user" } },
    ft = { "ruby" },
  },

  {
    "rhysd/committia.vim",
    ft = { "gitcommit" },
    setup = function()
      vim.g.committia_hooks = {
        edit_open = function(info)
          if info.vcs == "git" and fn.getline(1) == "" then
            vim.cmd.startinsert()
          end
          vim.keymap.set("i", "<A-d>", [[<Plug>(committia-scroll-diff-down-half)]], { buffer = true })
          vim.keymap.set("i", "<A-∂>", [[<Plug>(committia-scroll-diff-down-half)]], { buffer = true })
          vim.keymap.set("i", "<A-u>", [[<Plug>(committia-scroll-diff-up-half)]], { buffer = true })
        end,
      }
    end,
  },

  { "rust-lang/rust.vim", ft = { "rust" } },

  { "teal-language/vim-teal", ft = { "teal" } },

  {
    "tpope/vim-endwise",
    ft = {
      "lua",
      "elixir",
      "ruby",
      "crystal",
      "sh",
      "zsh",
      "vb",
      "vbnet",
      "aspvbs",
      "vim",
      "c",
      "cpp",
      "xdefaults",
      "objc",
      "matlab",
    },
  },

  { "uarun/vim-protobuf", ft = { "proto" } },

  {
    "delphinus/vim-rails",
    branch = "feature/recognize-ridgepole",
    ft = { "ruby" },
  },

  {
    "vim-perl/vim-perl",
    ft = { "perl", "perl6" },
    setup = function()
      vim.g.perl_include_pod = 1
      vim.g.perl_string_as_statement = 1
      vim.g.perl_sync_dist = 1000
      vim.g.perl_fold = 1
      vim.g.perl_nofold_packages = 1
      vim.g.perl_fold_anonymous_subs = 1
      vim.g.perl_sub_signatures = 1
    end,
  },

  { "vim-scripts/a.vim", ft = { "c", "cpp" } },
  { "vim-scripts/applescript.vim", ft = { "applescript" } },
  { "vim-scripts/fontforge_script.vim", ft = { "fontforge_script" } },
  { "vim-scripts/nginx.vim", ft = { "nginx" } },
  { "vim-skk/skkdict.vim", ft = { "skkdict" } },
  -- }}}

  -- keys {{{
  {
    "arecarn/vim-fold-cycle",
    keys = { { "n", "<Plug>(fold-cycle-" } },
    setup = function()
      vim.g.fold_cycle_default_mapping = 0
      vim.keymap.set("n", "<A-l>", [[<Plug>(fold-cycle-open)]])
      vim.keymap.set("n", "<A-¬>", [[<Plug>(fold-cycle-open)]])
      vim.keymap.set("n", "<A-h>", [[<Plug>(fold-cycle-open)]])
      vim.keymap.set("n", "<A-˙>", [[<Plug>(fold-cycle-open)]])
    end,
  },

  {
    "bfredl/nvim-miniyank",
    keys = { { "n", "<Plug>(miniyank-" } },
    setup = function()
      vim.g.miniyank_maxitems = 100
      vim.keymap.set("n", "p", [[<Plug>(miniyank-autoput)]])
      vim.keymap.set("n", "P", [[<Plug>(miniyank-autoPut)]])
      vim.keymap.set("n", "<A-p>", [[<Plug>(miniyank-cycle)]])
      vim.keymap.set("n", "<A-π>", [[<Plug>(miniyank-cycle)]])
      vim.keymap.set("n", "<A-P>", [[<Plug>(miniyank-cycleback)]])
      vim.keymap.set("n", "<A-S-∏>", [[<Plug>(miniyank-cycleback)]])
    end,
  },

  {
    "chikatoike/concealedyank.vim",
    keys = { { "x", "<Plug>(operator-concealedyank)" } },
    setup = function()
      vim.keymap.set("x", "Y", [[<Plug>(operator-concealedyank)]])
    end,
  },

  -- Add a space in the closing paren to enable to use folding
  { "delphinus/vim-tmux-copy", keys = { { "n", "<A-[>" }, { "n", "<A-“>" } } },

  {
    "inkarkat/vim-LineJuggler",
    requires = {
      { "inkarkat/vim-ingo-library" },
      { "vim-repeat" },
      { "vim-scripts/visualrepeat" },
    },
    keys = {
      "[d",
      "]d",
      "[E",
      "]E",
      "[e",
      "]e",
      "[f",
      "]f",
      "[<Space>",
      "]<Space>",
    },
  },

  {
    "junegunn/vim-easy-align",
    keys = { { "v", "<Plug>(EasyAlign)" } },
    setup = function()
      vim.keymap.set("v", "<CR>", "<Plug>(EasyAlign)")

      vim.g.easy_align_delimiters = {
        [">"] = { pattern = [[>>\|=>\|>]] },
        ["/"] = { pattern = [[//\+\|/\*\|\*/]], ignore_groups = { "String" } },
        ["#"] = {
          pattern = [[#\+]],
          ignore_groups = { "String" },
          delimiter_align = "l",
        },
        ["]"] = {
          pattern = [=[[[\]]]=],
          left_margin = 0,
          right_margin = 0,
          stick_to_left = 0,
        },
        [")"] = {
          pattern = "[()]",
          left_margin = 0,
          right_margin = 0,
          stick_to_left = 0,
        },
        ["d"] = {
          pattern = [[ \(\S\+\s*[;=]\)\@=]],
          left_margin = 0,
          right_margin = 0,
        },
      }
    end,
  },

  {
    "kylechui/nvim-surround",
    keys = {
      { "n", "ys" },
      { "n", "ds" },
      { "n", "cs" },
      { "v", "S" },
    },
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  {
    "phaazon/hop.nvim",
    --"delphinus/hop.nvim",
    --branch = "feature/migemo",
    keys = {
      { "n", [['j]] },
      { "v", [['j]] },
      { "n", [['k]] },
      { "v", [['k]] },
    },
    config = function()
      local hop = require "hop"
      hop.setup {
        keys = "hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB",
        extend_visual = true,
      }
      local direction = require("hop.hint").HintDirection
      vim.keymap.set({ "n", "v" }, [['j]], function()
        if fn.getcmdwintype() == "" then
          hop.hint_lines { direction = direction.AFTER_CURSOR }
        end
      end)
      vim.keymap.set({ "n", "v" }, [['k]], function()
        if fn.getcmdwintype() == "" then
          hop.hint_lines { direction = direction.BEFORE_CURSOR }
        end
      end)
      if vim.opt.background:get() == "dark" then
        api.set_hl(0, "HopNextKey", { fg = "#d08770", bold = true })
        api.set_hl(0, "HopNextKey1", { fg = "#88c0d0", bold = true })
        api.set_hl(0, "HopNextKey2", { fg = "#d8dee9" })
        api.set_hl(0, "HopUnmatched", { fg = "#4c566a" })
      end
    end,
  },

  {
    "ruifm/gitlinker.nvim",
    keys = {
      { "n", "gc" },
      { "v", "gc" },
    },
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require "gitlinker.actions"
      require("gitlinker").setup {
        opts = {
          add_current_line_on_normal_mode = false,
          action_callback = function(url)
            actions.copy_to_clipboard(url)
            actions.open_in_browser(url)
          end,
        },
        callbacks = {
          [vim.g.gh_e_host] = require("gitlinker.hosts").get_github_type_url,
        },
        mappings = "gc",
      }
    end,
  },

  {
    "t9md/vim-quickhl",
    keys = {
      { "n", "<Plug>(quickhl-" },
      { "x", "<Plug>(quickhl-" },
    },
    setup = function()
      vim.keymap.set({ "n", "x" }, "<Space>m", [[<Plug>(quickhl-manual-this)]])
      vim.keymap.set({ "n", "x" }, "<Space>t", [[<Plug>(quickhl-manual-toggle)]])
      vim.keymap.set({ "n", "x" }, "<Space>M", [[<Plug>(quickhl-manual-reset)]])
    end,
  },

  {
    "thinca/vim-visualstar",
    keys = { { "x", "<Plug>(visualstar-" } },
    setup = function()
      vim.g.visualstar_no_default_key_mappings = 1
      vim.keymap.set("x", "*", [[<Plug>(visualstar-*)]])
    end,
  },

  {
    "tyru/columnskip.vim",
    keys = {
      { "n", "<Plug>(columnskip:" },
      { "x", "<Plug>(columnskip:" },
      { "o", "<Plug>(columnskip:" },
    },
    setup = function()
      vim.keymap.set({ "n", "x", "o" }, "[j", [[<Plug>(columnskip:nonblank:next)]])
      vim.keymap.set({ "n", "x", "o" }, "[k", [[<Plug>(columnskip:nonblank:prev)]])
      vim.keymap.set({ "n", "x", "o" }, "]j", [[<Plug>(columnskip:first-nonblank:next)]])
      vim.keymap.set({ "n", "x", "o" }, "]k", [[<Plug>(columnskip:first-nonblank:prev)]])
    end,
  },
  -- }}}

  -- func {{{
  { "sainnhe/artify.vim", fn = { "artify#convert" } },
  { "vim-jp/vital.vim", fn = { "vital#vital#new" } },

  {
    "hrsh7th/vim-searchx",
    fn = { "searchx#*" },
    setup = function()
      local searchx = function(name)
        return function(opt)
          return function()
            local f = fn["searchx#" .. name]
            return opt and f(opt) or f()
          end
        end
      end

      -- Overwrite / and ?.
      vim.keymap.set({ "n", "x" }, "?", searchx "start" { dir = 0 })
      vim.keymap.set({ "n", "x" }, "/", searchx "start" { dir = 1 })
      vim.keymap.set("c", "<A-;>", searchx "select"())

      -- Move to next/prev match.
      vim.keymap.set({ "n", "x" }, "N", searchx "prev"())
      vim.keymap.set({ "n", "x" }, "n", searchx "next"())
      vim.keymap.set({ "c", "n", "x" }, "<A-z>", searchx "prev"())
      vim.keymap.set({ "c", "n", "x" }, "<A-x>", searchx "next"())

      -- Clear highlights
      vim.keymap.set("n", "<Esc><Esc>", searchx "clear"())
    end,
    config = function()
      vim.g.searchx = {
        -- Auto jump if the recent input matches to any marker.
        auto_accept = true,
        -- The scrolloff value for moving to next/prev.
        scrolloff = vim.opt.scrolloff:get(),
        -- To enable scrolling animation.
        scrolltime = 0,
        -- Marker characters.
        markers = vim.split("HJKLASDFGYUIOPQWERTNMZXCVB", ""),
        -- To enable auto nohlsearch after cursor is moved
        nohlsearch = { jump = true },

        convert = function(input)
          -- If the input does not contain iskeyword characters, it deals with
          -- the input as "very magic".
          if not vim.regex([[\k]]):match_str(input) then
            return [[\V]] .. input
          elseif not input:match "^;" then
            -- If the input contains spaces, it tries fuzzy matching.
            return input:sub(1, 1) .. fn.substitute(input:sub(2), [[\\\@<! ]], [[.\\{-}]], "g")
          end
          -- If the input has `;` at the beginning, it converts the input with
          -- cmigemo.
          local dict = vim.env.HOMEBREW_PREFIX .. "/opt/cmigemo/share/migemo/utf-8/migemo-dict"
          local re
          require("plenary.job")
            :new({
              command = "cmigemo",
              args = { "-v", "-d", dict, "-w", input:sub(2) },
              on_exit = function(j, return_val)
                local out = j:result()
                if return_val == 0 and #out > 0 then
                  re = out[1]
                else
                  vim.notify("cmigemo execution failed", vim.log.levels.WARN)
                  re = input:sub(2)
                end
              end,
            })
            :sync()
          return re
        end,
      }

      api.set_hl(0, "SearchxMarker", { link = "DiffChange" })
      api.set_hl(0, "SearchxMarkerCurrent", { link = "WarningMsg" })
    end,
  },
  -- }}}

  -- module {{{
  {
    "numToStr/FTerm.nvim",
    module = { "FTerm" },
    setup = function()
      local loaded
      local function toggle_fterm()
        if not loaded then
          require("FTerm").setup {
            cmd = vim.opt.shell:get(),
            border = {
              --[[
              {'╭', 'WinBorderTop'},
              {'─', 'WinBorderTop'},
              {' ', 'WinBorderTransparent'},
              {' ', 'WinBorderTransparent'},
              {' ', 'WinBorderTransparent'},
              {' ', 'WinBorderTransparent'},
              {' ', 'WinBorderTransparent'},
              {'│', 'WinBorderLeft'},
              ]]
              --[[
              {'█', 'WinBorderLight'},
              {'▀', 'WinBorderLight'},
              {'▀', 'WinBorderLight'},
              {'█', 'WinBorderDark'},
              {'▄', 'WinBorderLight'},
              {'▄', 'WinBorderLight'},
              {'█', 'WinBorderLight'},
              {'█', 'WinBorderLight'},
              ]]
              --[[
              {'▟', 'WinBorderLight'},
              {'▀', 'WinBorderLight'},
              {'▀', 'WinBorderLight'},
              {'▙', 'WinBorderDark'},
              {'█', 'WinBorderDark'},
              {'▛', 'WinBorderDark'},
              {'▄', 'WinBorderDark'},
              {'▜', 'WinBorderLight'},
              {'█', 'WinBorderLight'},
              ]]
              --[[
              {'╭', 'WinBorderTop'},
              {'─', 'WinBorderTop'},
              {'╮', 'WinBorderTop'},
              {'│', 'WinBorderRight'},
              {'╯', 'WinBorderBottom'},
              {'─', 'WinBorderBottom'},
              {'╰', 'WinBorderLeft'},
              {'│', 'WinBorderLeft'},
              {'⣠', 'WinBorderTop'},
              {'⣤', 'WinBorderTop'},
              {'⣄', 'WinBorderTop'},
              {'⣿', 'WinBorderRight'},
              {'⠋', 'WinBorderBottom'},
              {'⠛', 'WinBorderBottom'},
              {'⠙', 'WinBorderLeft'},
              {'⣿', 'WinBorderLeft'},
              ]]
              { "⣀", "WinBorderTop" },
              { "⣀", "WinBorderTop" },
              { "⣀", "WinBorderTop" },
              { "⢸", "WinBorderRight" },
              { "⠉", "WinBorderBottom" },
              { "⠉", "WinBorderBottom" },
              { "⠉", "WinBorderBottom" },
              { "⡇", "WinBorderLeft" },
            },
          }
          loaded = true
        end
        require("FTerm").toggle()
      end

      vim.keymap.set({ "n", "t" }, "<A-c>", toggle_fterm)
      vim.keymap.set({ "n", "t" }, "<A-ç>", toggle_fterm)
    end,
    config = function()
      api.set_hl(0, "WinBorderTop", { fg = "#ebf5f5", blend = 30 })
      api.set_hl(0, "WinBorderLeft", { fg = "#c2dddc", blend = 30 })
      api.set_hl(0, "WinBorderRight", { fg = "#8fbcbb", blend = 30 })
      api.set_hl(0, "WinBorderBottom", { fg = "#5d9794", blend = 30 })
      api.set_hl(0, "WinBorderLight", { fg = "#c2dddc", bg = "#5d9794", blend = 30 })
      api.set_hl(0, "WinBorderDark", { fg = "#5d9794", bg = "#c2dddc", blend = 30 })
      api.set_hl(0, "WinBorderTransparent", { bg = "#111a2c" })
    end,
  },
  -- }}}
}

-- vim:se fdm=marker:
