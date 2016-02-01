" This is the personal .vimrc file of Richard Kellner.
" While much of it is beneficial for general use, I would recommend picking 
" out the parts you want and understand.

" ----------------------------------------------------------------------------
" General standards
"
" This standards are used in all files opened in vim as I think of them as a
" good practice, or as a standard for all files


" Set the default file encoding to UTF-8:
scriptencoding utf-8
set encoding=utf-8
set termencoding=utf-8

" Always check for UTF-8 when trying to determine encodings.
if &fileencodings !~? "utf-8"
    set fileencodings+=utf-8
endif

" Make sure we have a sane fallback for encoding detection
set fileencodings+=default

" Use Vim defaults stops vim from behaving in a strongly vi -compatible way
set nocompatible

" Allow backspacing over everything in insert mode
set bs=2

" Extend history (default is 20)
set history=500

" spell checking on
"set spell

" auto read when file is changed from outside
set autoread

" Automatically enable mouse usage
"set mouse=a

" Show the line number on the bar
set ruler

" search highlighting
set hlsearch

" ignore case when searching
"set ignorecase

" disable sound on errors
set noerrorbells
set novisualbell

" Always display a status line at the bottom of the window
set laststatus=2

" Set status line
"set statusline=%1*%F%m%r%h%w%=%(%c%V\ %l/%L\ %P%)
set statusline=%1*%F%m%r%h%w\ [%{&ff}]%=%(%c%V\ %l/%L\ %P%)

" Keep a .viminfo file.
set viminfo='20,\"500

" When doing tab completion, give the following files lower priority. You may
" wish to set 'wildignore' to completely ignore files, and 'wildmenu' to 
" enable enhanced tab completion. These can be done in the user vimrc file.
set suffixes+=.info,.aux,.log,.dvi,.bbl,.out,.o,.lo,.pyc

" ----------------------------------------------------------------------------
" Programing standards
"
" This section is for programming in general doesnt matter what kind of 
" language, because this is useful in all of them and is not harming standards

" For full syntax highlighting:
let python_highlight_all=1
syntax on

" Automatically indent based on file type: 
filetype indent on

" Keep indentation level from previous line: 
set autoindent

" Try to be smart about indentation:
set smartindent

" Folding based on indentation: 
set foldmethod=indent
set foldlevel=99

" Show the line numbers on each line
"set number

" indentation levels every four columns
set tabstop=4
set softtabstop=4

" convert all tabs to space
"set expandtab

" indent/outdent by four columns
set shiftwidth=4

" <BS> will delete a 'shiftwidth' worth of space
set smarttab

" indent/outdent to nearest tabstops
set shiftround


" ----------------------------------------------------------------------------
" HTML, CSS, Javascript file standards

" Number of spaces that tab is equal to.
au BufRead,BufNewFile *.html,*.htm,*.css,*.js set tabstop=2
au BufRead,BufNewFile *.html,*.htm,*.css,*.js set shiftwidth=2
" replace <TAB> with spaces
au BufRead,BufNewFile *.html,*.htm,*.css,*.js set expandtab

" ----------------------------------------------------------------------------
" Coding standards specified in PEP 7 & 8.
"
" To use this file, source it in your own personal .vimrc file (``source
" <filename>``) or, if you don't have a .vimrc file, you can just symlink to it
" (``ln -s <this file> ~/.vimrc``).  All options are protected by autocmds
" (read below for an explanation of the command) so blind sourcing of this file
" is safe and will not affect your settings for non-Python or non-C files.
"
"
" All setting are protected by 'au' ('autocmd') statements.  Only files ending
" in .py or .pyw will trigger the Python settings while files ending in *.c or
" *.h will trigger the C settings.  This makes the file "safe" in terms of only
" adjusting settings for Python and C files.
"
" Only basic settings needed to enforce the style guidelines are set.

" Number of spaces that a pre-existing tab is equal to.
" For the amount of space used for a new tab use shiftwidth.
au BufRead,BufNewFile *py,*pyw,*.c,*.h,*.java set tabstop=4

" What to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
" Python: 4 spaces
" C: tabs (pre-existing files) or 4 spaces (new files)
au BufRead,BufNewFile *.py,*pyw,*.java  set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw,*.java set expandtab
fu Select_c_style()
    if search('^\t', 'n', 150)
        set shiftwidth=8
        set noexpandtab
    el 
        set shiftwidth=4
        set expandtab
    en
endf
au BufRead,BufNewFile *.c,*.h call Select_c_style()
au BufRead,BufNewFile Makefile* set noexpandtab

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw,*.java match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.java match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
" Python: 79 
" C: 79
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h set textwidth=79

" Turn off settings in 'formatoptions' relating to comment formatting.
" - c : do not automatically insert the comment leader when wrapping based on
"    'textwidth'
" - o : do not insert the comment leader when using 'o' or 'O' from command mode
" - r : do not insert the comment leader when hitting <Enter> in insert mode
" Python: not needed
" C: prevents insertion of '*' at the beginning of every line in a comment
au BufRead,BufNewFile *.c,*.h set formatoptions-=c formatoptions-=o formatoptions-=r

" Use UNIX (\n) line endings.
" Only used for new files so as to not force existing files to change their
" line endings.
" Python: yes
" C: yes
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

" ----------------------------------------------------------------------------
" Plugins
"
" run pathogen (more in https://github.com/tpope/vim-pathogen)
filetype off
execute pathogen#infect()
call pathogen#helptags()

"call pathogen#infect()

" Enable filetype detection
filetype on

" Enable filetype-specific plugins
filetype plugin on

" vim-gitgutter The colours in the sign column are weird.
highlight clear SignColumn
" ----------------------------------------------------------------------------
" Plugins Mapping
"
" Fix Tasklist mapping so it is not in conflict with other plugins
map <leader>td <Plug>TaskList

" Need to comment better!!!!!!
"
map <leader>g :GundoToggle<CR>

let g:pyflakes_use_quickfix = 0
let g:pep8_map='<leader>8'

au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"

set completeopt=menuone,longest,preview

map <leader>n :NERDTreeToggle<CR>

map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

nmap <leader>a <Esc>:Ack!


" %{fugitive#statusline()}

map <leader>dt :set makeprg=python\ manage.py\ test\|:call MakeGreen()<CR>

" Execute the tests
nmap <silent><Leader>tf <Esc>:Pytest file<CR>
nmap <silent><Leader>tc <Esc>:Pytest class<CR>
nmap <silent><Leader>tm <Esc>:Pytest method<CR>
" cycle through test errors
nmap <silent><Leader>tn <Esc>:Pytest next<CR>
nmap <silent><Leader>tp <Esc>:Pytest previous<CR>
nmap <silent><Leader>te <Esc>:Pytest error<CR>
" Navigation between windows
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
