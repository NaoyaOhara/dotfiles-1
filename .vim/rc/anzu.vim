" n �θ�� anzu-mode �򳫻Ϥ���
nmap n <Plug>(anzu-mode-n)
" N �θ�� anzu-mode �򳫻Ϥ���
nmap N <Plug>(anzu-mode-N)

" n �� N ������˻��Ѥ��ޤ���
"nmap n <Plug>(anzu-n)
"nmap N <Plug>(anzu-N)
"nmap * <Plug>(anzu-star)
"nmap # <Plug>(anzu-sharp)

" g* ���˥��ơ������������Ϥ�����
nmap g* g*<Plug>(anzu-update-search-status-with-echo)

" �Ǹ�˸���������ɤ� [count] �ΰ��֤ذ�ư����
" 10<Leader>j �Ǥ������Ƭ����10���ܤΥ�ɤΰ��֤ذ�ư����
"nmap <Leader>j <Plug>(anzu-jump)
" ���ơ���������򥳥ޥ�ɥ饤��˽��Ϥ�����Ϥ�����
"nmap <Leader>j <Plug>(anzu-jump)<Plug>(anzu-echo-search-status)
nmap <Leader>n <Plug>(anzu-jump)<Plug>(anzu-echo-search-status)

" ���ơ���������� statusline �ؤ�ɽ������
"set statusline=%{anzu#search_status()}

" ���������Ѥ����
" ��ư��˥��ơ���������򥳥ޥ�ɥ饤��ؤȽ��Ϥ�Ԥ��ޤ���
" nmap n <Plug>(anzu-n-with-echo)
" nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)

" sign ����˻��Ѥ�����
" nmap n <Plug>(anzu-n-with-echo)<Plug>(anzu-sign-matchline)
" nmap N <Plug>(anzu-N-with-echo)<Plug>(anzu-sign-matchline)

