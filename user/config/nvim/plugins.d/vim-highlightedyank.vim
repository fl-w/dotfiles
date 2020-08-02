" vim-highlightedyank configuration
"

" Reverse the highlight color for yanked text for better visuals
highlight HighlightedyankRegion cterm=reverse gui=reverse

" Let highlight endures longer
let g:highlightedyank_highlight_duration = 1000
