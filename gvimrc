let os = substitute(system('uname'), '\n', '', '')
if os == 'Darwin' || os == 'Mac'
    set guifont=Consolas:h16
elseif os == 'Linux'
    set guifont=Consolas\ 14
endif
colorscheme koehler
set gcr=n-v-c:ver25-Cursor/lCursor,ve:ver25-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175,a:blinkon0
hi  Search        gui=NONE            guifg=black       guibg=lightblue
hi  DiffAdd       gui=BOLD            guifg=white       guibg=darkgreen
hi  DiffChange    gui=BOLD            guifg=white       guibg=#5f00d7
hi  DiffText      gui=BOLD            guifg=white       guibg=darkmagenta
hi  DiffDelete    gui=BOLD            guifg=black       guibg=darkred
hi  Folded        gui=italic          guifg=#646464     guibg=#262626
hi  TabLine       gui=NONE            guifg=white       guibg=darkblue
hi  TabLineSel    gui=BOLD,UNDERLINE  guifg=#0000ff     guibg=#ffd700
hi  TabLineFill   gui=NONE            guifg=white       guibg=#00005f
hi  LineNr        gui=BOLD            guifg=#666666
hi  Cursor                                              guibg=white
hi  CursorLine    gui=NONE            guifg=NONE        guibg=#585858
hi  CursorLineNr  gui=BOLD,UNDERLINE  guifg=#22bb22

set showtabline=2 "always show tabs in gvim, but not vim
" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
    let label = ''
    let bufnrlist = tabpagebuflist(v:lnum)
    let winnr = tabpagewinnr(v:lnum)
    let bufnr = bufnrlist[winnr-1]
    let bufmodified = getbufvar(bufnr, "&mod")
    
    " Append the tab number
    let label .= v:lnum.':['
    " Append the buffer name
    let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
    if name == ''
        " give a name to no-name documents
        if &buftype=='quickfix'
            let name = 'Quickfix List'
        else
            let name = 'No Name'
        endif
    else
        " get only the filename
        let name = fnamemodify(name, ":t")
    endif
    let label .= name . ']'

    if bufmodified
        let label .= '*'
    endif

    " Append the number of windows in the tab page
    " let wincount = tabpagewinnr(v:lnum, '$')
    " let label .= '  [' . wincount . ']'
    return label
endfunction

set guitablabel=%{GuiTabLabel()}
