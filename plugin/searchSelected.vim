function! SearchSelected()
  let l:text = getreg('s')
  let l:text = substitute(l:text, '\\', '\\\\', 'g')
  let l:text = substitute(l:text, '/', '\\/', 'g')
  return '\V' . l:text
endfunction

vnoremap * "sy/<C-r>=SearchSelected()<CR><CR>
vnoremap # "sy/<C-r>=SearchSelected()<CR><CR>
