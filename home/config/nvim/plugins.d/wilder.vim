call wilder#set_option('modes', [':', '/', '?'])

call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#cmdline_pipeline(),
      \     wilder#search_pipeline(),
      \   ),
      \ ])

call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ 'left': [
      \   wilder#popupmenu_devicons(),
      \ ],
      \ }))
