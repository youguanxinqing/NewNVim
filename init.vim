let mapleader = ";"      " 定义<leader>键

filetype on              " 设置开启文件类型侦测
filetype plugin on       " 设置加载对应文件类型的插件
set t_Co=256             " 开启256色支持
set nu
set cursorline           " 高亮当前行号
set ignorecase           " 忽略大小写
set incsearch            " 实时搜索
set tabstop=4
" set expandtab
" set softtabstop=4
set shiftwidth=4         " 缩进宽度
" set autoindent
" set smartindent
set scrolloff=10         " 至少保证 10 行
set ttimeoutlen=0        " 设置<ESC>键响应时间
set confirm              " 在处理未保存或只读文件的时候，弹出确认
set colorcolumn=81       " 提示线
syntax enable            " 语法检测

" 重新加载vimrc文件
nnoremap <leader>ss :source $MYVIMRC<CR>
" 编辑vimrc文件
nnoremap <leader>se :edit $MYVIMRC<cr>
" 一键运行 python 代码
nnoremap <leader>r :w<cr>:!python3 %<cr>
" 括号配对
" inoremap ( ()<ESC>i
" inoremap [ []<ESC>i
" inoremap { {}<ESC>i
" inoremap < <><ESC>i
" inoremap ' ''<ESC>i
" inoremap \" \""<ESC>i
" 粘贴
set pastetoggle=<F3>

" 插件管理
call plug#begin('~/.config/nvim/plugged')

Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/w0ng/vim-hybrid.git'
Plug 'https://github.com/itchyny/vim-cursorword.git'
" 安装 ctags: yum install -y ctags
Plug 'https://github.com/majutsushi/tagbar.git', {'on': 'TagbarToggle'}
Plug 'https://github.com/Yggdroot/indentLine.git'
Plug 'https://github.com/Shougo/defx.nvim.git', { 'do': ':UpdateRemotePlugins' }
Plug 'https://github.com/Yggdroot/LeaderF.git', { 'do': './install.sh', 'on': ['Leaderf']}
" 安装 python: CocInstall coc-python
Plug 'https://github.com/neoclide/coc.nvim.git', { 'branch': 'release' }
Plug 'https://github.com/lfv89/vim-interestingwords.git'
Plug 'https://github.com/fatih/vim-go.git', { 'do': ':GoUpdateBinaries' }

" Plug 'https://github.com/python-mode/python-mode.git', { 'for': 'python', 'branch': 'develop' }
" Plug 'https://github.com/ycm-core/YouCompleteMe.git', { 'do': './install.py' }

call plug#end()

" theme 设置 ***********************
colorscheme hybrid
set background=dark


" leaderf 设置 *********************
" nnoremap <leaderf>s :LeaderfFunctionAll<cr>


" defx 设置  ***********************
" 使用 ;e 切换显示文件浏览，使用 ;a 查找到当前文件位置
let g:maplocalleader=';'
nnoremap <silent> <LocalLeader>e
	\ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()`<CR>
nnoremap <silent> <LocalLeader>a
	\ :<C-u>Defx -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')`<CR>

function! s:defx_mappings() abort
	" Defx window keyboard mappings
	setlocal signcolumn=no
	" 使用回车打开文件
	nnoremap <silent><buffer><expr> <CR> defx#do_action('multi', ['drop'])
	" 到上级目录
	nnoremap <silent><buffer><expr> h
	 	  \ defx#do_action('cd', ['..'])
	" 到下级目录，如果是文件就打开
	nnoremap <silent><buffer><expr> l
		  \ defx#do_action('multi', ['drop'])
	nnoremap <silent><buffer><expr> j
		  \ line('.') == line('$') ? 'gg' : 'j'
	nnoremap <silent><buffer><expr> k
		  \ line('.') == 1 ? 'G' : 'k'
	" 列前显示 + 
	nnoremap <silent><buffer><expr> C
	 	  \ defx#do_action('toggle_columns',
	 	  \                'mark:indent:icon:filename:type:size:time')
	" 打开或是关闭文件树
	nnoremap <silent><buffer><expr> o
	 	  \ defx#do_action('open_or_close_tree')
	" 新建文件
	nnoremap <silent><buffer><expr> N
	 	  \ defx#do_action('new_file')
	" 新建目录
	nnoremap <silent><buffer><expr> K
	 	  \ defx#do_action('new_directory')
	" 退出
	nnoremap <silent><buffer><expr> q
		  \ defx#do_action('quit')
	" 文件重命名
	nnoremap <silent><buffer><expr> r
		  \ defx#do_action('rename')
	" 剪切
	nnoremap <silent><buffer><expr> m
		  \ defx#do_action('move')
	" 粘贴
	nnoremap <silent><buffer><expr> p
		  \ defx#do_action('paste')
	nnoremap <silent><buffer><expr> d
		  \ defx#do_action('remove')
	" 打开或是关闭忽略文件
	nnoremap <silent><buffer><expr> .
		  \ defx#do_action('toggle_ignored_files')
	" 
	nnoremap <silent><buffer><expr> <C-l>
		  \ defx#do_action('redraw')
endfunction

call defx#custom#option('_', {
	\ 'columns': 'indent:git:icons:filename',
	\ 'winwidth': 25,
	\ 'split': 'vertical',
	\ 'direction': 'topleft',
	\ 'listed': 1,
	\ 'show_ignored_files': 0,
	\ 'root_marker': '≡ ',
	\ 'ignored_files':
	\     '.mypy_cache,.pytest_cache,.git,.hg,.svn,.stversions'
	\   . ',__pycache__,.sass-cache,*.egg-info,.DS_Store,*.pyc,*.swp'
	\ })

autocmd FileType defx call s:defx_mappings()

" coc.vim ************************
" 用 tab 选择提示(暂时不能正常使用)
" inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" inoremap <silent><expr> <c-space> coc#refresh()
" 单词重命名
" nmap <leader>rn <Plug>(coc-rename) 


" tagbar ***************************
" 打开或是关闭 taglist
nnoremap <leader>t :TagbarToggle<CR>
let g:tagbar_width = 28

inoremap jj <Esc>
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
" 关掉上一次搜索高亮
noremap <silent><leader>/ :nohls<CR>  


" 代码折叠自定义快捷键 <leader>zz
" let g:FoldMethod = 0
" map <leader>zz :call ToggleFold()<cr>
" fun! ToggleFold()
"     if g:FoldMethod == 0
"         exe "normal! zM"
"         let g:FoldMethod = 1
"     else
"         exe "normal! zR"
"         let g:FoldMethod = 0
"     endif
" endfun
"

" vim-go
let g:go_disable_autoinstall = 0
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_structs = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_build_constraints = 1

" python-mode 
" let g:pymode_run = 1
" let g:pymode_run_bind = '<leader>r'  " 一键运行

" let g:pymode_breakpoint = 1
" let g:pymode_breakpoint_bind = '<leader>b'

" 记住上一次退出位置
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" 保存后自动执行 import package
autocmd BufWritePost  *.go exec ":GoImports"

