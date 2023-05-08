local opt = vim.opt
local o = vim.o
local g = vim.g
local a = vim.api
local exec = a.nvim_command
local fn = vim.fn
HOME = fn.environ()["HOME"]

local global_options = {
  encoding = "utf-8",
  hidden = true,
  expandtab = true,
  title = true,
  shiftwidth = 4,
  tabstop = 4,
  grepprg = "rg --vimgrep --smart-case --follow",
  list = true,
  conceallevel = 2,
  thesaurus = "/home/mads/thesaurus/thesaurii.txt",
  timeout = true,
  timeoutlen = 300,
  tag = "./tags",
  termguicolors = true,
  ignorecase = true,
  splitbelow = true,
  splitright = true,
  smartcase = true,
  spelllang = "en_gb",
  undolevels = 5000,
  undofile = true, -- undo even when it closes
  undodir = vim.fn.stdpath "data" .. "/undo_dir",
  cmdheight = 1,
  pumheight = 10,
  smartindent = true,
  swapfile = false,
  updatetime = 300,
  backup = false,
  writebackup = false,
  numberwidth = 2,
  wrap = true,
  linebreak = true,
  scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor
  sidescrolloff = 8,
  whichwrap = "bs<>[]hl",
}

local local_options = {
  sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions",
  fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:⏵]],
  foldcolumn = "1",
  foldlevel = 50,
  foldlevelstart = 70,
  foldenable = true,
}

local plugin_options = {
  -- Gutentags
  gutentags_ctags_exclude_wildignore = 1,
  gutentags_ctags_exclude = { "node_modules", "_build", "build", "CMakeFiles", "venv" },
  gutentags_ctags_extra_args = { "--fields=+niazS", "--extra=+q", "--c++-kinds=+px", "--c-kinds=+px" },

  -- Matchup
  matchup_matchparen_offscreen = { method = "popup" },

  -- Vim Markdown
  mkdp_auto_start = 0,
  vim_markdown_math = 1,
  vim_markdown_folding_disabled = 0,

  -- UltiSnips
  UltiSnipsExpandTrigger = "<A-A>",
  UltiSnipsJumpForwardTrigger = "<A-A>",
  UltiSnipsJumpBackwardTrigger = "<A-B>",
  UltiSnipsEditSplit = "horizontal",

  -- VimLatex
  tex_flavour = "latex",
  vimtex_view_method = "zathura",
  vimtex_quickfix_mode = 0,
  tex_conceal = "abdmgs",

  -- Copilot
  copilot_assume_mapped = true,
  copilot_filetypes = { { "TelescopePrompt", false } },

  -- LuaSnip
  luasnippets_path = { string.format("%s/lua/custom/snippets/LuaSnip", fn.stdpath "config") },

  -- Suda
  suda_smart_edit = 1,

  -- Python3
  python3_host_prog = "/home/mads/.pyenv/versions/3.11.2/bin/python3",
}

local exts = { "js", "py", "ts", "sh", "md", "lua", "yml", "cpp", "h", "tex", "jsx" }

for k, v in pairs(global_options) do
  opt[k] = v
end

for k, v in pairs(local_options) do
  o[k] = v
end

opt.listchars:append "eol:↴,tab:>·,trail:~,extends:>,precedes:<,space:·"
opt.wildignore:append { ".javac", "node_modules", "*.pyc" }
opt.nrformats:append "alpha"
opt.iskeyword:append "-" -- hyphenated words recognized by searches

vim.diagnostic.config { virtual_lines = { only_current_line = true } }

local enable_providers = {
  "python3_provider",
  "node_provider",
  -- and so on
}

for _, plugin in pairs(enable_providers) do
  vim.g["loaded_" .. plugin] = nil
  vim.cmd("runtime " .. plugin)
end

vim.cmd "runtime! plugin/rplugin.vim"

for k, v in pairs(plugin_options) do
  g[k] = v
end

exec(
  string.format(
    "let g:UltiSnipsSnippetDirectories=['%s','%s']",
    vim.fn.stdpath "data" .. "/lazy/vim-snippets/UltiSnips/",
    vim.fn.stdpath "config" .. "/lua/custom/snippets/UltiSnips/"
  )
)

for _, ext in pairs(exts) do
  exec("au BufWritePre *" .. ext .. " lua vim.lsp.buf.format()")
end

for i = 1, 9, 1 do
  vim.keymap.set("n", string.format("<A-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end

vim.cmd [[
augroup _markdown
autocmd!
au BufNewFile,BufRead *.md set filetype=markdown
au FileType markdown setlocal spell
au FileType markdown set spelllang=en_gb
au FileType markdown setlocal complete+=kspell
augroup end

augroup _latex
autocmd!
au FileType tex setlocal spell
au FileType tex set spelllang=en_gb
au FileType tex setlocal complete+=kspell
augroup end

augroup _git
au FileType gitcommit setlocal spell
au FileType gitcommit set spelllang=en_gb
au FileType gitcommit setlocal complete+=kspell"
augroup end

augroup _cpp
au BufEnter *.h let b:fswitchdst ='cpp,c,cc,m'
au BufEnter *.cpp let b:fswitchdst ='h,hpp'
augroup end

augroup RestoreCursorShapeOnExit
    autocmd!
    autocmd VimLeave * set guicursor=a:hor20
augroup END
]]

exec("au BufWritePost " .. vim.fn.stdpath "config" .. "/custom/configs/dap.lua :luafile %")
opt.clipboard = { "unnamed", "unnamedplus" }
