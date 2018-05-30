let mapleader = ","
let g:mapleader = ","

" ********** PLUGINS ********** {{{
if &compatible
    set nocompatible
endif

" Required:
call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/vim-plug'

Plug 'easymotion/vim-easymotion'

Plug 'mhinz/vim-startify' " {{{
let g:startify_session_dir = '~/.local/share/nvim/sessions'
let g:startify_session_dir = expand('$DOTFILES_PATH') . '/nvim-sessions'
let g:startify_list_order = ['sessions', 'dir', 'bookmarks', 'commands',
    \ 'files']
let g:startify_session_persistence = 1
let g:startify_change_to_vcs_root = 1
" }}}

Plug 'blueyed/vim-diminactive' " {{{
let g:diminactive_enable_focus = 1
" }}}

Plug 'ctrlpvim/ctrlp.vim' " {{{
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
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'e'
let g:ctrlp_dont_split = 'NERD_tree_2'
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_types = ['fil', 'buf']
let g:ctrlp_extensions = ['tag']
map <C-b> :CtrlPBuffer<CR>
" }}}

Plug 'mileszs/ack.vim' " {{{
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
map <C-f> :Ack!<Space>
" }}}

Plug 'ludovicchabant/vim-gutentags' " {{{
let g:gutentags_ctags_executable = 'ag-ctags'
let g:gutentags_ctags_tagfile = '.git/tags'
" }}}

Plug 'majutsushi/tagbar' " {{{
nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_typescript = {
    \ 'ctagstype': 'typescript',
    \ 'kinds': [
        \ 'c:classes',
        \ 'n:modules',
        \ 'f:functions',
        \ 'v:variables',
        \ 'v:varlambdas',
        \ 'm:members',
        \ 'i:interfaces',
        \ 'e:enums',
    \ ]
\ }
" }}}

Plug 'mhinz/vim-signify' " {{{
let g:signify_vcs_lis = ['git']
let g:signify_sign_change = '~'
let g:signify_disable_by_default = 1
" }}}

Plug 'tpope/vim-fugitive' " {{{
nmap <silent> <leader>gp :Gpush<CR>
noremap <silent> <leader>gs :Gstatus<CR>
" }}}

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp' " {{{
let g:lsp_async_completion = 1
if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio'] },
        \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..')) },
        \ 'whitelist': ['javascript', 'javascript.jsx']
        \ })
    autocmd FileType javascript setlocal omnifunc=lsp#complete
endif
if executable('dockerfile-language-server-nodejs')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'dockerfile-language-server-nodejs',
        \ 'cmd': { server_info->[&shell, &shellcmdflag, 'dockerfile-language-server-nodejs --stdio'] },
        \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..')) },
        \ 'whitelist': ['Dockerfile']
        \ })
    autocmd FileType javascript setlocal omnifunc=lsp#complete
endif
nnoremap <silent> K :LspHover<CR>
nnoremap <silent> gd :LspDefinition<CR>
nnoremap <silent> <F2> :LspRename<CR>
nnoremap <silent> <F10> :LspReferences<CR>
" }}}

Plug 'leafgarland/typescript-vim'

Plug 'ekalinin/Dockerfile.vim'

Plug 'nathanaelkane/vim-indent-guides' " {{{
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'ctrlp']
let g:indent_guides_default_mapping = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
" }}}

Plug 'mattn/emmet-vim', { 'for': 'html' } " {{{
let g:user_emmet_mode = 'a'
" }}}

Plug 'editorconfig/editorconfig-vim'

Plug 'ap/vim-css-color'

" colors
Plug 'JarrodCTaylor/spartan'

" Required:
call plug#end() " }}}

" -----------------------------------------------------------------------------
filetype plugin indent on

" ********** SETTINGS **********
set encoding=utf8
set listchars=tab:▷⋅,trail:⋅
set list
set t_Co=256
set history=100
set autoread
set nonumber
set scrolloff=10
set wildmenu
set wildignore=*.o,*~,*.pyc,.git\*,.hg\*,.svn\*
set cmdheight=1
set hidden
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set mat=2
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set foldcolumn=0
syntax enable
set background=dark
colorscheme spartan
set ffs=unix,dos,mac
set nobackup
set nowb
set noswapfile
set backupcopy=yes
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set lbr
set tw=500
set ruler
set cursorline
set colorcolumn=80
set autoindent
set viminfo^=%
set laststatus=2
set noshowmode
set conceallevel=0
set mouse-=a
set nowrap
set paste
" set signcolumn=yes
set autowriteall

let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

if executable('ag')
    set grepprg=ag\ --vimgrep
    set grepformat=%f:%l:%c%m
endif

" ********** COLORS **********
highlight ColorColumn ctermbg=235
highlight myWarn ctermbg=166 ctermfg=255 cterm=underline
highlight myWarnSign ctermfg=166 ctermbg=236

highlight link CursorLine ColorColumn
highlight link CursorColumn ColorColumn
highlight link IndentGuidesOdd  ColorColumn
highlight link IndentGuidesEven ColorColumn

" ********** FUNCTIONS **********
" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc

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

function! MaximizeToggle()
    if exists("s:maximize_session")
        exec "source " . s:maximize_session
        call delete(s:maximize_session)
        unlet s:maximize_session
        let &hidden=s:maximize_hidden_save
        unlet s:maximize_hidden_save
    else
        let s:maximize_hidden_save = &hidden
        let s:maximize_session = tempname()
        set hidden
        exec "mksession! " . s:maximize_session
        only
    endif
endfunction

" ********** MAPPINGS **********
nnoremap <silent> <leader>q :Bclose<CR>
nnoremap <leader>w :wa!<cr>
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
map 0 ^
nnoremap <C-w>z :call MaximizeToggle()<CR>
nnoremap <silent> <leader>t :Lexplore<CR>

" ********** HOOKS **********
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
autocmd FocusLost * :wa
autocmd BufWrite * :call DeleteTrailingWS()
