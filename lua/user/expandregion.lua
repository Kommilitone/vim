vim.cmd([[
let g:expand_region_text_objects = {
      \'i>': 1,
      \'i<': 1,
      \'a>': 1,
      \'a<': 1,
      \'i]': 1,
      \'ib': 1,
      \'iB': 1,
      \'a]': 1,
      \'aB': 1,
      \'ab': 1,
      \'i"': 0,
      \'i''': 0,
      \'a"': 0,
      \'a''': 0
      \ } 

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
]])
