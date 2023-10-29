if (exists("g:loaded_tabline_vim") && g:loaded_tabline_vim) || &cp
    finish
endif
let g:loaded_tabline_vim = 1

function! Tabline()
    let s=''
    for i in range(tabpagenr('$'))
        let tab = i + 1
        let winnr = tabpagewinnr(tab)
        let buflist = tabpagebuflist(tab)
        let bufnr = buflist[winnr - 1]
        let bufname = bufname(bufnr)
        let bufmodified = getbufvar(bufnr, "&mod")

        let s .= '%' . tab . 'T'
        let s .= (tab == tabpagenr()? '%#TabLineSel#' : '%#TabLine#')
        let s .= ' ' . tab . ':-'

        let fname = (bufname != ''? fnamemodify(bufname, ':t') : 'No Name')
        let maxlength = winwidth(0) / tabpagenr('$') - 4

        if bufmodified
            let fname = (strlen(fname)+1>maxlength? fname[0:maxlength-5] . '+' : fname)
            let fname = '[' . fname . ']* '
        else
            let fname = (strlen(fname)>maxlength? fname[0:maxlength-4] . '+' : fname)
            let fname = '[' . fname . '] '
        endif 

        let s .= fname
    endfor

    let s .= '%#TabLineFill#'
    if (exists("g:tablineclosebutton"))
        let s .= '%=%999XX'
    endif
    return s
endfunction
set tabline=%!Tabline()
