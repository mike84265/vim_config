function! InsertHeader()
  let l:name = expand('%:t:r')
  let l:file_type = &filetype
  if l:file_type == 'csh' || l:file_type == 'tcsh' || l:file_type == 'sh'
    let l:comment_chars = '# '
    let l:enclosure = ['#' . repeat('=', 80), '#' . repeat('=', 80)]
  elseif l:file_type == 'python'
    let l:comment_chars = '* '
    let l:enclosure = ['"""', '"""']
  elseif l:file_type == 'vim'
    let l:comment_chars = '" '
    let l:enclosure = ['"' . repeat('=', 80), '"' . repeat('=', 80)]
  elseif l:file_type == 'basic'
    let l:comment_chars = "' "
    let l:enclosure = ["'" . repeat('=', 80), "'" . repeat('=', 80)]
  elseif l:file_type == 'cpp' || l:file_type == 'c' || l:file_type == 'skill'
    let l:comment_chars = '* '
    let l:enclosure = ['/*' . repeat('*', 80), repeat('*', 80) . '*/']
  elseif l:file_type == 'spice' || l:file_type == 'spf'
    let l:comment_chars = '* '
    let l:enclosure = ['*' . repeat('=', 80), '*' . repeat('=', 80)]
  else
    let l:comment_chars = '# '
    let l:enclosure = ['#' . repeat('=', 80), '#' . repeat('=', 80)]
  endif

  if getline(1)[0:1] == '#!'
    let l:origin = 1
  else
    let l:origin = 0
  endif

  call append(l:origin+0, l:enclosure[0])
  call append(l:origin+1, l:comment_chars . 'Name:         [ ' . l:name . ' ]')
  call append(l:origin+2, l:comment_chars . 'Author:       [ Mike Tsai ]')
  call append(l:origin+3, l:comment_chars . 'Last Change:  [ ' . strftime('%Y/%m/%d %R') . ' ]')
  call append(l:origin+4, l:comment_chars . 'Synopsis:     [  ]')
  call append(l:origin+5, l:enclosure[1])
  call cursor(l:origin+5, 17+len(l:comment_chars))
endfunction

function! UpdateHeaderTime()
  if getline(1)[0:1] == '#!'
    let l:origin = 1
  else
    let l:origin = 0
  endif
  let l:timeText = getline(l:origin+4)
  let l:currentTime = strftime('%Y/%m/%d %R')
  let l:newText = substitute(l:timeText, '\d\{4}/\d\{2}/\d\{2} \d\{2}:\d\{2}', l:currentTime, '')
  if l:newText != l:timeText
    call setline(l:origin+4, l:newText)
    echo 'Last modified time set to ' . l:currentTime
  else
    echo 'Header not found, or timestamp not changed'
  endif
endfunction

function! AdvProgHeader()
" A function to create header for ECE 6122
  let l:origin = 0
  let l:enclosure = ['/*', '*/']
  let l:comment_chars = ''
  call append(l:origin+0, l:enclosure[0])
  call append(l:origin+1, l:comment_chars . 'Author: Cheng-Yu (Mike) Tsai')
  call append(l:origin+2, l:comment_chars . 'Class: ECE 6122 A')
  call append(l:origin+3, l:comment_chars . 'Last Date Modified: ' . strftime('%m/%d/%Y'))
  call append(l:origin+4, l:comment_chars . 'Description: ')
  call append(l:origin+5, l:comment_chars)
  call append(l:origin+6, l:comment_chars)
  call append(l:origin+7, l:comment_chars)
  call append(l:origin+8, l:enclosure[1])
  call cursor(l:origin+7, len(l:comment_chars))
endfunction

function! UpdateAdvProgHeaderTime()
  let l:origin = 0
  let l:timeText = getline(l:origin+4)
  let l:currentTime = strftime('%m/%d/%Y')
  let l:newText = substitute(l:timeText, '\d\{2}/\d\{2}/\d\{4}', l:currentTime, '')
  if l:newText != l:timeText
    call setline(l:origin+4, l:newText)
    echo 'Last modified time set to ' . l:currentTime
  else
    echo 'Header not found, or timestamp not changed'
  endif
endfunction

let advprog = 0

" cabbrev header <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'call InsertHeader()' : '')<CR>
" map <Leader>t : call UpdateHeaderTime()<CR>

cabbrev header <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? (advprog==1? 'call AdvProgHeader()' : 'call InsertHeader()')  : '')<CR>
map <Leader>t : call (advprog==1? UpdateAdvProgHeaderTime() : UpdateHeaderTime())<CR>
