function! AutoReload(...)
  if a:0 > 0
    let &updatetime = a:1
  else
    let &updatetime = 1000
  endif

  let g:_lineNoSaved = line('$')
  set autoread | au CursorHold * checktime | let g:_lineNoSaved = MoveCursor(g:_lineNoSaved)
  set visualbell t_vb=
  echo 'Start auto reloading ' . expand('%:p')
endfunction

function! MoveCursor(lastLine)
  let l:currLine = line('.')
  call feedkeys("lh")
  if l:currLine != a:lastLine
    call cursor(l:currLine, col('.'))
  else
    call cursor(line('$'), col('.'))
  endif
  return line('$')
endfunction

function! NoReload()
  checktime
  let g:_lineNoSaved = MoveCursor(g:_lineNoSaved)
  au! CursorHold
  set noautoread
  echo 'Stop auto reloading ' . expand('%:p')
endfunction

cabbrev autoload <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'call AutoReload()' : 'autoload')<CR>
cabbrev noautoload <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'call NoReload()' : 'noautoload')<CR>
