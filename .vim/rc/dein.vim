scriptencoding utf-8

let s:dein_dir = expand(g:home . '/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

let g:dein#install_progress_type = 'title'
let g:dein#enable_notification = 1

if dein#load_state(s:dein_dir)
  let s:toml = [
        \ {'name': 'default'},
        \ {'name': 'deoplete'},
        \ {'name': 'denite'},
        \ {'name': 'lazy',          'lazy': 1},
        \ {'name': 'denite_lazy',   'lazy': 1},
        \ {'name': 'deoplete_lazy', 'lazy': 1},
        \ {'name': 'map',           'lazy': 1},
        \ {'name': 'cmd',           'lazy': 1},
        \ {'name': 'ft',            'lazy': 1},
        \ {'name': 'event',         'lazy': 1},
        \ ]
  let s:path = {name -> printf('%s/dein/%s.toml', g:rc_dir, name)}
  let s:load_toml = {name, lazy -> dein#load_toml(s:path(name), {'lazy': lazy})}

  call dein#begin(s:dein_dir, map(deepcopy(s:toml), {_, t -> t['name']}))
  call map(s:toml, {_, t -> s:load_toml(t['name'], get(t, 'lazy', 0))})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" TODO: hack for filetype
let g:did_load_filetypes = 1
filetype plugin indent on
