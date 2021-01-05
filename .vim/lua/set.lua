-- Encodings {{{
vim.o.fileencoding = 'utf-8'
vim.bo.fileencoding = 'utf-8'
if vim.fn.has'gui_macvim' == 0 then
  vim.o.fileencodings = 'ucs-bom,utf-8,eucjp,cp932,ucs-2le,latin1,iso-2022-jp'
end
-- }}}

--Tabs {{{
vim.o.expandtab = true
vim.bo.expandtab = true
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
vim.o.softtabstop = 2
vim.bo.softtabstop = 2
vim.o.tabstop = 2
vim.bo.tabstop = 2
-- }}}

-- Undo {{{
vim.o.undofile = true
vim.bo.undofile = true
-- }}}

-- Searching {{{
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'split'
-- }}}

-- Display {{{
vim.o.cmdheight = 2
vim.o.colorcolumn = '80,140'
vim.wo.colorcolumn = '80,140'
vim.o.list = true
vim.wo.list = true
vim.o.listchars = 'tab:▓░,trail:↔,eol:⏎,extends:→,precedes:←,nbsp:␣'
vim.o.ruler = false
vim.o.showmode = false
vim.o.number = true
vim.wo.number = true
vim.o.numberwidth = 3
vim.wo.numberwidth = 3
vim.o.relativenumber = true
vim.wo.relativenumber = true
vim.o.showmatch = true
-- }}}

-- Indents and arranging formats {{{
vim.o.breakindent = true
vim.wo.breakindent = true
vim.o.formatoptions = add_option_string(vim.o.formatoptions,'nmMj')
vim.bo.formatoptions = vim.o.formatoptions
vim.o.formatlistpat = [[^\s*\%(\d\+\|[-a-z]\)\%(\ -\|[]:.)}\t]\)\?\s\+]]
vim.bo.formatlistpat = vim.o.formatlistpat
vim.o.fixendofline = false
vim.bo.fixendofline = false
vim.o.showbreak = [[→  ]]
vim.o.smartindent = true
vim.bo.smartindent = true
-- }}}

-- Mouse
vim.o.mouse = 'a'

-- ColorScheme {{{
vim.o.termguicolors = true
vim.cmd'syntax enable'

function _G.toggle_colorscheme()
  local scheme
  if vim.o.background == 'light' then
    vim.o.background = 'dark'
    scheme = 'nord'
  else
    vim.o.background = 'light'
    scheme = 'solarized8'
  end
  vim.cmd('colorscheme '..scheme)
end

vim.cmd'command! ToggleColorscheme lua toggle_colorscheme()'

-- Use Solarized Light when iTerm2 reports 11;15 for $COLORFGBG
local is_light = vim.env.COLORFGBG == '11;15'
if is_light then
  vim.g.background = 'light'
end
local scheme
if is_light or vim.env.SOLARIZED then
  scheme = 'solarized8'
else
  scheme = 'nord'
end
nvim_create_augroups{
  set_colorscheme = {
    {'VimEnter', '*', 'colorscheme '..scheme},
  },
}
-- }}}

-- Title {{{
if vim.env.TMUX then
  vim.o.t_ts = [[k]]
  vim.o.t_fs = [[\]]
end
vim.o.title = true
-- }}}

-- Others {{{
vim.o.diffopt = vim.o.diffopt..',vertical,iwhite,algorithm:patience'
vim.o.fileformat = 'unix'
vim.bo.fileformat = 'unix'
vim.o.fileformats = 'unix,dos'
vim.o.grepprg = 'pt --nogroup --nocolor'
vim.o.guicursor = 'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50'..
      ',a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor'..
      ',sm:block-blinkwait175-blinkoff150-blinkon175'
vim.o.helplang = 'ja'
vim.o.lazyredraw = true
vim.bo.matchpairs = vim.bo.matchpairs..',（:）,「:」,【:】,［:］,｛:｝,＜:＞'
vim.o.scrolloff = 3
vim.o.sidescrolloff = 5
vim.bo.synmaxcol = 0
vim.o.virtualedit = 'block'
vim.o.wildmode = 'full'
vim.o.dictionary = '/usr/share/dict/words'
-- }}}

-- OS specific {{{
if vim.fn.has'osx' then
  -- Use Japanese for menus on macOS.
  -- This is needed to be set before showing menus.
  vim.o.langmenu = 'ja_ja.utf-8.macvim'

  -- Set iskeyword to manage CP932 texts on macOS
  vim.bo.iskeyword = '@,48-57,_,128-167,224-235'

  -- For printing
  vim.o.printmbfont = 'r:HiraMinProN-W3,b:HiraMinProN-W6'
  vim.o.printencoding = 'utf-8'
  vim.o.printmbcharset = 'UniJIS'
end

-- Set guioptions in case menu.vim does not exist.
if vim.fn.has'gui_running'
  and vim.fn.filereadable(vim.env.VIMRUNTIME..'/menu.vim') == 0 then
  vim.o.guioptions = add_option_string(vim.o.guioptions, 'M')
end

-- Exclude some $TERM not to communicate with X servers.
if vim.fn.has'gui_running' == 0 and vim.fn.has'xterm_clipboard' == 1 then
  vim.o.clipboard = [[exclude:cons\|linux\|cygwin\|rxvt\|screen]]
end

-- Set $VIM into $PATH to search vim.exe itself.
if vim.fn.has'win32' then
  local re = vim.regex([[\(^\|;\)]]..vim.fn.escape(vim.env.VIM, [[\]])..[[\(;\|$\)]])
  if re:match_str(vim.env.PATH) then
    vim.env.PATH = vim.env.VIM..';'..vim.env.PATH
  end
end
-- }}}

-- vim:se fdm=marker:
