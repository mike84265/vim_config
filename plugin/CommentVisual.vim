function! Comment(exe_mode, line1, line2)
  " save current time for profiling (optional)
  let l:t_start = reltime()

  " Get the current file type
  let l:file_type = &filetype
  let l:current_line = line('.')
  let l:current_col = col('.')

  " Set the comment characters based on the file type
  " comment_chars[0]: search pattern; comment_chars[1]: insert pattern
  if l:file_type == 'python' || l:file_type == 'csh' || l:file_type == 'tcsh' || l:file_type == 'sh' || l:file_type == 'yaml'
    let l:comment_chars = ['# ', '# ']
  elseif l:file_type == 'vim'
    let l:comment_chars = ['" ', '" ']
  elseif l:file_type == 'basic'
    let l:comment_chars = ["' ", "' "]
  elseif l:file_type == 'cpp' || l:file_type == 'c' || l:file_type == 'javascript' || l:file_type == 'cuda'
    let l:comment_chars = ['\/\/ ', '\/\/ ']
  elseif l:file_type == 'spice' || l:file_type == 'spf'
    let l:comment_chars = ['\* ', '* ']
  elseif l:file_type == 'skill'
    let l:comment_chars = ['; ', '; ']
  elseif l:file_type == 'log'
    let l:comment_chars = ['\*\* ', '** ']
  elseif l:file_type == 'tex'
    let l:comment_chars = ['% ', '% ']
  else
    let l:comment_chars = ['# ', '# ']
  endif

  let l:line_text = getline(a:line1)
  let l:leading_spaces = strchars(matchstr(line_text, '^\s*'))
  if a:exe_mode == 'comment'
    redir => l:msg
redir => l:msg
    " use lookahead to avoid matching commented lines and empty lines
    try
      silent execute printf('%d,%ds/^\s\{%d}\zs\ze\s*\(\s*%s\)\@!\S\@=/%s/g', a:line1, a:line2, l:leading_spaces, l:comment_chars[0], l:comment_chars[1])
    catch /^Vim\((\a\+)\):E486:/
      let l:msg = 'No comment added'
    endtry
    redir END
  elseif a:exe_mode == 'uncomment'
    redir => l:msg
    try
      silent execute printf('%d,%ds/^\s\{%d}\zs%s//g', a:line1, a:line2, l:leading_spaces, l:comment_chars[0])
    catch /^Vim\((\a\+)\):E486:/
      let l:msg = 'Nothing to be uncommented'
    endtry
    redir END
  elseif a:exe_mode == 'flip'
    let l:n_comment = 0
    let l:n_uncomment = 0
    for l:line_number in range(a:line1, a:line2)
      " Get the current line
      let l:line_text = getline(l:line_number)

      " Check if the line is already commented
      if l:line_text =~ '^\s*' . l:comment_chars[0]
        " Uncomment the line
        try
          execute printf('%ds/^\s\{%d}\zs%s//', l:line_number, l:leading_spaces, l:comment_chars[0])
          let l:n_uncomment += 1
        catch /^Vim\((\a\+)\):E486:/
        endtry
      elseif l:line_text =~ '^\s*\S\+'
        " Comment the line
        execute printf('%ds/^\s\{%d}\zs/%s/', l:line_number, l:leading_spaces, l:comment_chars[1])
        let l:n_comment += 1
      endif
    endfor
    let l:msg = printf('%d lines commented and %d lines uncommented', l:n_comment, l:n_uncomment)
  endif

  " Move cursor to original line
  call cursor(l:current_line, l:current_col)
  let l:elapsed_ms = str2float(reltimestr(reltime(l:t_start))) * 1000
  let l:elapsed_str = printf('elapsed time: %.3f ms', l:elapsed_ms)
  let l:msg = substitute(l:msg, '\n', ' ', '')
  echo l:msg . '; ' . elapsed_str 
endfunction

function! CommentVisual(exe_mode)
  let [l:line1, l:line2] = [line("'<"), line("'>")]
  call Comment(a:exe_mode, l:line1, l:line2)
endfunction

vnoremap <silent> <Leader>c :<C-U>call CommentVisual('comment')<CR>
vnoremap <silent> <Leader>u :<C-U>call CommentVisual('uncomment')<CR>
vnoremap <silent> <Leader>f :<C-U>call CommentVisual('flip')<CR>

nnoremap <silent> <Leader>c :<C-U>call Comment('comment', line('.'), line('.')+v:count1-1)<CR>
nnoremap <silent> <Leader>u :<C-U>call Comment('uncomment', line('.'), line('.')+v:count1-1)<CR>
nnoremap <silent> <Leader>f :<C-U>call Comment('flip', line('.'), line('.')+v:count1-1)<CR>

command! -range Cm call Comment('comment', <line1>, <line2>)
command! -range Uc call Comment('uncomment', <line1>, <line2>)
command! -range Fc call Comment('flip', <line1>, <line2>)
