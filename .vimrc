se number
"se so=999
nnoremap <C-t> :let [&nu, &rnu] = [&nu+&rnu==0, &nu]<CR>  

command! NUMTOGGLE (&nu==&rnu ? "se nornu! | se ru!" : "se noru! | se rnu!")<CR>

highlight currawong ctermbg=darkred guibg=darkred
match currawong /\v.*(%'a|%'b|%'c|%'d).*/ 

fun! Marklist() abort
  redir => str
  :silent marks
  redir END
  echo str
endfun

nnoremap <C-q> :exec "wq!"<CR>
inoremap <C-q> <Esc>:exec "wq!"<CR>

nnoremap <Space> :call History()<CR>
nnoremap mm :call Marks()<CR>
nnoremap my :call CopyMarks()<CR>
nnoremap md :call DeleteMarks()<CR>
nnoremap cm :call ClearMarks()<CR>
call writefile([expand("%:p")], expand("$HOME") . "/.vimhistory.log", "a")
function History()
	execute "e " . expand("$HOME") . "/.vimhistory.log"
	execute "%s/\n//g"
	execute "sort u"
endfunction


let markPosition = 97
function Marks()
	let x = nr2char(g:markPosition)
	echo x
	execute "normal! m".x
	:redraw!
	let g:markPosition = g:markPosition+ 1
endfunction

function CopyMarks()
	let x = nr2char(g:markPosition)
	let y = nr2char(g:markPosition - 1)
	echo ":". x . "," . y . "yy" 
endfunction

function DeleteMarks()
	let x = nr2char(g:markPosition)
	let y = nr2char(g:markPosition - 1)
	echo ":". x . "," . y . "dd" 
endfunction

function ClearMarks()
	let g:markPosition = 97
	:delmarks a-z
	:redraw!
endfunction

function! SearchFunc(param) 
	execute "!find ~+ -name '*".a:param."*' > ~/.results"
	execute 'edit ~/.results'
endfunction		
command! -nargs=1 Search call SearchFunc(<f-args>)

function! GrepFunc(param) 

	execute "!grep -r -n -B2 -A2 '".a:param."' . > ~/.grepresults"
	execute 'edit ~/.grepresults'
endfunction		

command! -nargs=1 SearchFunc call GrepFunc(<f-args>)

let recordingMacro = 0 
function MacroFunc()
	if (g:recordingMacro == 0)
		normal qw0
		let g:recordingMacro = 1 
	else
		let g:recordingMacro = 0 
		normal j0q
	endif 
endfunction 
nnoremap `` :call MacroFunc()<cr>

function OpenWeb() 
	execute "w!"
	normal yy
	execute '!open' @
endfunction
nnoremap ! :call OpenWeb()<CR>

function OpenFile() 
	execute "w!"
	normal yy
	let z = @
	call writefile([z], expand("$HOME") . "/.vimhistory.log", "a")
	echo z
	execute 'edit' @
endfunction
nnoremap <cr> :call OpenFile()<cr>

function OpenFileVisual() 
	normal gvyy
	let z = @
	call writefile([z], expand("$HOME") . "/.vimhistory.log", "a")
	execute 'edit' @
endfunction
xnoremap <cr> :call OpenFileVisual()<cr>

function HeaderFile()
	let x = expand("%:p")
	let b = ".c"
	if (stridx(x, b) == -1) 
		let x = substitute(x, "\\.h", "\.c", "")
	else
		let x = substitute(x, "\\.c", "\.h", "")
	endif
	execute "w!"
	execute "e " .x 
endfunction
nnoremap cc :call HeaderFile()<CR>

function HeaderFileTab()
	let x = expand("%:p")
	let b = ".c"
	if (stridx(x, b) == -1) 
		let x = substitute(x, "\\.h", "\.c", "")
	else
		let x = substitute(x, "\\.c", "\.h", "")
	endif
	execute "w!"
	execute "vs " .x 
endfunction
nnoremap CC :call HeaderFileTab()<CR>


xnoremap <Tab> :normal @w<CR>
nnoremap <Tab> @w
inoremap <C-s> <Esc>:Search 
nnoremap <C-s> <Esc>:Search 
nnoremap s <Esc>:SearchFunc
inoremap <C-q> <Esc>:exec "wq!"<CR>
inoremap { {}<Esc>ha
inoremap <C-w> <S-Right>
inoremap <C-b> <S-Left>
inoremap <C-h> <Left>
inoremap <C-h> <Left>
inoremap <C-j> <Up>
inoremap <C-k> <Down>
inoremap <C-l> <Right>
inoremap <C-o> <Esc>0o
inoremap <C-q> <Esc>0i
inoremap <C-x> <Esc>xi
inoremap <C-d> <Esc>0d$i
inoremap <C-a> <Home>
inoremap <C-f> <End>
inoremap <C-g> <Esc>:Lex<cr>:vertical resize 80<cr>
inoremap <C-y> <Esc>yy
inoremap <C-p> <Esc>p
nnoremap # :bn<cr>
nnoremap @ :bp<cr>
set cursorline
hi CursorLine ctermbg=8 ctermfg=15 "8 = dark gray, 15 = white"
hi Cursor ctermbg=15 ctermfg=8
cnoremap <C-h> <Left>
cnoremap <C-j> <Up>
cnoremap <C-k> <Down>
cnoremap <C-l> <Right>



syntax on
set ruler
set colorcolumn=80
set autoindent

let num = 0
command! Increment let num = num + 1
command! ClearCount let num = 0 
command! GetCount put =num

set cursorline
hi CursorLine ctermbg=8 ctermfg=15 "8 = dark gray, 15 = white"
hi Cursor ctermbg=15 ctermfg=8


inoremap <C-g> <Esc>:Lex<cr>:vertical resize 80<cr>
nnoremap <C-g> <Esc>:Lex<cr>:vertical resize 80<cr>

set hlsearch

runtime! ftplugin/man.vim
let g:ft_man_open_mode = 'vert'
nnoremap gp p`[v`]

nnoremap t Lzz
nnoremap <S-t> Hzz
