" if !has('gui_running')
"     finish
" endif

" Function to adjust the font size
function! AdjustFontSize(delta)
    " Get the current guifont setting
    let l:current_font = &guifont

    " Match the current font size in the guifont setting
    if l:current_font =~ '\v(.*)\s(\d+)'
        let l:font_name = matchstr(l:current_font, '\v(.{-})\ze\s\d+')
        let l:font_size = str2nr(matchstr(l:current_font, '\v\d+$'))

        " Calculate the new font size
        let l:new_size = l:font_size + a:delta

        " Ensure font size doesn't go below 1
        if l:new_size < 1
            let l:new_size = 1
        endif

        " Set the new guifont with the updated size
        let &guifont = l:font_name . ' ' . l:new_size
        echo 'Font size set to ' . l:new_size
    else
        echo 'Failed to determine font size from guifont'
    endif
endfunction

" Map Ctrl-+ to increase font size
nnoremap <C-S-+> :call AdjustFontSize(1)<CR>
inoremap <C-S-+> <Esc>:call AdjustFontSize(1)<CR>i

" Map Ctrl-- to decrease font size
nnoremap <C-_> :call AdjustFontSize(-1)<CR>
inoremap <C-_> <Esc>:call AdjustFontSize(-1)<CR>
