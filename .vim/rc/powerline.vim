"-----------------------------------------------------------------------------
" vim-powerline
let g:Powerline_symbols = 'fancy'
let g:Powerline_theme = 'default'
let g:Powerline_colorscheme = 'solarizedDark'

if g:is_office_alt
	let g:Powerline_colorscheme = 'solarizedLight'
elseif g:is_office || g:is_win
	let g:Powerline_colorscheme = 'default'
else
	let g:Powerline_colorscheme = 'solarizedDark'
endif
