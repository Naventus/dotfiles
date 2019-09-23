"setting
set fenc=utf-8 "文字コードをUFT-8に設定
set nobackup "バックアップファイルを作らない
set noswapfile "スワップファイルを作らない
set autoread "編集中のファイルが変更されたら自動で読み直す
set hidden "バッファが編集中でもその他のファイルを開けるように
set showcmd "入力中のコマンドをステータスに表示する

"見た目系
set title "タイトル表示
set number "行番号を表示
set ruler "カーソル位置可視化
set cursorline "現在の行を強調表示
"set cursorcolumn " 現在の行を強調表示（縦）
set virtualedit=onemore "行末の1文字先までカーソルを移動できるように
set smartindent "インデントはスマートインデント

set visualbell "ビープ音を可視化
set showmatch "括弧入力時の対応する括弧を表示
set laststatus=2 "ステータスラインを常に表示
set wildmode=list:longest "コマンドラインの補完

" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk

syntax enable "シンタックスハイライトの有効化

" Tab系
"set list listchars=tab:\▸\- "不可視文字を可視化(タブが「▸-」と表示される)
set expandtab "Tab文字を半角スペースにする
set tabstop=2 "行頭以外のTab文字の表示幅（スペースいくつ分）
set shiftwidth=2 "行頭でのTab文字の表示幅

let g:netrw_banner = 0 "上部の情報を削除
let g:netrw_liststyle = 3 "tree view
let g:netrw_altv = 1 " 分割viewを右側に出す
let g:netrw_winsize = 85 "分割時に85%で開く

" vim-go setting
set autowrite

call plug#begin()
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
  Plug 'scrooloose/nerdtree'
  Plug 'morhetz/gruvbox'
call plug#end()

" nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

:command Gr $(GO111MODULE=on go run -v ./main.go)

autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_function_calls = 1

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

colorscheme gruvbox
