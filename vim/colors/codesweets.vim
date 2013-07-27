
" Vim color file -- codesweets
" Maintainer:   eri! 451 van Buffellow <hans.orter@gmx.de>
" Last Change:  2013 Jan 23

set background=dark
highlight clear
let g:colors_name="codesweets"

"
" basic highlight groups (:help highlight-groups) {{{

" text {{{

hi Normal        ctermfg=white       ctermbg=black       cterm=NONE
            \    guifg=white         guibg=black         gui=NONE
hi Folded        ctermfg=lightgray   ctermbg=black       cterm=NONE
            \    guifg=#c0c0c0       guibg=black         gui=NONE
hi LineNr        ctermfg=246         ctermbg=NONE        cterm=NONE
            \    guifg=#949494       guibg=NONE          gui=NONE
hi Directory     ctermfg=cyan        ctermbg=NONE        cterm=NONE
            \    guifg=cyan          guibg=NONE          gui=NONE
hi NonText       ctermfg=blue        ctermbg=NONE        cterm=NONE
            \    guifg=blue          guibg=NONE          gui=NONE
hi SpecialKey    ctermfg=darkgray    ctermbg=NONE        cterm=NONE
            \    guifg=#808080       guibg=NONE          gui=NONE

hi SpellBad      ctermfg=white       ctermbg=darkred     cterm=NONE
            \    guifg=#ffffff       guibg=#800000       gui=NONE
hi SpellCap      ctermfg=white       ctermbg=darkblue    cterm=NONE
            \    guifg=#ffffff       guibg=#000080       gui=NONE
hi SpellLocal    ctermfg=black       ctermbg=cyan        cterm=NONE
            \    guifg=#000000       guibg=#00ffff       gui=NONE
hi SpellRare     ctermfg=white       ctermbg=darkmagenta cterm=NONE
            \    guifg=#000000       guibg=#800080       gui=NONE

hi DiffAdd       ctermfg=white       ctermbg=darkblue    cterm=NONE
            \    guifg=#ffffff       guibg=#000080       gui=NONE
hi DiffChange    ctermfg=black       ctermbg=darkmagenta cterm=NONE
            \    guifg=#000000       guibg=#800080       gui=NONE
hi DiffDelete    ctermfg=black       ctermbg=red         cterm=bold
            \    guifg=#000000       guibg=#ff0000       gui=NONE
hi DiffText      ctermfg=white       ctermbg=green       cterm=bold
            \    guifg=#ffffff       guibg=#00ff00       gui=bold

" }}}
" borders / separators / menus {{{

hi FoldColumn    ctermfg=lightgray   ctermbg=darkgray    cterm=NONE
            \    guifg=#c0c0c0       guibg=#808080       gui=NONE
hi SignColumn    ctermfg=lightgray   ctermbg=darkgray    cterm=NONE
            \    guifg=#c0c0c0       guibg=#808080       gui=NONE

hi Pmenu         ctermfg=white       ctermbg=236         cterm=NONE
            \    guifg=#ffffff       guibg=#303030       gui=NONE
hi PmenuSel      ctermfg=white       ctermbg=24          cterm=NONE
            \    guifg=#ffffff       guibg=#005f87       cterm=NONE
hi PmenuSbar     ctermfg=black       ctermbg=236         cterm=NONE
            \    guifg=#000000       guibg=#303030       gui=NONE
hi PmenuThumb    ctermfg=gray        ctermbg=gray        cterm=NONE
            \    guifg=#808080       guibg=#808080       gui=NONE

hi StatusLine    ctermfg=white       ctermbg=238         cterm=NONE
            \    guifg=#ffffff       guibg=#444444       gui=NONE
hi StatusLineNC  ctermfg=white       ctermbg=darkgray    cterm=NONE
            \    guifg=#c0c0c0       guibg=#808080       gui=NONE
hi WildMenu      ctermfg=22          ctermbg=154         cterm=bold
            \    guifg=#005f00       guibg=#afff00       gui=bold
hi VertSplit     ctermfg=238         ctermbg=238         cterm=NONE
            \    guifg=#444444       guibg=#444444       gui=NONE

hi TabLine       ctermfg=253         ctermbg=8           cterm=NONE
            \    guifg=#dadada       guibg=#808080       gui=NONE
hi TabLineFill   ctermfg=black       ctermbg=236         cterm=NONE
            \    guifg=#000000       guibg=#303030       gui=NONE
hi TabLineSel    ctermfg=white       ctermbg=black       cterm=NONE
            \    guifg=#ffffff       guibg=#000000       gui=NONE

" }}}
" cursor / dynamic / other {{{

hi ColorColumn   ctermfg=NONE        ctermbg=52          cterm=bold
            \    guifg=NONE          guibg=#5f0000       gui=bold
