-------------------
-- basic
-------------------
vim.g.mapleader = ','
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.encoding = "utf-8"
vim.o.history = 500
vim.o.updatetime = 300 -- updatetime (default is 4000 ms = 4 s)
vim.o.timeoutlen = 500
vim.o.backspace = "indent,eol,start" -- backspace works on every char in insert mode
vim.o.clipboard = "unnamedplus" -- yanking/deleting operations copy to the system clipboard
vim.o.autoread = true -- set to auto read when a file is changed from the outside
vim.o.splitright = true

if vim.fn.has('win32') == 1 then
    vim.o.shell = 'cmd'
end

-------------------
-- user interface
-------------------
vim.o.termguicolors = true
vim.o.lazyredraw = true -- don't redraw while executing macros (good performance config)
vim.o.mouse = 'a'
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.showmatch = true -- show matching brackets
vim.o.scrolloff = 3 -- always show rows from edge of the screen
vim.o.synmaxcol = 300 -- stop syntax highlight after x lines for performance
vim.o.wildmenu = true -- turn on the wild menu
vim.o.cmdheight = 1 -- height of the command bar
vim.o.laststatus = 2 -- always show status line
vim.o.list = false -- do not display white characters
vim.o.wrap = false --do not wrap lines even if very long
vim.o.eol = false -- show if there's no eol char
vim.o.matchtime = 2 -- how many tenths of a second to blink when matching brackets
vim.o.textwidth = 500
vim.o.hidden = true -- opening a new file when the current buffer has unsaved changes, causes files to be hidden instead of closed
vim.o.errorbells = false -- no annoying sound on errors
-- vim.o.foldcolumn = '1' -- add a bit extra margin to the left
-- vim.o.foldlevel = 99
vim.o.signcolumn = 'number' -- always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved
vim.o.title = true

-------------------
-- search
-------------------
vim.o.incsearch = true -- starts searching as soon as typing, without enter needed
vim.o.ignorecase = true -- ignore letter case when searching
vim.o.smartcase = true -- case insentive unless capitals used in search
vim.o.magic = true -- for regular expressions turn magic on

-------------------
-- white characters
-------------------
vim.o.expandtab = true -- expand tab to spaces
vim.o.smarttab = true
vim.o.tabstop = 4 -- 1 tab = 4 spaces
vim.o.shiftwidth = 4 -- indentation rule
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.endofline = false
vim.o.fixendofline = false
vim.o.formatoptions = 'qnj1' -- q  - comment formatting; n - numbered lists; j - remove comment when joining lines; 1 - don't break after one-letter word

-------------------
-- backup
-------------------
vim.o.backup = false -- turn backup off, since most stuff is in SVN, git etc. anyway...
vim.o.writebackup = false
vim.o.swapfile = false

-------------------
-- diagnostic sign
-------------------
local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " "
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    virtual_text = {
        prefix = '●'
    }
})

-------------------
-- others
-------------------
vim.cmd [[
    hi FocusedSymbol gui=bold guifg=#C678DD
    autocmd FocusGained,BufEnter * checktime
    autocmd BufNewFile,BufRead *.vs set filetype=glsl
    autocmd BufNewFile,BufRead *.fs set filetype=glsl
]]
