"
" This snippet is licensed under NYSL.
" See http://www.kmonos.net/nysl/NYSL.TXT
"
if has('gui_running')
    finish
endif

" �ʲ��ξ����������ʤ����vim���Τ�background���񤭤���ΤǼ����Ǥ�Ƚ��Ϥ��ʤ�
" http://yskwkzhr.blogspot.jp/2012/12/set-background-color-of-vim-with-environment-variable.html
"if $TERM !~ 'linux\|screen.linux\|cygwin\|putty' && $COLORFGBG == ''

" �طʿ����䤤��碌�륯����ʸ���������
" screen/tmux�Ǥϥѥ����롼�������󥹤���Ѥ��ƿ�ü�����䤤��碌��
"if $TMUX != ""
    "" tmux����̤�����
    "let s:background_teststr = "\eP\e\e]11;?\e\e\\\\\e\\"
"elseif $TERM == "screen"
    "" GNU Screen����̤�����
    "let s:background_teststr = "\eP\e]11;?\x07\e\\"
"else
    "let s:background_teststr = "\e]11;?\e\\"
"endif

" ���ꤹ���������Ƭʸ����map������Ʊ���˱������Ԥ�
nnoremap <special> <expr> <Esc>]11;rgb: g:SetBackground()
let &t_ti .= "\e]11;?\e\\"
nnoremap <special> <expr> <Esc>]12;rgb: g:SetCursorColor()
let &t_ti .= "\e]12;?\e\\"

function! g:SetBackground()
    " ������ѡ������Ƶ��٤�����
    let rgb = s:ParseRGB(11)
    let gamma = s:GetGammaFromRGBReport(rgb)

    if gamma >= 0
        " ������32768000����Ӥ���dark/light��Ƚ��
        let threshold = 32768000
        if gamma > threshold
            set background=light
        else
            set background=dark
        endif
    endif
    return ''
endfunction

function g:SetCursorColor()
    let rgb = s:ParseRGB(12)

    if type(rgb) == type([])
        let &t_SI = "\e]12;#005fff\e\\"
        let &t_EI = printf("\e]12;#%02x%02x%02x\e\\", rgb[0], rgb[1], rgb[2])
    endif
endfunction

function! s:GetGammaFromRGBReport(rgb)
    " ���٤�׻������֤�
    " ref: http://themergency.com/calculate-text-color-based-on-background-color-brightness/
    if type(a:rgb) == type([])
        return a:rgb[0] * a:rgb[0] * 299 + a:rgb[1] * a:rgb[1] * 587 + a:rgb[2] * a:rgb[2] * 114
    else
        return -1
    endif
endfunction

" ������������֤� ary = ( r, g, b )
let g:ColorList = {}
function! s:ParseRGB(type)
    let cmd = printf(']%d;', a:type)
    execute printf('unmap <Esc>%srgb:', cmd)
    let &t_ti = substitute(&t_ti, "\e" . cmd . "?\e\\", '', '')

    " get RGB value
    let current = ''
    let rgb = []
    let char_count = 0
    let failed = 0
    while 1
        let c = getchar(0)
        if !c
            break
        " 0x07: <Bel>  0x1b: <Esc>  0x2f: /
        elseif c == 0x07 || c == 0x1b || c == 0x2f
            if char_count == 2 || char_count == 4
                call add(rgb, str2nr(current[0:1], 16))
            else
                let failed = 1
            endif
            let char_count = 0
            if c == 0x07
                break
            elseif c == 0x1b
                let c = getchar(0)
                break
            else
                let char_count = 0
                let current = ''
            endif
        elseif c >= 0x30 && c < 0x47 || c >= 61 && c < 0x67  " 0-9, A-F, a-f
            let current .= nr2char(c)
            let char_count += 1
        endif
    endwhile

    let g:ColorList[a:type] = rgb

    if failed || len(rgb) != 3
        return 0
    else
        let rgb = reverse(rgb)
        return rgb
    endif
endfunction
