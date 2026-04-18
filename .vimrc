syntax enable
filetype plugin indent on	"filetypeが検出出来るようになるらしい
" set relativenumber " debug情報で何行目と出ても分からないのでOFFにする
set number
set updatetime=200
set nocompatible			"vi互換モードではなくVimとして使う
set clipboard+=unnamed		"yankのclipboardへのコピー
set nowrap
set hlsearch
set ignorecase
set smartcase
set incsearch
"------------------------------------------------
" tab
"-------------------------------------------------
set tabstop=2
set softtabstop=2
set shiftwidth=2
"------------------------------------------------
" indent
"-------------------------------------------------
set autoindent

let mapleader = "\<Space>"

if has('vim_starting')
	let &t_SI .= "\e[6 q"
	let &t_EI .= "\e[2 q"
	let &t_SR .= "\e[4 q"
endif

" ColorSchemeの設定
autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none
" colorscheme iceberg
set background=dark

" bufferを保存して閉じる 
nnoremap wb :w\|bd<cr>
" enter2回でウィンドウを移動
nnoremap <Return><Return> <C-w><C-w>

" Insert mode shortcuts similar to Emacs
inoremap <C-f> <Right>
inoremap <C-b> <Left>
" inoremap <silent><expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<Up>"
" inoremap <silent><expr> <C-n> coc#pum#visible() ? coc#pum#next(1) : "\<Down>"
" inoremap <silent><expr> <tab> coc#pum#visible() ? coc#pum#confirm() : "\<tab>"
" " coc-pairs config
" inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'hrsh7th/vim-vsnip' " ファイルタイプ毎に補完のためのスニペットが定義出来るようになる
Plug 'hrsh7th/vim-vsnip-integ'
" Plug 'neoclide/coc.nvim', {'branch': 'release'} "vim-lspを使うようにする
" Plug 'rust-lang/rust.vim'                       "何となくコメントアウト
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug '/opt/homebrew/opt/fzf'
call plug#end()

" vim-lspの設定
function! s:on_lsp_buffer_enabled() abort
  if &buftype ==# 'nofile' || &filetype =~# '^\(quickrun\)' || getcmdwintype() ==# ':'
		return
  endif
  " Language Serverが有効になったバッファに対する設定
  setlocal omnifunc=lsp#complete
  "以下は好みで設定
  nmap <buffer> gd <plug>(lsp-definition)
	nmap <buffer> gr <plug>(lsp-references)
	nmap <buffer> gi <plug>(lsp-implementation)
  "nmap <buffer> <f2> <plug>(lsp-rename)
  "nmap <buffer> <c-k> <plug>(lsp-hover)
endfunction
augroup vimrc_lsp_install
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

"rust
":wで自動rustfmt
let g:rustfmt_autosave = 1
"取り敢えずコピペ
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"lspのエラーやワーニングの色を変える
"highlight CocErrorSign ctermfg=167 ctermbg=0
"highlight CocWarningSign ctermfg=215 ctermbg=0

"vim-airline-thems
let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_synbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.branch = '⌥'
nmap <C-n> <Plug>AirlineSelectNextTab

"fzf
command! -bang -nargs=* FZF call fzf#vim#command(<q-args>, {'source': 'find', 'options': '--reverse'})
nnoremap <Leader>f :FZF<CR>

