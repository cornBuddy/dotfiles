let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/workspace/automated-jobs
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +307 test/QuestionsExporter.js
badd +826 logic/QuestionsExporter.js
badd +1026 term://.//10159:/bin/bash
badd +18 jobs/export.js
badd +322 logic/OperationsResearchCenterLogic.js
badd +6 enums/question-types-enum.js
argglobal
silent! argdel *
argadd ./
edit logic/QuestionsExporter.js
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 26 + 37) / 75)
exe 'vert 1resize ' . ((&columns * 99 + 120) / 240)
exe '2resize ' . ((&lines * 45 + 37) / 75)
exe 'vert 2resize ' . ((&columns * 99 + 120) / 240)
exe 'vert 3resize ' . ((&columns * 140 + 120) / 240)
argglobal
edit term://.//10159:/bin/bash
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 1015 - ((25 * winheight(0) + 13) / 26)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1015
normal! 0
wincmd w
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 586 - ((31 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
586
normal! 028|
wincmd w
argglobal
edit test/QuestionsExporter.js
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 306 - ((45 * winheight(0) + 36) / 72)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
306
normal! 025|
wincmd w
2wincmd w
exe '1resize ' . ((&lines * 26 + 37) / 75)
exe 'vert 1resize ' . ((&columns * 99 + 120) / 240)
exe '2resize ' . ((&lines * 45 + 37) / 75)
exe 'vert 2resize ' . ((&columns * 99 + 120) / 240)
exe 'vert 3resize ' . ((&columns * 140 + 120) / 240)
tabnext 1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
