autocmd! ColorScheme badwolf hi DiffAdd guifg=#B8CC52
            \| hi DiffChange guifg=#36A3D9
            \| hi Normal guifg=#e4e0ed
            \| call utils#color#copy_hi_group('SpecialChar', 'SpecialComment')
            \| hi SpecialComment gui=bold
            \| hi String ctermfg=140 guifg=#a790d5 gui=italic
