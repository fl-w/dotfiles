" ale configuration
"

let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_completion_tsserver_autoimport = 1
let g:ale_set_ballons = 1
let g:ale_sign_column_always = 1
let g:ale_change_sign_column_color = 0
let g:ale_close_preview_on_insert = 1
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_python_flake8_options = '--ignore=E501'

let g:ale_fixers = {
      \ '*':          ['remove_trailing_lines', 'trim_whitespace'],
      \ 'javascript': ['prettier', 'eslint'],
      \ 'css':        ['prettier'],
      \ 'c':          ['clang-format'],
      \ 'json':       ['fixjson'],
      \ 'haskell':    ['brittany'],
      \ 'java':       ['google_java_format'],
      \ 'typescript': ['eslint'],
      \ 'python':     ['black', 'isort', 'add_blank_lines_for_python_control_statements']
      \}
let g:ale_linters = {
      \ 'python':     ['pylint', 'flake8'],
      \ 'c':          ['clang-tidy'],
      \ 'java':       ['checkstyle'],
      \ 'rust':       ['clippy']
      \}

" vim: sw=2 sts=2 tw=0 fdm=marker
