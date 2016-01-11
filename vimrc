syntax on
set nowrap
set nocompatible

set expandtab "insert spaces instead of tab
set softtabstop=4
set shiftwidth=4
set rulerformat=%40(%t%=[0x%B\ \ %l,%c\ %p%%]%)
set ruler
set ignorecase
set backspace=2
set autoindent
set fileencodings=utf8,default,cp1251,latin1,ucs-bom
set makeprg=cMake.py

autocmd FileType python set omnifunc=pythoncomplete#Complete commentstring=#%s# foldmethod=indent | %foldopen! | set softtabstop=4 | set shiftwidth=4
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags commentstring=<!--%s-->
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags   commentstring=<!--%s-->
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType c set omnifunc=ccomplete#Complete

set viminfo='10,\"100,:20,%,n~/.viminfo

" when we reload, tell vim to restore the cursor to the saved position
augroup JumpCursorOnEdit
 au!
 autocmd BufReadPost *
 \ if expand("<afile>:p:h") !=? $TEMP |
 \ if line("'\"") > 1 && line("'\"") <= line("$") |
 \ let JumpCursorOnEdit_foo = line("'\"") |
 \ let b:doopenfold = 1 |
 \ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
 \ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
 \ let b:doopenfold = 2 |
 \ endif |
 \ exe JumpCursorOnEdit_foo |
 \ endif |
 \ endif
 " Need to postpone using "zv" until after reading the modelines.
 autocmd BufWinEnter *
 \ if exists("b:doopenfold") |
 \ exe "normal zv" |
 \ if(b:doopenfold > 1) |
 \ exe "+".1 |
 \ endif |
 \ unlet b:doopenfold |
 \ endif
augroup END

set tags+=tags;/    

" Encodings
"<F7> EOL format (dos <CR><NL>,unix <NL>,mac <CR>)
"                set  wildmenu
"                set  wcm=<Tab>
"                menu EOL.unix :set fileformat=unix<CR>
"                menu EOL.dos  :set fileformat=dos<CR>
"                menu EOL.mac  :set fileformat=mac<CR>
"                menu EOL.my_win2unix :%s /\r\n/\r/g<CR>
"                map  <F7> :emenu EOL.<Tab>
"                map  <F4> [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
map <F3> :copen<Cr>
map <C+F3> :close<Cr>
map <F7> :wall \| make<Cr>
map <F4> :cp<Cr>zvzz:cc<Cr>
map <F5> :cn<Cr>zvzz:cc<Cr>
"<F2> Change encoding
                set  wildmenu
                set  wcm=<Tab>
                menu Enc.cp1251     :e ++enc=cp1251<CR>
                menu Enc.koi8-r     :e ++enc=koi8-r<CR>
                menu Enc.cp866      :e ++enc=ibm866<CR>
                "menu Enc.utf8       :e ++enc=utf8<CR>
                menu Enc.utf-8      :set encoding=utf8<CR>
                menu Enc.ucs-2le    :e ++enc=ucs-2le<CR>
                map  <F2> :emenu Enc.<Tab>

"if has('mouse')
"    set mouse=a
"endif

set number
map <F8> :tab split<CR> :exec("ts ".expand("<cword>"))<CR>
map <F9> :vsp<CR> :exec("ts ".expand("<cword>"))<CR>
map <C-\> :vsp<CR> :exec("ts ".expand("<cword>"))<CR>
map <C-]> :exec("ts ".expand("<cword>"))<CR>

"<F6> compilation
    set wildmenu
    set wcm=<Tab>
    menu Compile.cMake    :!cMake.py <CR>
    menu Compile.g++      :!g++ % -Wall -pedantic -g -o %< <CR>
    map <F6> :emenu Compile.<Tab>

"set background=dark
"colorscheme solarized

" Move current tab into the specified direction.
"
" @param direction -1 for left, 1 for right.
function! TabMove(direction)
    " get number of tab pages.
    let ntp=tabpagenr("$")
    " move tab, if necessary.
    if ntp > 1
        " get number of current tab page.
        let ctpn=tabpagenr()
        " move left.
        if a:direction < 0
            let index=((ctpn-1+ntp-1)%ntp)
        else
            let index=(ctpn%ntp)
        endif
        
        " move tab page.
        execute "tabmove ".index
    endif
endfunction

:imap jk <Esc>
:map <C-h> :tabp<CR>
:map <C-l> :tabn<CR>
:map <C-j> :call TabMove(-1)<CR>
:map <C-k> :call TabMove(1)<CR>
:map <C-a> ggVG

set hlsearch
nnoremap * *N
nnoremap ( :nohlsearch<CR>
vnoremap * y :execute ":let @/=@\""<CR> :execute "set hlsearch"<CR>

set tabpagemax=100
