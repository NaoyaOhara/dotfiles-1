scriptencoding utf-8

function! delphinus#init#denite#hook_source() abort
  call denite#custom#var('my_file_rec', 'command', ['pt', '--follow', '--nocolor', '--nogroup', '-g', ''])
  call denite#custom#map('insert', '<Esc>', '<denite:enter_mode:normal>')
  call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
  call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
  call denite#custom#map('insert', '<C-u>', '../', 'noremap')
  call denite#custom#map('insert', '~', expand('~'), 'noremap')
  call denite#custom#source('_', 'matchers', ['matcher_substring'])
  " Pt command on grep source
  call denite#custom#var('grep', 'command', ['pt'])
  call denite#custom#var('grep', 'default_opts', ['--nogroup', '--nocolor', '--smart-case'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#source('grep', 'args', ['', '', '!'])
  " ref. https://github.com/arcticicestudio/nord-vim/issues/79
  call denite#custom#option('default', {
        \ 'prompt': '❯❯❯',
        \ 'statusline': v:false,
        \ 'highlight_matched_char': 'Underlined',
        \ 'cursor_wrap': v:true,
        \ })
  call denite#custom#option('dein', 'default_action', 'narrow')
  call denite#custom#action('file', 'dwm_new', function('s:dwm_new'))
  call denite#custom#action('buffer', 'dwm_new', function('s:dwm_new'))
  call denite#custom#action('memo', 'dwm_new', function('s:dwm_new'))
  call denite#custom#action('directory', 'my_file_rec', function('s:file_rec'))
  call denite#custom#action('directory', 'grep', function('s:grep'))
  call denite#custom#map('insert', '<C-n>', '<denite:do_action:dwm_new>')
  call denite#custom#map('insert', '<C-a>', '<denite:do_action:my_file_rec>')
  call denite#custom#map('insert', '<C-g>', '<denite:do_action:grep>')
  call denite#custom#source('my_file_rec', 'converters', ['devicons_denite_converter'])
endfunction

function! s:dwm_new(context)
  call DWM_New()
  call denite#do_action(a:context, 'open', a:context['targets'])
endfunction

function! s:file_rec(context)
  call s:start_action_for_path(a:context, 'file_rec')
endfunction

function! s:grep(context)
  call s:start_action_for_path(a:context, 'grep')
endfunction

function! s:start_action_for_path(context, action, ...)
  let l:target = a:context['targets'][0]
  let l:path = get(l:target, 'action__path', '')
  if isdirectory(l:path)
    if a:action ==# 'grep'
      call denite#start([{'name': 'grep', 'args': [l:path, '', '!']}])
    else
      call denite#start([{'name': a:action, 'args': [l:path]}])
    endif
  else
    call denite#util#print_error(printf('unknown path for target: %s', l:target))
  endif
endfunction
