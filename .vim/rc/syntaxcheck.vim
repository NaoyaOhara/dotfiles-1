" ���󥿥å��������å�
" http://d.hatena.ne.jp/osyo-manga/20110921/1316605254

" quickfix �Υ��顼�ս�������ǥϥ��饤��
highlight qf_error ctermbg=red ctermfg=white gui=undercurl
let g:hier_highlight_group_qf='qf_error'

" quickfix �˽��Ϥ��ơ��ݥåץ��åפϤ��ʤ� outputter/quickfix
" ���Ǥ� quickfix ������ɥ��������Ƥ�������Ĥ���Τ����
let s:silent_quickfix=quickrun#outputter#quickfix#new()
function! s:silent_quickfix.finish(session)
    call call(quickrun#outputter#quickfix#new().finish, [a:session], self)
    cclose
    " vim-hier �ι���
    HierUpdate
    " quickfix �ؤν��ϸ�� quickfixstatus ��ͭ����
    QuickfixStatusEnable
endfunction
" quickfix ����Ͽ
call quickrun#register_outputter('silent_quickfix', s:silent_quickfix)

" ���󥿥å��������å��Ѥ� quickrun.vim �Υ���ե���
" perl ��
let g:quickrun_config['PerlSyntaxCheck'] = {
            \ 'type': 'perl',
            \ 'exec': '%c %o %s:p',
            \ 'command': g:vim_home . '/vimparse.pl',
            \ 'cmdopt': '-c ',
            \ 'outputter': 'silent_quickfix',
            \ 'runner': 'vimproc'
            \ }

let g:quickrun_config['CppSyntaxCheck'] = {
            \ 'type': 'cpp',
            \ 'exec': '%c %o %s:p',
            \ 'command': "g++",
            \ 'cmdopt': ' ',
            \ 'outputter': 'silent_quickfix',
            \ 'runner': 'vimproc'
            \ }


" �ե��������¸��� quickrun.vim ���¹Ԥ����褦�����ꤹ��
"autocmd BufWritePost *.pl,*.pm,*.t :QuickRun PerlSyntaxCheck
"autocmd BufWritePost *.cpp,*.h,*.hpp :QuickRun CppSyntaxCheck

" vim:et:
