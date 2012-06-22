" GNU screen ��ξ��
if &term =~ 'screen'
    " ��������������Ѥ���
    let &t_SI .= "\eP\e[3 q\e\\"
    let &t_EI .= "\eP\e[1 q\e\\"

    " Ž���դ���Ȥ���ưŪ�� paste �⡼�ɤ��Ѥ��
    let &t_ti .= "\eP\e[?2004h\e\\"
    let &t_te .= "\eP\e[?2004l\e\\"
else
    let &t_SI .= "\e[3 q"
    let &t_EI .= "\e[1 q"

    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
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
