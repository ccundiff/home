execute pathogen#infect()
filetype plugin indent on
filetype plugin on
syntax enable
set background=dark
colorscheme solarized
set expandtab
set smarttab
set shiftwidth=2
set autoindent
set smartindent
set hlsearch
set ignorecase
set smartcase
set incsearch
set laststatus=2

let g:jsx_ext_required = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'powerlineish'
" let g:airline_section_a = airline#section#create(['mode',' ','branch'])
" let g:airline_section_b = airline#section#create_left(['ffenc','hunks','%f'])
" let g:airline_section_c = airline#section#create(['filetype'])
" let g:airline_section_x = airline#section#create(['%P'])
" let g:airline_section_y = airline#section#create(['%B'])
" let g:airline_section_z = airline#section#create_right(['%l','%c'])


