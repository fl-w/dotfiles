" add syntax highlighting to fern devicons

if !exists('g:fern_renderer_devicons_loaded') || exists('g:fern_renderer_devicons_syntax_loaded')
  finish
endif
let g:fern_renderer_devicons_syntax_loaded = 1

" colors & match borrowed from
" https://github.com/vwxyutarooo/nerdtree-devicons-syntax/blob/80b43c07c288136241715447e730bfdd817a120a/after/syntax/nerdtree.vim#L231
let s:match_colors = {
  \ '(favicon)@<!\.(jpg|jpeg|bmp|png|gif|ico)$' : 'aqua',
  \ '\.go$'                       : 'beige',
  \ '\.l?hs$'                     : 'beige',
  \ '\.json$'                     : 'beige',
  \ '(angular|jquery|backbone|require|materialize|mootools|gruntfile|gulpfile)@<!\.js$' : 'beige',
  \ '\.dart$'                     : 'blue',
  \ '\.fsscript$'                 : 'blue',
  \ '\.fs[x|i]?$'                 : 'blue',
  \ '\.css$'                      : 'blue',
  \ '\.dump$'                     : 'blue',
  \ '\.(pl|pm|t|db)$'             : 'blue',
  \ '\.(jsx|tsx?)$'               : 'blue',
  \ '\.(cpp|c\+\+|cxx|cc|cp|c)$'  : 'blue',
  \ 'dropbox'                     : 'blue',
  \ '\.coffee$'                   : 'brown',
  \ '\.f#$'                       : 'darkBlue',
  \ '\.sql$'                      : 'darkBlue',
  \ '.*\.less$'                   : 'darkBlue',
  \ '\.rss$'                      : 'darkOrange',
  \ '\.(rs|rlib)$'                : 'darkOrange',
  \ '\.ai$'                       : 'darkOrange',
  \ '\.xul$'                      : 'darkOrange',
  \ '.*\.html?$'                  : 'darkOrange',
  \ '\.clj[c|s]?$'                : 'green',
  \ '\.(edn|vue)$'                : 'green',
  \ '\.fish$'                     : 'green',
  \ '\.twig$'                     : 'green',
  \ '\.styl$'                     : 'green',
  \ 'node_modules$'               : 'green',
  \ '\.mustache$'                 : 'orange',
  \ '\.hbs$'                      : 'orange',
  \ '\.slim$'                     : 'orange',
  \ '\.hrl$'                      : 'pink',
  \ '\.vim(rc)?$'                 : 'green',
  \ '\.ps[d|b]$'                  : 'darkBlue',
  \ '(materialize)@<!\.s[a|c]ss$' : 'pink',
  \ 'gulpfile\.(coffee|js|ls)'    : 'pink',
  \ '\.jl$'                       : 'purple',
  \ '\.(sln|suo)$'                : 'purple',
  \ '\.lua$'                      : 'purple',
  \ '\.java$'                     : 'purple',
  \ '.*\.php$'                    : 'purple',
  \ 'procfile$'                   : 'purple',
  \ '\.erl$'                      : 'lightPurple',
  \ '\.sh\*?'                     : 'lightPurple',
  \ '\.scala$'                    : 'red',
  \ '\.d$'                        : 'red',
  \ '.*\.e?rb$'                   : 'red',
  \ '\.mli?$'                     : 'yellow',
  \ '\.ejs$'                      : 'yellow',
  \ '\.py[c|o|d]?$'               : 'yellow',
  \ '\.(md|markdown)$'            : 'yellow',
  \ 'favicon\.ico$'               : 'yellow',
  \ 'gruntfile\.(coffee|js|ls)$'  : 'yellow',
  \ '\.(conf|ini|yml|bat|diff)$'  : 'white',
  \ '\.ds_store$'                 : 'white',
  \ '\.(gitconfig|gitignore)$'    : 'white',
  \ '\.(bashrc|bashprofile|)$'    : 'white',
  \ 'license$'                    : 'white',
  \ '.*mootools.*\.js$'           : 'white',
  \ '.*jquery.*\.js$'             : 'blue',
  \ '.*angular.*\.js$'            : 'red',
  \ '.*backbone.*\.js$'           : 'darkBlue',
  \ '.*require.*\.js$'            : 'blue',
  \ '.*materialize.*\.(js|css)$'  : 'salmon'
\ }

let s:colors = [
  \ 'brown',
  \ 'aqua',
  \ 'blue',
  \ 'darkBlue',
  \ 'purple',
  \ 'lightPurple',
  \ 'red',
  \ 'beige',
  \ 'yellow',
  \ 'orange',
  \ 'darkOrange',
  \ 'pink',
  \ 'salmon',
  \ 'green',
  \ 'lightGreen',
  \ 'white']

let s:gui_colors = extend({
  \ 'aqua'        : "#3AFFDB",
  \ 'blue'        : "#689FB6",
  \ 'darkBlue'    : "#44788E",
  \ 'lightPurple' : "#834F79",
  \ 'beige'       : "#F5C06F",
  \ 'darkOrange'  : "#F16529",
  \ 'lightGreen'  : "#31B53E",
  \ }, get(g:, 'fern_devicons_colors', {}))

fun! s:syntax()
  call s:dsyntax()
  for [rx, col] in items(s:match_colors)
    exe printf('syn match FernLeafIcon_%s "\c\v^\s*[^ ]\ze.*%s"', col, rx)
  endfor
endf

fun! s:highlight()
  call s:dhighlight()
  for c in s:colors
    " TODO: add cterm support
    let col = get(s:gui_colors, c, c)
    exe col == '' ?
      \ printf('hi! link FernLeafIcon_%s FernLeaf', c) :
      \ printf('hi FernLeafIcon_%s guifg=%s', c, col)
  endfor
endf

fun! s:new()
  " extend devicons syntax function
  let default = fern#renderer#devicons#new()
  let s:dsyntax = default.syntax
  let s:dhighlight = default.highlight
  return extend(default, {
  \ 'highlight': funcref('s:highlight'),
  \ 'syntax': funcref('s:syntax'),
  \ })
endf

call extend(g:fern#renderers, { 'devicons': funcref('s:new') })

augroup fern_syntax_on_colorscheme
  autocmd ColorScheme * call fern#renderers.devicons().highlight()
augroup end
