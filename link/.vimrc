:set nu
:set ai
:set tabstop=4
:set shiftwidth=4
:set cursorline
:set incsearch
:set hlsearch
:set encoding=utf-8
:inoremap ( ()<ESC>i
:inoremap [ []<ESC>i
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
:inoremap {<CR> {<CR>}<ESC>ko
filetype indent on
:hi LineNr cterm=bold ctermfg=DarkGrey ctermbg=NONE
:hi CursorLineNr cterm=bold ctermfg=Green ctermbg=NONE
:hi Search cterm=reverse ctermbg=None ctermfg=None
:hi Visual cterm=reverse ctermbg=None ctermfg=None
:hi CursorLine cterm=None ctermfg=None ctermbg=DarkBlue
:hi Comment cterm=None ctermfg=DarkGrey ctermbg=None
" Status Line show Mode
" modified from https://gist.github.com/meskarune/57b613907ebd1df67eb7bdb83c6e6641
let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'Normal·Operator Pending',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V·Line',
    \ '^V' : 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '^S' : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \} 
set laststatus=2                           " always show statusline
set noshowmode                             " disable default '-- Insert --', etc line
set statusline=
set statusline+=%{get(g:currentmode,mode(),mode())}   " The current mode
set statusline+=%1*\ %<%F%m%r%h%w         " File path, modified, readonly, helpfile, preview
function! CleverTab()
        if strpart( getline('.'), 0, col('.')-1 ) =~ '^s*$'
                return "<Tab>"
        else
                return "<C-N>"
        endif
endfunction
" inoremap <Tab> <C-R>=CleverTab()<CR>

