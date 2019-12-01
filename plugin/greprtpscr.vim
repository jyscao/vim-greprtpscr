if exists('g:loaded_greprtpscr')
  finish
endif
let g:loaded_greprtpscr = 1


command! -bar -nargs=1 -count=0 GrepRtp call greprtpscr#GrepRtp(<q-args>)
command! -bar -nargs=1 -count=0 GrepScr call greprtpscr#GrepScr(<q-args>)

" NOTE: without .vim ft filter, `:GrepRtp <query>` always produces the following line:
" || /home/jyscao/.SpaceVim/build/vader: No such file or directory (os error 2)
" TODO: figure out root cause of above error, to not be dependent on ft-filter to remove 
