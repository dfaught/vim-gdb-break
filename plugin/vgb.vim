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
	let g:vgb_mark = ❎
endif

sign define breakLine texthl=ErrorMsg text=g:vbg_mark
let g:break_id = 0
let g:break_list = []
let g:cur_break = 0 

" nnoremap <silent><Plug>(vgb-next-break) :call vgb#next()
" nnoremap <silent><Plug>(vgb-prev-break) :call vgb#prev()
nnoremap <silent><Plug>(vgb-add-break) :call vgb#add()
nnoremap <silent><Plug>(vgb-rem-break) :call vgb#remove()

if !exists('g:vgb_no_mappings')
	" nmap nb <Plug>(vgb-next-break)
	" nmap pb <Plug>(vgb-prev-break)
	nmap ab <Plug>(vgb-add-brreak)
	nmap rb <Plug>(vgb-rem-break)
endif
