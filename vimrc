augroup pluggroup
  autocmd!
  autocmd VimEnter $MYVIMRC PlugUpgrade
  autocmd VimEnter $MYVIMRC PlugUpdate
  autocmd VimEnter $MYVIMRC q
augroup END

let mapleader = ","
let maplocalleader = "\\"

call plug#begin('~/.vim/plugged')
Plug 'Chiel92/vim-autoformat'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'iamcco/markdown-preview.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
call plug#end()


set autoindent
"set background=light
"colorscheme desert
set backspace=indent,eol,start
set cindent
set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s
set clipboard+=unnamed
set cmdheight=1
set cursorline
set expandtab
set foldenable
set foldmethod=manual
set foldcolumn=1
setlocal foldlevel=1
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set magic
set matchtime=1
"set nobackup
"set noswapfile
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
set nocompatible
set nojoinspaces
set nu rnu
set ruler
set scrolloff=3
set shiftround
set smartindent
set smartcase
set showcmd
set showmode
set showmatch
set shiftwidth=2 softtabstop=2 tabstop=2
set suffixes=.bak,~,.o,.h,.info,.swp,.aux,.bbl,.blg,.dvi,.lof,.log,.lot,.ps,.toc
set termguicolors
set undofile
set wildmenu
set wrap

" Inent for C code
autocmd FileType c setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

" Indend levels setting
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_color=0
hi IndentGuidesOdd ctermbg=grey
hi IndentGuidesEven ctermbg=darkgrey

" Make comments and special characters look better
highlight Comment    ctermfg=245 guifg=#8a8a8a
highlight NonText    ctermfg=240 guifg=#585858
highlight SpecialKey ctermfg=240 guifg=#585858

"When opening vim, cursor goes to the location stopped in last editing
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

""" Statusline
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=\%f%m%r%h%w
"set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y
set statusline+=%=
set statusline+=[ASCII=\%03.3b]
set statusline+=\ %03c:%05l[%p%%]

""" Statusline <END>

"将键盘上的F6功能键映射为添加作者信息的快捷键
map <leader><F6> ms:call TitleDet()<cr>'s
function! AddTitle()
    call append(0,"/*******************************************************    ************************")
    call append(1," * Author : Zhifeng Hu | SDSU/UCSD.")
    call append(2," * Email  : hzfmer94@gmail.com")
    call append(3," * Last modified : ".strftime("%Y-%m-%d %H:%M"))
    call append(4," * Filename   : ".expand("%:t"))
    call append(5," * Description    : ")
    call append(6," * *****************************************************    ************************/")
    echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endfunction

"更新最近修改时间和文件名
"When opening vim, cursor goes to the location stopped in last editing
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
function! UpdateTitle()
    normal m'
    execute '/# *Last modified:/s@:.*$@\=strftime(":\t%Y-%m-%d %H:%M")@'
    normal "
    normal mk
    execute '/# *Filename:/s@:.*$@\=":\t\t".expand("%:t")@'
    execute "noh"
    normal 'k
    echohl WarningMsg | echo "Successful in updating the copy right."| echohl None
endfunction

"判断前10行代码里面，是否有Last modified这个单词，
"如果没有的话，代表没有添加过作者信息，需要新添加；
"如果有的话，那么只需要更新即可
function! TitleDet()
    let n=1
    while n < 10
        let line = getline(n)
        if line =~'^\#\s*\S*Last\smodified:\S*.*$'
            call UpdateTitle()
            return
        endif
        let n = n + 1
    endwhile
    call AddTitle()
endfunction

""" Keyboard mapping
inoremap jk <Esc>
inoremap <leader><c-d> <esc>ddi
inoremap <leader><c-u> <esc>viwUi
nnoremap <leader><c-u> viwU
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>w :w<cr>
nnoremap <S-Tab> <<
nnoremap <Tab> >>
onoremap in@ :<c-u>execute "normal! /[[:alnum:]._]\\+@[[:alnum:]]\\+\\.\\w\\+\r"<cr>
" Add ' around visual selection
vnoremap <leader>' <Esc>'<i'<Esc>'>i'<Esc>  
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv
""" Keyboard mapping <END>


""" Abbreviations
iabbrev eml --<cr>Zhifeng Hu<cr>hzfmer94@gmail.com

""" Abbreviations <END>


""" Autocmd 
autocmd FileType python nnoremap <buffer><localleader>c I#<esc>

""" Autocmd <END>

"" Plugin settings """"""""""""""""""""""""""""""""""""""""

"""  fzf
let g:fzf_action = {
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'down': '~60%'}

command! -bang -nargs=* Ag
            \ call fzf#vim#ag(<q-args>,
            \                 <bang>0 ? fzf#vim#with_preview('up:60%')
            \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
            \                 <bang>0)
nnoremap <silent> <Leader>A :Ag<CR>

""" fzf """

""" AutoFormat
"au BufWrite * :Autoformat
let g:autoformat_verbosemode=1
let g:formatdef_custom_c = '"astyle -C --style=google --indent=spaces=2"'
let g:formatters_c = ['custom_c']
noremap <leader><F3> :Autoformat<CR>
""" AutoFormat """

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END
