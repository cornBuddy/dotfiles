" With a map leader it's possible to do extra key combinations
let mapleader = ","
let g:mapleader = ","

" ********** PLUGINS **********
if &compatible
  set nocompatible
endif

" Required:
call plug#begin('~/.local/share/nvim/plugged')

" Let Plug manage Plug
" Required:
Plug 'junegunn/vim-plug'

" utilities
Plug 'easymotion/vim-easymotion'

Plug 'Shougo/vimproc.vim', {'do' : 'make'} " dependency for tsu

Plug 'edkolev/promptline.vim' " bash promtline

Plug 'bling/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline_theme = 'distinguished'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#tab_nr_type = 2 " splits and tab number
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_min_count = 1
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#format = 1
let g:airline#extensions#syntastic#enabled = 0
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#ctrlp#color_template = 'normal'
let g:airline#extensions#promptline#snapshot_file = "~/.shell_prompt.sh"
let g:airline#extensions#promptline#enabled = 1
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ }
function! ShowLineNumber()
    return line(".") . ' / ' . line("$") . ' : ' . col('.')
endfunction
function! ShowFileName()
    return expand("%:t")
endfunction
function! InitAirline()
    call airline#parts#define_function('z', 'ShowLineNumber')
    call airline#parts#define_function('c', 'ShowFileName')
    let g:airline_section_c = airline#section#create(['c'])
    let g:airline_section_x = ''
    let g:airline_section_y = ''
    let g:airline_section_z = airline#section#create(['z'])
    let g:airline_section_error = ''
    let g:airline_section_warning = ''
endfunction
autocmd User AirlineAfterInit call InitAirline()
" bingings
nmap <Leader>1 <Plug>AirlineSelectTab1
nmap <Leader>2 <Plug>AirlineSelectTab2
nmap <Leader>3 <Plug>AirlineSelectTab3
nmap <Leader>4 <Plug>AirlineSelectTab4
nmap <Leader>5 <Plug>AirlineSelectTab5
nmap <Leader>6 <Plug>AirlineSelectTab6
nmap <Leader>7 <Plug>AirlineSelectTab7
nmap <Leader>8 <Plug>AirlineSelectTab8
nmap <Leader>9 <Plug>AirlineSelectTab9
nmap <C-Left> <Plug>AirlineSelectPrevTab
nmap <C-Right> <Plug>AirlineSelectNextTab
" -----------------------------------------------------------------------------

Plug 'vim-airline/vim-airline-themes'

Plug 'blueyed/vim-diminactive' " highlight inactive window
" diminactive
" let g:diminactive_use_syntax = 1
" -----------------------------------------------------------------------------

Plug 'christoomey/vim-tmux-navigator'
" tmux navigator
" Write all buffers before navigating from Vim to tmux pane
let g:tmux_navigator_save_on_switch = 2
" -----------------------------------------------------------------------------

" file working
Plug 'kien/ctrlp.vim'
" ctrlp settings
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command =
    \ 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$" --ignore-dir "node_modules"'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
else
  " Fall back to using git ls-files if Ag is not available
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif
let g:ctrlp_working_path_mode = 0
let g:ctrlp_switch_buffer = 'e'
noremap <C-b> :CtrlPBuffer<CR>
let g:ctrlp_dont_split = 'NERD_tree_2'
"------------------------------------------------------------------------------

Plug 'scrooloose/nerdtree'
map <leader>t :NERDTreeToggle<CR>
"------------------------------------------------------------------------------

" version control
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-fugitive'
command! GP execute "Gpull --rebase | Gpush"
nmap <silent> <leader>gp :GP<CR>
noremap <silent> <leader>s :Gstatus<CR>
" -----------------------------------------------------------------------------

" languages and framevorks
Plug 'scrooloose/syntastic'
" syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_enable_signs = 1
let g:syntastic_loc_list_height = 5
" js
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'
" ts
let g:syntastic_typescript_checkers = ['tsuquyomi', 'tslint']
" elixir
let g:syntastic_elixir_checkers = ['elixir']
let g:syntastic_enable_elixir_checker = 1
" html
" let g:syntastic_mode_map = { 'passive_filetypes': ['html']  }
let g:syntastic_mode_map = { 'mode': 'passive'  }
"------------------------------------------------------------------------------

" javascript
Plug 'moll/vim-node' " on-demand loading doesn't work here

Plug 'ternjs/tern_for_vim'
let g:tern_show_argument_hints = 'on_hold'
let g:tern_map_keys = 0
let g:tern_request_timeout = 15
" -----------------------------------------------------------------------------

Plug 'leafgarland/typescript-vim'


Plug 'Quramy/tsuquyomi'
" tsu
let g:tsuquyomi_disable_quickfix = 1
let g:tsuquyomi_shortest_import_path = 1
let g:tsuquyomi_use_vimproc = 1
let g:tsuquyomi_single_quote_import = 1
" -----------------------------------------------------------------------------

Plug 'othree/xml.vim', { 'for': 'html' }

Plug 'elixir-lang/vim-elixir'

" text working
Plug 'Yggdroot/indentLine'
" indentline settings
let g:indentLine_leadingSpaceEnabled = 0
let g:indentLine_char = '|'
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*']
let g:indentLine_color_term = 240
" -----------------------------------------------------------------------------

Plug 'mattn/emmet-vim', { 'for': 'html' }
" emmet settings
let g:user_emmet_mode = 'a'
" -----------------------------------------------------------------------------