hi CursorColumn  ctermfg=NONE        ctermbg=16          cterm=NONE
            \    guifg=NONE          guibg=#000000       gui=NONE
hi Cursor        ctermfg=black       ctermbg=white       cterm=NONE
            \    guifg=#000000       guibg=#ffffff       gui=NONE
hi CursorIM      ctermfg=black       ctermbg=white       cterm=reverse
            \    guifg=#000000       guifg=#ffffff       gui=reverse

hi CursorLine    ctermfg=NONE        ctermbg=233         cterm=NONE
            \    guifg=NONE          guibg=#121212       gui=NONE
hi CursorLineNr  ctermfg=154         ctermbg=238         cterm=bold
            \    guifg=#afff00       guibg=#444444       gui=bold

hi Visual        ctermfg=NONE        ctermbg=235         cterm=bold
            \    guifg=NONE          guibg=#302726       gui=NONE
hi IncSearch     ctermfg=white       ctermbg=yellow      cterm=NONE
            \    guifg=#ffffff       guibg=#ffff00       gui=NONE
hi Search        ctermfg=white       ctermbg=64          cterm=NONE
            \    guifg=#ffffff        guibg=#5f8700       gui=NONE

hi MatchParen    ctermfg=231         ctermbg=24          cterm=NONE
            \    guifg=#ffffff       guibg=#005f87       gui=NONE

"hi VisualNOS

" }}}
" listings / messages {{{

hi ModeMsg       ctermfg=white       ctermbg=NONE        cterm=NONE
            \    guifg=#ffffff       guibg=NONE          gui=NONE
hi Title         ctermfg=red         ctermbg=NONE        cterm=bold
            \    guifg=#800000       guibg=NONE          gui=bold
hi Question      ctermfg=green       ctermbg=NONE        cterm=NONE
            \    guifg=#00ff00       guibg=NONE          gui=NONE
hi MoreMsg       ctermfg=green       ctermbg=NONE        cterm=NONE
            \    guifg=#00ff00       guibg=NONE          gui=NONE

hi ErrorMsg      ctermfg=white       ctermbg=red         cterm=bold
            \    guifg=#ffffff       guibg=#800000       gui=bold
hi WarningMsg    ctermfg=yellow      ctermbg=NONE        cterm=bold
            \    guifg=#ffff00       guibg=NONE          gui=NONE

" }}}

" }}}
" syntax highlighting groups (:help group-name) {{{

hi Boolean       ctermfg=red         ctermbg=NONE        cterm=bold
            \    guifg=#800000       guibg=NONE          gui=bold

hi Comment       ctermfg=gray        ctermbg=NONE        cterm=NONE
            \    guifg=#c0c0c0       guibg=NONE          gui=NONE

hi Constant      ctermfg=red         ctermbg=NONE        cterm=NONE
            \    guifg=#800000       guibg=NONE          gui=NONE

hi Error         ctermfg=white       ctermbg=red         cterm=NONE
            \    guifg=#ffffff       guibg=#800000       gui=NONE

hi Function      ctermfg=yellow      ctermbg=NONE        cterm=NONE
            \    guifg=#ffff00       guibg=NONE          gui=NONE

hi Identifier    ctermfg=white       ctermbg=NONE        cterm=NONE
            \    guifg=#ffffff       guibg=NONE          gui=NONE

hi Ignore        ctermfg=darkgray    ctermbg=NONE        cterm=NONE
            \    guifg=#808080       guibg=NONE          gui=NONE

hi Number        ctermfg=magenta     ctermbg=NONE        cterm=NONE
            \    guifg=#ff00ff       guibg=NONE          gui=NONE

hi Operator      ctermfg=87          ctermbg=NONE        cterm=NONE
            \    guifg=#5fffff       guibg=NONE          gui=NONE

hi PreProc       ctermfg=darkmagenta ctermbg=NONE        cterm=NONE
            \    guifg=#800080       guibg=NONE          gui=NONE

hi Special       ctermfg=lightgray   ctermbg=NONE        cterm=bold
            \    guifg=#c0c0c0       guibg=NONE          gui=bold

hi SpecialChar   ctermfg=magenta     ctermbg=NONE        cterm=NONE
            \    guifg=#ff00ff       guibg=NONE          gui=NONE

hi Statement     ctermfg=75          ctermbg=NONE        cterm=bold
            \    guifg=#5fafff       guibg=NONE          gui=bold

hi Todo          ctermfg=black       ctermbg=yellow      cterm=bold
            \    guifg=#000000       guibg=#ffff00       gui=bold

hi Type          ctermfg=green       ctermbg=NONE        cterm=NONE
            \    guifg=#00ff00       guibg=NONE          gui=NONE

hi Underlined    ctermfg=NONE        ctermbg=NONE        cterm=underline
            \    guifg=NONE          guibg=NONE          gui=underline

" }}}

" vim: fdm=marker fdl=0
