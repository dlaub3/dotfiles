set conceallevel=1

syntax keyword typescriptPredefinedType any conceal cchar=💩

"syntax keyword Foo foo bar conceal cchar=💩
"syntax keyword Foo foo bar conceal cchar=💩

"hi! Foo guibg=Purple guifg=Yellow

"hi! link Foo Type

"syntax keyword typescriptPredefinedType number boolean string void never undefined null object unknown
  "\ nextgroup=@typescriptTypeOperator
  "\ contained skipwhite skipempty
