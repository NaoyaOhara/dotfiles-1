" �񤭹��߸�˥��󥿥å��������å���Ԥ�
let g:watchdogs_check_BufWritePost_enable = 1


" ���ä��ϰ�����֥������Ϥ��ʤ��ä����˥��󥿥å��������å���Ԥ�
" �Хåե��˽񤭹��߸塢1�٤����Ԥ���
let g:watchdogs_check_CursorHold_enable = 0

let g:quickrun_config['watchdogs_checker/perl'] = {
            \ 'cmdopt': '-Ilib',
            \ }

" ���δؿ��� g:quickrun_config ���Ϥ�
" ���δؿ��� g:quickrun_config �˥��󥿥å��������å���Ԥ������������ɲä���
" �ؿ���ƤӽФ������ߥ󥰤ϥ桼���� g:quickrun_config �����
call watchdogs#setup(g:quickrun_config)
