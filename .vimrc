" For vim-go plugin
syntax on
filetype plugin indent on
 
let mapleader="\\"
" for ctrlp plugin
"ret runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 0
let g:go_def_mode = "gopls"  
 
" TODO: coc YouCompleteMe autocomplete -> ./install.py --go-completer
 
" Switch mouse on
set mouse=a 
 
" Mapping for fast quit without save
noremap <Backspace> :q<cr>
noremap <c-h> :q<cr>
" TODO: noremap gc :GoCallers<cr>
" TODO: noremap gi :GoImplements<cr>
" TODO: noremap gr :GoReferrers<cr>
noremap ff :lnext<cr>
noremap fb :lprev<cr>
noremap fc :cclose<cr> :lclose<cr>
noremap fn :cnext<cr>
noremap fp :cprev<cr>
set backspace=indent,eol,start
 
" Display line numbers
set nu
set relativenumber
 
" Disable swap file creation
set noswapfile
 
" autocmd vimenter * ++nested 
" colorscheme codedark
colorscheme gruvbox-material
" colorscheme nord
" colorscheme aquarium
" colorscheme gruvbox
" colorscheme onedark
set bg=dark
" -- for transparency
" hi Normal guibg=NONE ctermbg=NONE
 
" -- https://draculatheme.com/vim
" packadd! dracula
" colorscheme dracula
 
" -- Open GoDef in different pane
" TODO: cnoreabbrev gd GoDef
 
function SplitAndDef()
				split | :GoDef
				return 0
endfunction 
 
noremap <NUL> :call SplitAndDef()<CR>
 
" For cplouring the terminal
" This enables vim airline
set laststatus=2
 
" For multicursor select
let g:multi_cursor_start_word_key = '<C-d>'
let g:multi_cursor_start_key = 'g<C-d>'
 
" Nerdtree file manager
map <C-n> :NERDTreeToggle<CR>
 
" To run GoImports on save
let g:go_fmt_command = "goimports"
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_variable_assignments = 1
 
 
" splits
"remap to move between splits
nnoremap <c-w>k <c-w><c-j>
nnoremap <c-w>l <c-w><c-k>
nnoremap <c-w>; <c-w><c-l>
nnoremap <c-w>j <c-w><c-h>
 
""Swap top/bottom or left/right split
"Ctrl+W R
 
"Break out current window into a new tabview
"Ctrl+W T
 
"Close every window in the current tabview but the current one
"Ctrl+W o
 
"esc Alternative
imap ;; <Esc>
"window size
nnoremap = :10winc><CR>
noremap - :10winc<<CR>
nnoremap _ :10winc-<CR>
noremap + <c-w>:10winc+<CR>
"map <s-j> <c-w><
"map <s-;> <c-w>>
 
noremap <c-o> :split<CR>
noremap <c-e> :vsplit<CR>
 
noremap ; <Right>
noremap j <Left>
noremap k <Down>
noremap l <Up>
 
" Enable emmet vim for just html and css
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
 
set encoding=utf-8
 
set autoindent
set smartindent
 
" Tab settings
" Set Tab size to 1
set tabstop=4
" Helpful when using TAB
set softtabstop=0 noexpandtab
" Indent a single tab
set shiftwidth=4
 
set guifont=Menlo\ Regular:h20
 
" Automatically closing braces
inoremap {<CR> {<CR>}<Esc>ko
inoremap [<CR> [<CR>]<Esc>ko
inoremap (<CR> (<CR>)<Esc>ko
 
inoremap {<c-j> {<CR>}<Esc>ko
inoremap [<c-j> [<CR>]<Esc>ko
inoremap (<c-j> (<CR>)<Esc>ko
 
map <c-k> :w<CR>
inoremap '' <Esc>:wq<CR>
noremap '' :wq<CR>
 
noremap <leader>l :tab term ++close lazygit<CR>
noremap <leader>t :tab term ++close<CR>
 
" let g:vimspector_enable_mappings = 'HUMAN'
 
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction
 
" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction
 
let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ ]
 
 
" how often to write swap to disk (ms)
" for vim gitgutter
" [c & ]c can be used to nav through git hunks
set updatetime=100
 
" hunk status in the bar
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d/~%d/-%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}
 
" start nerdtree and move cursor away from it
" autocmd VimEnter * NERDTree | wincmd p
 
" Exit Vim if NERDTree is the only window left.
" autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    "\ quit | endif
 
" do not change into the dir of selected file
" so that ctrlp works correctly with startify
let g:startify_change_to_dir = 0
 
" show command completions in a menu
set wildmenu
 
" disables the annoying preview window in a scratch split
set completeopt-=preview
 
nnoremap <leader>s :CtrlPLine<CR>
"autocmd FileType php,go argadd **
 
" :set noeol binary ----> removes newline from the end of the file
 
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  "let g:ctrlp_use_caching = 0
endif
 
let g:ctrlp_extensions = ['buffertag']
let g:ctrlp_types = ['mru', 'fil', 'buf']
let g:ctrlp_mruf_max = 100
 
" execute command in current line:
" :.w !bash
 
" debugging controls
nnoremap <F5> :GoDebugStart<CR>
nnoremap <F2> :GoDebugBreakpoint<CR>
nnoremap <F3> :GoDebugContinue<CR>
nnoremap <F6> :GoDebugStep<CR>
nnoremap <F7> :GoDebugStepOut<CR>
 
" syntax highlighting does not break in huge files:
" set redrawtime=1000
" :%!jq .
"
" camelcase to snakecase:
" :%s/\<\u\|\l\u/\= join(split(tolower(submatch(0)), '\zs'), '_')/gc
 
set colorcolumn=100
 
" Locate current file in nerdtree
nnoremap <leader>f :NERDTreeFind<CR>
 
" One trick I like to use a lot is to search for the current word under the cursor in the files. I first press * so that the word is selected. Then I use this empty pattern to search for it: :vim // *.cpp
 

" NOTE: coc
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
set nobackup
set nowritebackup
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
