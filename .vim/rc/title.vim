function! GetTitleString()
    " �Ƽ�ե饰
    let modified = getbufvar('', '&mod') ? '+' : ''
    let readonly = getbufvar('', '&ro') ? '=' : ''
    let modifiable = getbufvar('', '&ma') ? '' : '-'
    let flag = modified . readonly . modifiable
    let flag = len(flag) ? ' ' . flag : ''
    " �ۥ���̾
    let host = hostname() . ':'
    " �ե�����̾
    let filename = expand('%:t')
    " �ե�����̾���ʤ����
    let filename = len(filename) ? filename : 'NEW FILE'
    " $H �����ꤷ�Ƥ�����ϡ��ѥ�����ִ�����
    let sub_home = len($H) ? ':s!' . $H . '!$H!' : ''
    let dir = expand('%:p' . sub_home . ':~:.:h')
    " 'svn/game/' ��ä�
    let dir = substitute(dir, 'svn/game/', '', '')
    " dir ���̤ǳ��
    let dir = len(dir) && dir != '.' ? ' (' . dir . ')' : ''
    " ɽ��ʸ��������
    let str = host . filename . flag . dir
    " win32 �λ��������ȥ�С��� 2 �Х���ʸ�������ä��鲽����Τ��н褹��
    if !has('win32')
        let str2 = ''
        for char in split(str, '\zs')
            if char2nr(char) > 255
                let str2 = str2 . '_'
            else
                let str2 = str2 . char
            endif
        endfor
        let str = str2
    endif
    return str
endfunction

" �����ȥ�ʸ�������
set titlestring=%{GetTitleString()}
if &term =~ '^screen'
    set t_ts=k
    set t_fs=\
endif
" ������ɥ������ȥ�򹹿�����
if &term =~ '^screen' || &term =~ '^xterm'
    set title
endif

