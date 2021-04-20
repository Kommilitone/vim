set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/fzf.vim.git'
Plugin 'morhetz/gruvbox.git'
Plugin 'jiangmiao/auto-pairs.git'
Plugin 'terryma/vim-expand-region.git'
Plugin 'tpope/vim-surround.git'
Plugin 'tpope/vim-repeat.git'
Plugin 'tpope/vim-projectionist.git'
Plugin 'airblade/vim-gitgutter.git'
Plugin 'itchyny/lightline.vim.git'
Plugin 'chrisbra/csv.vim.git'
Plugin 'terryma/vim-multiple-cursors.git'
Plugin 'sheerun/vim-polyglot.git'
Plugin 'diepm/vim-rest-console'
Plugin 'dyng/ctrlsf.vim.git'
Plugin 'kevinhwang91/rnvimr.git'
Plugin 'tomtom/tcomment_vim.git'
Plugin 'chrisbra/Colorizer.git'
Plugin 'justinmk/vim-sneak.git'
Plugin 'mattn/emmet-vim.git'
Plugin 'christoomey/vim-tmux-navigator.git'
Plugin 'heavenshell/vim-jsdoc.git'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" nmap <Leader>w :CocCommand eslint.executeAutofix<CR>:w<CR>
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Display long lines as just one line
set nowrap

" More space for displaying messages
set cmdheight=1

" Faster completion
set updatetime=300                      

" By default timeoutlen is 1000 ms
set timeoutlen=500                      

"Always show current position
set ruler

" A buffer becomes hidden when it is abandoned
set hid

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif


" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-e> <Plug>(easymotion-bd-w)
let g:EasyMotion_smartcase = 1

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>


" Close the current buffer
map <leader>d :Bclose<cr>:tabclose<cr>gT

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>0 :e ~/buffer<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()

function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("CtrlSF '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'tags'
        call CmdLine("Tags " . l:pattern)
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

map <C-d> 20j
map <C-u> 20k

set switchbuf=useopen

set cursorline

try
  set diffopt+=vertical
catch
  set diffopt-=internal
endtry

nmap <leader>l :diffget 3<cr>
nmap <leader>h :diffget 2<cr>
nmap <leader>1 :diffget<cr>

" How many spaces are used as Tab
set tabstop=2
set shiftwidth=2

" Set vertical and horizontal orientation lines
set colorcolumn=80

set softtabstop=2

let g:javascript_plugin_flow = 1

" nnoremap <Space> <C-^>

set splitbelow
set splitright

nnoremap <leader>c :%!python -m json.tool<CR>

" fzf stuff
set rtp+=/usr/local/opt/fzf

nmap § :Buffers<CR>


" Disable scrollbars (real hackers don't use scrollbars for navigation!)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" Colorscheme

set nu
set rnu
colorscheme gruvbox
set background=dark

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on 
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bash like keys for the command line
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ack searching and cope displaying
"    requires ack.vim - it's much better than vimgrep/grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you CtrlSF after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open CtrlSF and put the cursor in the right position
map <leader>g :CtrlSF 

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

""""""""""""""""""""""""""""""
" => FZF
""""""""""""""""""""""""""""""
nmap <c-f> :GFiles<CR>
nmap <c-q> :Files<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }


" expand region settings
let g:expand_region_text_objects = {
      \'i>': 1,
      \'i<': 1,
      \'a>': 1,
      \'a<': 1,
      \'i]': 1,
      \'ib': 1,
      \'iB': 1,
      \'a]': 1,
      \'aB': 1,
      \'ab': 1,
      \'i"': 0,
      \'i''': 0,
      \'a"': 0,
      \'a''': 0
      \ } 
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" use code syntax and style to align
set smartindent

" auto save on losing focus
:au FocusLost * silent! wa

" jsdoc hotkey
nmap <silent> <C-l> <Plug>(jsdoc)
let g:jsdoc_enable_es6 = 1

" multiple cursors bindings
let g:multi_cursor_start_word_key      = '<C-s>'
let g:multi_cursor_next_key            = '<C-s>'

" auto html tags filetypes
let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.jsx, *.vue, *.js'

" remove all mappings from csv plugin
let g:no_csv_maps = 1

" jumps to exact mark position
" nnoremap ' `

" Some servers have issues with backup files, see #649
set nowritebackup

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap \ :TComment<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

imap <C-j> <Plug>(coc-snippets-expand)

set tags=./tags,tags;$HOME

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Make Ranger replace netrw and be the file explorer
let g:rnvimr_ex_enable = 1

nmap <C-p> :RnvimrToggle<CR>

nmap <leader>1 :tabn 1<CR>
nmap <leader>2 :tabn 2<CR>
nmap <leader>3 :tabn 3<CR>
nmap <leader>4 :tabn 4<CR>
nmap <leader>5 :tabn 5<CR>
nmap <leader>6 :tabn 6<CR>
nmap <leader>7 :tabn 7<CR>
nmap <leader>8 :tabn 8<CR>
nmap <leader>9 :tabn 9<CR>

nmap <leader>t :tabnew<CR>

xnoremap > >gv
xnoremap < <gv

let g:sneak#label = 1
let g:sneak#use_ic_scs = 1

" tex preview
let g:livepreview_previewer = 'open -a Preview'

" for working with latex
nmap <leader>e :silent !pdflatex --interaction=batchmode _main.tex && open -a Preview _main.pdf<CR>


nmap <C-E> :Rg <CR>

" nmap <C-L> :Lines <CR>
nmap <C-B> :Lines <CR>

" for fzf preview window
let $BAT_THEME='gruvbox'

" let g:fzf_preview_window = ['down:70%', 'ctrl-/']
let g:fzf_height = 100

" FZF rg layout
command! -bang -nargs=* Rg call fzf#vim#grep("rg -g '!{apps/android/*,apps/ios/*,apps/puppeteer/*,apps/kereneia/*,src/data/*,src/client/translations/*,src/client/modules/translations/*,package*}' --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview('down:70%', 'ctrl-/'), <bang>0)

" Set marks for last open filetype
nnoremap <Space>c 'C
nnoremap <Space>j 'J
nnoremap <Space>s 'S
nnoremap <Space>t 'T
nnoremap <Space>x 'X
nnoremap <Space>h 'H
nnoremap <Space>y 'Y

augroup VIMRC
  autocmd!
  autocmd BufLeave *.css,*.scss           normal! mC
  autocmd BufLeave *.json                 normal! mS
  autocmd BufLeave */src/*.js,*/src/*.ts  normal! mJ
  autocmd BufLeave *.test.js,*.test.ts    normal! mT
  autocmd BufLeave *.jsx,*.tsx            normal! mX
  autocmd BufLeave *.html                 normal! mH
  autocmd BufLeave */src/types/*.ts       normal! mY
augroup END

nnoremap <leader>vs :exec "!code " . expand("%:p") <CR>:redraw!<CR> 

" quicker split movement
nmap <C-H> <C-W>h
nmap <C-L> <C-W>l
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k

nmap <C-n> :History <CR>
nmap <cr> :History: <CR>

set viminfo='500

" vim projectionist
nnoremap <Leader>a :A<CR>

" Stop that stupid window from popping up
map q: :q

nmap <leader>f :CocFix<CR>

" dont save { and } jumps to jump history
:nnoremap <silent> } :<C-u>execute 'keepjumps normal!' v:count1 . '}'<CR>
:nnoremap <silent> { :<C-u>execute 'keepjumps normal!' v:count1 . '{'<CR>

" esc on kj
:imap kj <Esc>
