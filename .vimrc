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
"set statusline=%1*%F%m%r%h%w\ [%{&ff}]%=%(%c%V\ %l/%L\ %P%)

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

" For full syntax highlighting by vim-flake8 plugin:
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
set expandtab

" indent/outdent by four columns
set shiftwidth=4

" <BS> will delete a 'shiftwidth' worth of space
set smarttab

" indent/outdent to nearest tabstops
set shiftround


" ----------------------------------------------------------------------------
" HTML, CSS, Javascript file standards

au BufNewFile,BufRead *.js, *.html, *.htm, *.css
    \ set tabstop=2  " Number of spaces that tab is equal to.
    \ set softtabstop=2
    \ set shiftwidth=2
    \ set expandtab  " replace <TAB> with spaces

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
au BufRead,BufNewFile *py,*pyw,*.c,*.h,*.java,*.xml set tabstop=4

" What to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
" Python: 4 spaces
" C: tabs (pre-existing files) or 4 spaces (new files)
au BufRead,BufNewFile *.py,*pyw,*.java,*.xml set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw,*.java,*.xml set expandtab
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
au BufRead,BufNewFile *.py,*.pyw,*.java,*.xml match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.java,*.xml match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
" Python: 119
" C: 119
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h set textwidth=119

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
" Vundle, the plug-in manager for Vim http://github.com/VundleVim/Vundle.Vim
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" https://powerline.readthedocs.io/en/latest/
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" ----------------------------------------------------------------------------
" Key Mapping
"
" Split navigations, key combos:
"  * Ctrl-j move to the split below
"  * Ctrl-k move to the split above
"  * Ctrl-l move to the split to the right
"  * Ctrl-h move to the split to the left
"
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
