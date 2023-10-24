set nocompatible              " be iMproved, required
filetype off                  " required

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
let mapleader = " "

" nmap <Leader>w :CocCommand eslint.executeAutofix<CR>:w<CR>
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>

set spelllang=en
" setlocal spell

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
set updatetime=100                      

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
    elseif a:direction == 'search'
        call CmdLine("CocSearch " . l:pattern)
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" map <C-d> 20j
" map <C-u> 20k

set switchbuf=useopen

set cursorline

try
  set diffopt+=vertical
catch
  set diffopt-=internal
endtry

nmap <leader>l :diffget //3<cr>
nmap <leader>h :diffget //2<cr>
nmap <leader>1 :diffget<cr>

" How many spaces are used as Tab
set tabstop=2
set shiftwidth=2

" Set vertical and horizontal orientation lines
set colorcolumn=80

set softtabstop=2

let g:javascript_plugin_flow = 1

set splitbelow
set splitright

nnoremap <leader>c :%!python -m json.tool<CR>

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

vnoremap <silent> <leader>v :call VisualSelection('search', '')<CR>

""""""""""""""""""""""""""""""
" => FZF
""""""""""""""""""""""""""""""
" nmap <c-f> :Files<CR>
" nmap <c-q> :CocList diagnostics<CR>

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
" let g:no_csv_maps = 1

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
  " if (index(['vim','help'], &filetype) >= 0)
  "   execute 'h '.expand('<cword>')
  " else
    call CocActionAsync('doHover')
  " endif
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

" nmap s :HopWordAC<CR>
" nmap S :HopWordBC<CR>

xnoremap > >gv
xnoremap < <gv

let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
let g:sneak#f_reset = 1
let g:sneak#t_reset = 1

" tex preview
let g:livepreview_previewer = 'open -a Preview'

" for working with latex
nmap <leader>e :silent !pdflatex --interaction=batchmode _main.tex && open -a Preview _main.pdf<CR>


nmap <C-E> :Rg <CR>

" nmap <C-L> :Lines <CR>
nmap <C-B> :Lines <CR>

" for fzf preview window
let $BAT_THEME='gruvbox-dark'

" let g:fzf_preview_window = ['down:70%', 'ctrl-/']
let g:fzf_height = 100

" FZF rg layout
" command! -bang -nargs=* Rg call fzf#vim#grep("rg -g '!{apps/android/*,apps/ios/*,apps/puppeteer/*,apps/kereneia/*,src/data/*,src/client/translations/*,src/client/modules/translations/*,package*}' --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview('down:70%', 'ctrl-/'), <bang>0)
command! -bang -nargs=* Rg call fzf#vim#grep("rg -g '!{apps/android/*,apps/ios/*,apps/puppeteer/*,apps/kereneia/*,src/data/*,src/client/translations/*,src/client/modules/translations/*,package*}' --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'down:70%', 'ctrl-/'), <bang>0)

" Set marks for last open filetype
nnoremap <leader>gj 'J
nnoremap <leader>gs 'S
nnoremap <leader>gt 'T
nnoremap <leader>gx 'X
nnoremap <leader>gh 'H
nnoremap <leader>gy 'Y
nnoremap <leader>ge 'E

augroup VIMRC
  autocmd!
  autocmd BufLeave *.json                         normal! mS
  autocmd BufLeave */src/*.js,*/src/*.ts          normal! mJ
  autocmd BufLeave *.test.js,*.test.ts,*.test.tsx normal! mT             
  autocmd BufLeave */src/*.jsx,*/src/*.tsx        normal! mX        
  autocmd BufLeave *.html                         normal! mH
  autocmd BufLeave */src/types/*.ts               normal! mY
  autocmd BufLeave *.e2e.ts                       normal! mE
augroup END

nnoremap <leader>vs :exec "!code " . expand("%:p") <CR>:redraw!<CR> 

" quicker split movement
nmap <C-H> <C-W>h
nmap <C-L> <C-W>l
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k

nmap z :History <cr>
nmap <C-n> :History: <cr>

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

nmap <leader>b :Git blame <cr>

" trigger autocompletion
inoremap <silent><expr> <c-e> coc#refresh()

let g:vrc_curl_opts = {
            \ '--connect-timeout' : 10,
            \ '-i': '',
            \}

nmap <leader>rn <Plug>(coc-rename)
nmap <leader>re :CocCommand workspace.renameCurrentFile<CR>

" Behave like Vims other bindings (C, D etc.)
nnoremap Y y$

" Keeping it centered
nnoremap J mzJ`z

" jumplist mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nnoremap <Right> :BufSurfForward<CR>
nnoremap <Left> :BufSurfBack<CR>

" close fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

nmap <leader>cl :ccl<CR>

au FileType plantuml let g:plantuml_previewer#plantuml_jar_path = get(
    \  matchlist(system('cat `which plantuml` | grep plantuml.jar'), '\v.*\s[''"]?(\S+plantuml\.jar).*'),
    \  1,
    \  0
    \)

" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
" ## added by OPAM user-setup for vim / ocp-indent ## be135e14924d9275b64438e2e7b91ae3 ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-indent") == 0
  source "/Users/alexanderkehl/.opam/4.14.0/share/ocp-indent/vim/indent/ocaml.vim"
endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line
