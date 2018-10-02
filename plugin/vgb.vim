" vim et sw=4 sts=4 ts=4

" Plugin: https://github.com/dfaught/vim-gdb-break
" Version: 0.0.0
" Description: A tiny plugin to add/remove breakpoints to a file used by gdb
" Maintainer: Derek Faught <http://github.com/dfaught>

if exists('g:loaded_vgb')
	finish
endif

let g:loaded_vgb = 1 

if !exists('g:vgb_break_file')
	let g:break_file = '.gdb-breaks'
endif

if !exists('g:vgb_mark')
	let g:vgb_mark = "❎"
endif

execute "sign define breakLine texthl=ErrorMsg text=". g:vgb_mark
let g:break_id = 1
let g:break_list = []
let g:cur_break = 0 

nnoremap <silent><Plug>(VgbNextBreak) :call vgb#next()<CR>
nnoremap <silent><Plug>(VgbPrevBreak) :call vgb#prev()<CR>
nnoremap <silent><Plug>(VgbAddBreak) :call vgb#add()<CR>
nnoremap <silent><Plug>(VgbRemBreak) :call vgb#remove()<CR>

if !exists('g:vgb_no_mappings')
	nmap nb <Plug>(VgbNextBreak)
	nmap pb <Plug>(VgbPrevBreak)
	nmap ba <Plug>(VgbAddBreak)
	nmap br <Plug>(VgbRemBreak)
endif
