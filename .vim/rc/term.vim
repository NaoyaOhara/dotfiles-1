" �б������ߥʥ�ʳ��ʤ鵢��
if &term !~ "screen" && &term !~ "xterm"
    finish
endif

" GNU screen ��ξ��
if &term =~ "screen"
    " iTerm2 �λ��Τߥ�������������Ѥ���
    if exists('$TMUX') && is_remora
        let &t_SI = "\ePtmux;\e\e]50;CursorShape=1\x7\e\\"
        let &t_EI = "\ePtmux;\e\e]50;CursorShape=0\x7\e\\"
    elseif is_remora
        let &t_SI = "\eP\e]50;CursorShape=1\x7\e\\"
        let &t_EI = "\eP\e]50;CursorShape=0\x7\e\\"
    endif

    " Ž���դ���Ȥ���ưŪ�� paste �⡼�ɤ��Ѥ��
    let &t_ti .= "\eP\e[?2004h\e\\"
    let &t_te .= "\eP\e[?2004l\e\\"

    map <expr> \e[200~ XTermPasteBegin("i")
    imap <expr> \e[200~ XTermPasteBegin("")
    cmap \e[200~ <nop>
    cmap \e[201~ <nop>

" xterm �ξ��
elseif &term =~ "xterm"
    " iTerm2 �λ��Τߥ�������������Ѥ���
    if is_remora
        let &t_SI = "\e]50;CursorShape=1\x7"
        let &t_EI = "\e]50;CursorShape=0\x7"
    endif

    " Ž���դ���Ȥ���ưŪ�� paste �⡼�ɤ��Ѥ��
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    map <expr> \e[200~ XTermPasteBegin("i")
    imap <expr> \e[200~ XTermPasteBegin("")
    cmap \e[200~ <nop>
    cmap \e[201~ <nop>
endif

let &pastetoggle = "\e[201~"

function XTermPasteBegin(ret)
    set paste
    return a:ret
endfunction

noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
cnoremap <special> <Esc>[200~ <nop>
cnoremap <special> <Esc>[201~ <nop>