Plug 'jiangmiao/auto-pairs'

Plug 'editorconfig/editorconfig-vim'

Plug 'Chiel92/vim-autoformat'

Plug 'neomake/neomake'
autocmd! BufWritePost,BufEnter * Neomake
" elixir
let g:neomake_elixir_enabled_makers = ['mix', 'credo']
" js
let g:neomake_javascript_enabled_makers = ['eslint_d']
" ts
let ts_maker = { 'name': 'tsuquyomi' }
function! ts_maker.get_list_entries(jobinfo) abort
    return tsuquyomi#createFixlist()
endfunction
let g:neomake_typescript_enabled_makers = [ts_maker]
" etc
let g:neomake_open_list = 2
let g:neomake_list_height = 5
augroup my_neomake_highlights
    au!
    autocmd ColorScheme *
      \ hi link NeomakeError SpellBad |
      \ hi link NeomakeWarning SpellCap
augroup END
let g:neomake_highlight_lines = 1
let g:neomake_highlight_columns = 1
"------------------------------------------------------------------------------

" colors
Plug 'xero/sourcerer.vim'
Plug 'crusoexia/vim-monokai'
Plug 'marcus/vim-mustang'
Plug 'goatslacker/mango.vim'
Plug 'mhinz/vim-janah'
Plug 'w0ng/vim-hybrid'
Plug 'Drogglbecher/vim-moonscape'
Plug 'yuttie/hydrangea-vim'
Plug 'JarrodCTaylor/spartan'
Plug 'wolverian/minimal'

" Required:
call plug#end()

" promptline settings
let g:promptline_preset = {
    \'a' : [ promptline#slices#vcs_branch() ],
    \'b' : [ promptline#slices#git_status() ],
    \'c' : [ promptline#slices#cwd() ],
    \'warn' : [ promptline#slices#last_exit_code() ],
    \ }
" -----------------------------------------------------------------------------

" ********** SETTINGS **********
" Required:
filetype plugin indent on

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

set listchars=tab:▷⋅,trail:⋅
set list

" autosave on focus lost
:au FocusLost * :wa
set autowriteall

" set 256 colors
set t_Co=256

" Sets how many lines of history VIM has to remember
set history=100

" Set to auto read when a file is changed from the outside
set autoread

set nonumber " set line numbers

" Set 10 lines to the cursor - when moving vertically using j/k
set so=10

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

"Always show current position
set ruler

" highlight line
set cursorline

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

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

" Remove margin from left
set foldcolumn=0

" Enable syntax highlighting
syntax enable
try
    set background=dark
    colorscheme spartan " nice one, red light is annoying
catch
endtry

" higlight background
" highlight Normal ctermbg=238

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
set backupcopy=yes

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

" Show vertical line on 80 symbols
set colorcolumn=80
highlight ColorColumn ctermbg=235 guibg=#2c2d27
set ruler
highlight CursorLine ctermbg=235 guibg=#2c2d27
highlight CursorColumn ctermbg=235 guibg=#2c2d27

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" turn off continuation of comments
set formatoptions-=cro

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" Always show the status line
set laststatus=2

" Hide default status line
set noshowmode

" disable auto visual mode with mouse
set mouse-=a

" turn off wrapping
set nowrap

" ********** FUNCTIONS **********
" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWS()

" Delete buffer while keeping window layout (don't close buffer's windows).
" Version 2008-11-18 from http://vim.wikia.com/wiki/VimTip165
if v:version < 700 || exists('loaded_bclose') || &cp
  finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
  let bclose_multiple = 1
endif

" Display an error message.
function! s:Warn(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
endfunction

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
function! s:Bclose(bang, buffer)
  if empty(a:buffer)
    let btarget = bufnr('%')
  elseif a:buffer =~ '^\d\+$'
    let btarget = bufnr(str2nr(a:buffer))
  else
    let btarget = bufnr(a:buffer)
  endif
  if btarget < 0
    call s:Warn('No matching buffer for '.a:buffer)
    return
  endif
  if empty(a:bang) && getbufvar(btarget, '&modified')
    call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
    return
  endif
  " Numbers of windows that view target buffer which we will delete.
  let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
  if !g:bclose_multiple && len(wnums) > 1
    call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
    return
  endif
  let wcurrent = winnr()
  for w in wnums
    execute w.'wincmd w'
    let prevbuf = bufnr('#')
    if prevbuf > 0 && buflisted(prevbuf) && prevbuf != w
      buffer #
    else
      bprevious
    endif
    if btarget == bufnr('%')
      " Numbers of listed buffers which are not the target to be deleted.
      let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
      " Listed, not target, and not displayed.
      let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
      " Take the first buffer, if any (could be more intelligent).
      let bjump = (bhidden + blisted + [-1])[0]
      if bjump > 0
        execute 'buffer '.bjump
      else
        execute 'enew'.a:bang
      endif
    endif
  endfor
  execute 'bdelete'.a:bang.' '.btarget
  execute wcurrent.'wincmd w'
endfunction
command! -bang -complete=buffer -nargs=? Bclose call s:Bclose('<bang>', '<args>')

" ********** MAPPINGS **********
nnoremap <silent> <leader>c :close<CR>
nnoremap <silent> <leader>q :Bclose<CR>
nmap <leader>w :wa!<cr>
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
" Remap VIM 0 to first non-blank character
map 0 ^
" normal mode for nvim terminal
tnoremap <Esc> <C-\><C-n>
