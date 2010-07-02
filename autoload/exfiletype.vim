" exfiletype - :filetype wrapper for reliable configuration
" Version: 0.0.0
" Copyright (C) 2010 kana <http://whileimautomaton.net/>
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
" Interface  "{{{1
function! exfiletype#configure(argument)  "{{{2
  " FIXME: Support all usage of :filetype.
  " Only the following cases are supported at the moment:
  " - :filetype detect
  " - :filetype plugin indent on
  let has_detect_p = a:argument =~? '\<detect\>'
  let has_indent_p = a:argument =~? '\<indent\>'
  let has_off_p = a:argument =~? '\<off\>'
  let has_on_p = a:argument =~? '\<on\>'
  let has_plugin_p = a:argument =~? '\<plugin\>'
  let loaded_detect_p = exists('g:did_load_filetypes')
  let loaded_indent_p = exists('g:did_indent_on')
  let loaded_plugin_p = exists('g:did_load_ftplugin')

  if (has_on_p || has_detect_p) && !loaded_detect_p
    augroup plugin-exfiletype
      autocmd FileType * nested  call exfiletype#_trigger('FileTypeEnter')
    augroup END
  endif

  execute 'filetype' a:argument

  if (has_on_p || has_detect_p) && !loaded_detect_p
    augroup plugin-exfiletype
      autocmd FileType * nested  call exfiletype#_trigger('FileTypeLeave')
    augroup END
  endif

  return
endfunction








" Misc.  "{{{1
function! exfiletype#_trigger(event_name)  "{{{2
  execute 'doautocmd' 'User' (a:event_name . ':' . expand('<amatch>:t'))
  return
endfunction








" __END__  "{{{1
" vim: foldmethod=marker
