" quickrun
" 他のと干渉するのでマッピングはしない
let g:quickrun_no_default_key_mappings=1
" 必要なモジュールをロード
let g:quickrun_perl_modules = '-MYAML -M"HTTP::Date qw.str2time time2iso." -MDateTime -MDate::Manip -Mutf8 -MIO::All'
if is_office
	let g:quickrun_perl_modules .= ' -MGameConf -M"Ope::Common::Smart::AD_Common qw.get_ds."'
endif
if is_remora
    let g:quickrun_perl_modules .= ' -M"feature qq!say!"'
endif

if !exists('g:quickrun_config')
    let g:quickrun_config = {}
endif

let g:quickrun_config['perl'] = {
            \ 'exec': '%c %o %s',
            \ 'command': 'perl',
            \ 'cmdopt': '%{g:quickrun_perl_modules}',
            \ 'eval': 1,
            \ 'eval_template': 'no strict;binmode STDOUT,":utf8";$e=eval{%s};print$e?Dump($e):$@',
            \ 'runner' : 'vimproc',
            \ }

" ビジュアルモードで選択した部分を実行
command! -range R :QuickRun perl -mode v
"command! R :QuickRun perl -mode v
