" An example for a vimrc file.

"---------------------------------------------User Configuration Start-----------------------------------
" Naviagations using keys up/down/left/right
" Disabling default keys to learn the hjkl
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop> "inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
"nnoremap j gj
"nnoremap k gk

"help document language is chinese
"set helplang=cn
"set encoding=utf-8

"��Ӳ˵����͹�����
:set guioptions+=m
:set guioptions+=t

"chinese menu occurs
"set encoding=gb2312
map <F5> i{<Esc>ea}<Esc>
" ���ö����Ի���,���������������
if has("multi_byte") 
    " UTF-8 ���� 
    set encoding=utf-8 
    set termencoding=utf-8 
    set formatoptions+=mM 
    set fencs=utf-8,gbk 
    if v:lang =~? '^/(zh/)/|/(ja/)/|/(ko/)' 
        set ambiwidth=double 
    endif 
    if has("win32") 
        source $VIMRUNTIME/delmenu.vim 
        source $VIMRUNTIME/menu.vim 
        language messages zh_CN.utf-8 
    endif 
else 
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte" 
endif

"����ԭʼ���ļ��汾
"set patchmode=.orig

"��������ģʽ
colorscheme freya 
"�����﷨����
syntax enable 
syntax on
"��ʾ�к�
set nu! 
"�����ڱ༭���������½���ʾ����������Ϣ
set ruler 

"initial configuration
autocmd FileType text setlocal textwidth=78  "�Զ�����
set number "show row number"
set history=100
set autoindent  "����һ��ʱʩ����һ�е�����
set smartindent
set showcmd		" display incomplete commands
set tabstop=4  "tab space numbers"
set softtabstop=4 "soft tab"
set shiftwidth=4 "shift space numbers"
set guioptions=t
set incsearch
set ignorecase
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set cindent "c/c++ cin dent

"����C/C++��ʽ�Զ�����
set autoindent
set cindent
"����ƥ��ģʽ ���Ƶ�����һ��������ʱ��ƥ����Ӧ���Ǹ�������
set showmatch
"������Բ�ͬ�ļ����͵���Ӧplugin��Ӧ��
filetype plugin indent on  
"����ļ�����
filetype on
"��Բ�ͬ���ļ����ò�ͬ��������ʽ
filetype indent on

"��������ת
set tags=tags; 
set autochdir

"taglist���Դ��
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
"map T :TaskList<CR>

"winmanager �ļ�������ʹ��ڹ�����
let g:winManagerWindowLayout='FileExplorer' "|TagList' 
nmap wm :WMToggle<cr>

"miniBufExplorer��������Ͳ���buffer
let g:miniBufExplMapCTabSwitchBufs=1 
let g:miniBufExplMapWindowsNavVim=1 
let g:miniBufExplMapWindowNavArrows=1

"h\c�л� ���c��c++�ļ�
nnoremap <silent> <F12> :A<CR> 

"�ڹ����п��ٲ���grep
nnoremap <silent> <F3> :Grep<CR> 

"-------------------------------Basic Editing and Debugging Start------------------------------------
"Code Folding
set foldmethod=indent
set foldlevel=99

"Windows SPlits
map <c-j> <c-w>j map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
"-------------------------------Basic Editing and Debugging Start------------------------------------

"-------------------------------Vundle�������-------------------------------------------------------
"����Vundle
"set nocompatible " be iMproved
"filetype off " required!
"set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()

"Bundle 'L9'
"Bundle 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'
"�ļ����ͼ��
"filetype plugin indent on
"-------------------------------Vundle�������-------------------------------------------------------

"-------------------------------C IDE Setting Start--------------------------------------------------
let  g:C_UseTool_cmake    = 'yes' 
let  g:C_UseTool_doxygen = 'yes' 
"-------------------------------C IDE Setting End--------------------------------------------------

"-------------------------------Python IDE Setting Start---------------------------------------------
"Python���벹ȫ
filetype plugin on  "����ʹ�ò��
let g:pydiction_location = 'c:\Program Files (x86)\Vim\vimfiles\ftplugin\pydiction\complete-dict' 
let g:pydiction_menu_height = 20 "���õ����˵��ĸ߶ȣ�Ĭ����15

"Python����
python << EOF
import time
import vim
def SetBreakpoint():
    nLine = int( vim.eval( 'line(".")'))
    strLine = vim.current.line
    i = 0
    strWhite = ""
    while strLine[i] == ' ' or strLine[i] == "\t":
        i += 1
        strWhite += strLine[i]
    vim.current.buffer.append(
       "%(space)spdb.set_trace() %(mark)s Breakpoint %(mark)s" %
         {'space':strWhite, 'mark': '#' * 30}, nLine - 1)
    for strLine in vim.current.buffer:
        if strLine == "import pdb":
            break
        else:
            vim.current.buffer.append( 'import pdb', 0)
            vim.command( 'normal j1')
            break
vim.command( 'map <C-M> :py SetBreakpoint()<cr>')
 
def RemoveBreakpoints():
    nCurrentLine = int( vim.eval( 'line(".")'))
    nLines = []
    nLine = 1
    for strLine in vim.current.buffer:
        if strLine == 'import pdb' or strLine.lstrip()[:15] == 'pdb.set_trace()':
            nLines.append( nLine)
        nLine += 1
    nLines.reverse()
    for nLine in nLines:
        vim.command( 'normal %dG' % nLine)
        vim.command( 'normal dd')
        if nLine < nCurrentLine:
            nCurrentLine -= 1
    vim.command( 'normal %dG' % nCurrentLine)
vim.command( 'map <C-N> :py RemoveBreakpoints()<cr>')
vim.command( 'map <C-R> :!python %<cr>')
EOF
"-------------------------------Python IDE Setting Start---------------------------------------------
"---------------------------------------------User Configuration End-----------------------------------

"---------------------ԭ�е��ļ��Ӵ˿�ʼ������---------------------------
set nocompatible "�ر�vi��һ����ģʽ ������ǰ�汾��һЩBug�;��ޡ�
source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
