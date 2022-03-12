source ~/.config/nvim/plug-config/coc.vim

:set number
:set autoindent
:set tabstop=2
:set shiftwidth=2
:set smarttab
:set softtabstop=2
:set mouse=a
:set clipboard=unnamed,unnamedplus
:set cursorline
:set completeopt
:set splitbelow splitright
:set title
:set expandtab
:set termguicolors
:set shortmess+=A

set background=dark
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 2
let g:airline_powerline_fonts = 1
let g:indentLine_enabled=1

call plug#begin('~/.vim/plugged')

" Appearance
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'https://github.com/xiyaowong/nvim-transparent'
Plug 'https://github.com/karb94/neoscroll.nvim'
Plug 'https://github.com/preservim/tagbar'
Plug 'https://github.com/preservim/nerdtree'
Plug 'akinsho/bufferline.nvim'

" Themes
Plug 'jacoborus/tender.vim'
Plug 'https://github.com/morhetz/gruvbox'
Plug 'https://github.com/iCyMind/NeoSolarized'
Plug 'mangeshrex/everblush.vim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'arcticicestudio/nord-vim'

" Utilities
Plug 'https://github.com/christoomey/vim-tmux-navigator'
Plug 'https://github.com/nvim-lua/popup.nvim'
Plug 'https://github.com/xolox/vim-misc'

" Dashboard
Plug 'https://github.com/glepnir/dashboard-nvim'

" Dev
Plug 'https://github.com/othree/html5.vim'
Plug 'https://github.com/ervandew/supertab'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/ap/vim-css-color'
Plug 'https://github.com/mg979/vim-visual-multi'
Plug 'https://github.com/godlygeek/tabular'
Plug 'https://github.com/jiangmiao/auto-pairs'
Plug 'https://github.com/ntpeters/vim-better-whitespace'
Plug 'https://github.com/kien/rainbow_parentheses.vim'
Plug 'https://github.com/lukas-reineke/indent-blankline.nvim'
Plug 'https://github.com/neoclide/coc.nvim'
Plug 'editorconfig/editorconfig-vim'

" Notes
Plug 'https://github.com/xolox/vim-notes'

" Live server
Plug 'https://github.com/turbio/bracey.vim', {'do': 'npm install --prefix server'}

" Telescope
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Git
Plug 'https://github.com/airblade/vim-gitgutter'

" Lazygit
Plug 'https://github.com/kdheepak/lazygit.nvim'

call plug#end()

syntax enable
set winblend=0
set wildoptions=pum
set pumblend=5
" let g:neosolarized_termtrans=1
" let g:tokyonight_transparent=1
colorscheme nord
let g:airline_theme='nord'
" let g:lightline = {'colorscheme': 'tokyonight'}

set encoding=UTF-8
let g:transparent_enabled = v:true

"--- Key Bindings ---
"nerdtree
nnoremap <C-t> :NERDTreeToggle<CR>

"Tagbar
nmap <F8> :TagbarToggle<CR>

"Prettier
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

"Gruvbox theme
"autocmd VimEnter * ++nested colorscheme gruvbox
let g:airline_extensions = ['branch']
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#excmide_buffers = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_section_z=''

let NERDTreeShowHidden=1

let g:better_whitespace_filetypes_blacklist=['diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'fugitive', 'dashboard']

" Lazygit
let g:lazygit_floating_window_winblend = 0 " transparency of floating window
let g:lazygit_floating_window_scaling_factor = 0.9 " scaling factor for floating window
let g:lazygit_floating_window_corner_chars = ['╭', '╮', '╰', '╯'] " customize lazygit popup window corner characters
let g:lazygit_floating_window_use_plenary = 0 " use plenary.nvim to manage floating window if available
let g:lazygit_use_neovim_remote = 1 " fallback to 0 if neovim-remote is not installed

" Find files using Telescope command-line sugar.
" <leader> = \
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap ; :lua require'telescope.builtin'.buffers{}<cr>

" Launch CMD at start
autocmd VimEnter * GitGutterSignsEnable

" Keybinds
" Deplacer Ligne
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Basic
nnoremap <C-q> :q!<CR>
nnoremap <C-s> :w<CR>
nnoremap <F4> :bd<CR>
nnoremap <F6> :sp<CR>:terminal<CR>

" Tabs
nnoremap <S-Tab> gT
nnoremap <Tab> gt
nnoremap <silent> <S-t> :tabnew<CR>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Emmet
let g:user_emmet_leader_key='<C-y>'

" Dashboard
let g:dashboard_default_executive ='telescope'

" Tab activated by default
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_blankline_buftype_exclude = ['dashboard']
let g:indent_blankline_filetype_exclude = ['dashboard', 'NERDTree']
" let g:indent_blankline_context_patterns = [ 'class', 'return', 'function', 'method', '^if', '^while', 'jsx_element', '^for', '^object', '^table', 'block',
"    'arguments', 'if_statement', 'else_clause', 'jsx_element', 'jsx_self_closing_element', 'try_statement',
"    'catch_clause', 'import_statement', 'operation_type' ]


lua << EOF
vim.opt.list = true
vim.opt.listchars:append("eol:↴")

vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#5E81AC gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#81A1C1 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#88C0D0 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#8FBCBB gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
    space_char_blankline = " ",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
 --       "IndentBlanklineIndent5",
--        "IndentBlanklineIndent6",
    },
}


require('neoscroll').setup({
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
                '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
    hide_cursor = true,          -- Hide cursor while scrolling
    stop_eof = true,             -- Stop at <EOF> when scrolling downwards
    use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
    respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = nil,       -- Default easing function
    pre_hook = nil,              -- Function to run before the scrolling animation starts
    post_hook = nil,             -- Function to run after the scrolling animation ends
    performance_mode = false,    -- Disable "Performance Mode" on all buffers.
})

require('bufferline').setup{
  offsets = {
    {
      filetype = "NERDTree",
      text = "File Explorer",
      highlight = "Directory",
      text_align = "left"
    }
  }
}
EOF

let g:dashboard_custom_header = [
\ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
\ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
\ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
\ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
\ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
\ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
\]

autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2
