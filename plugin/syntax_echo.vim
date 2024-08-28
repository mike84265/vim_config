
function! EchoSyntaxUnderCursor()
    " Get the word under the cursor
    " let l:word = expand('<cword>')

    " Get the syntax group of the word under the cursor
    let l:syntax_group = synIDattr(synID(line('.'), col('.'), 1), 'name')

    " If there is a syntax group, echo it
    if !empty(l:syntax_group)
        " echo 'Word: ' . l:word . ' | Syntax: ' . l:syntax_group
        echo 'Syntax: ' . l:syntax_group
    else
        " echo 'No syntax group found for: ' . l:word
        echo 'No syntax group found'
    endif
endfunction

" Map the % key to call the EchoSyntaxUnderCursor function
nnoremap % :call EchoSyntaxUnderCursor()<CR>
