local opt = vim.opt
local g = vim.g
local a = vim.api
local exec = vim.api.nvim_command
local fn = vim.fn
HOME = fn.environ()["HOME"]

-- Global
opt.encoding = "utf-8"
opt.hidden = true
opt.expandtab = true
opt.title = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.grepprg = "rg --vimgrep --smart-case --follow"
opt.list = true
opt.listchars:append "eol:↴,tab:>·,trail:~,extends:>,precedes:<,space:·"
opt.conceallevel = 1
opt.thesaurus = "/home/mads/thesaurus/thesaurii.txt"
opt.termguicolors = true
opt.timeout = true
opt.timeoutlen = 500
opt.tag = "./tags"
opt.termguicolors = true
opt.ignorecase = true
opt.undofile = true
opt.splitbelow = true
opt.splitright = true
opt.smartcase = true
opt.undofile = true -- undo even when it closes
-- opt.foldmethod = "expr" -- treesiter time
-- opt.foldexpr = "nvim_treesitter#foldexpr()" -- treesiter
opt.wildignore:append { ".javac", "node_modules", "*.pyc" }

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

local enable_providers = {
  "python3_provider",
  "node_provider",
  -- and so on
}

for _, plugin in pairs(enable_providers) do
  vim.g["loaded_" .. plugin] = nil
  vim.cmd("runtime " .. plugin)
end

g.gutentags_ctags_exclude_wildignore = 1
g.gutentags_ctags_exclude = {
  "node_modules",
  "_build",
  "build",
  "CMakeFiles",
  "venv",
}
g.gutentags_ctags_extra_args = {
  "--fields=+niazS",
  "--extra=+q",
  "--c++-kinds=+px",
  "--c-kinds=+px",
}

g.matchup_matchparen_offscreen = { method = "popup" }

g.mkdp_auto_start = 0
g.vim_markdown_math = 1
g.vim_markdown_folding_disabled = 1

g.UltiSnipsExpandTrigger = "<A-A>"
g.UltiSnipsJumpForwardTrigger = "<A-A>"
g.UltiSnipsJumpBackwardTrigger = "<A-B>"
g.UltiSnipsEditSplit = "horizontal"

g.tex_flavour = "latex"
g.vimtex_view_method = "zathura"
g.vimtex_quickfix_mode = 0
g.tex_conceal = "abdmgs"
g.copilot_assume_mapped = true
g.luasnippets_path = {
  -- string.format("%s/lua/custom/snippets/vs_luasnip", vim.fn.stdpath "config"),
  string.format("%s/lua/custom/snippets/LuaSnip", fn.stdpath "config"),
  -- string.format("%s/lua/custom/snippets/SnipMate", vim.fn.stdpath "config"),
}
exec(
  string.format(
    "let g:UltiSnipsSnippetDirectories=['%s','%s']",
    vim.fn.stdpath "data" .. "/site/pack/packer/start/vim-snippets/UltiSnips/",
    vim.fn.stdpath "config" .. "/lua/custom/snippets/UltiSnips/"
  )
)
opt.conceallevel = 2

g.suda_smart_edit = 1

a.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "NvimTree*",
  callback = function()
    local view = require "nvim-tree.view"
    local is_visible = view.is_visible()

    local api = require "nvim-tree.api"
    if not is_visible then
      api.tree.open()
    end
  end,
})

exec "autocmd BufNewFile,BufRead *.md set filetype=markdown"
exec "autocmd FileType markdown setlocal spell"
exec "autocmd FileType markdown set spelllang=en_gb"
exec "au FileType markdown setlocal complete+=kspell"

exec "autocmd FileType tex setlocal spell"
exec "autocmd FileType tex set spelllang=en_gb"
exec "au FileType tex setlocal complete+=kspell"

exec "au FileType gitcommit setlocal spell"
exec "au FileType gitcommit set spelllang=en_gb"
exec "au FileType gitcommit setlocal complete+=kspell"

-- vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]

local exts = { "js", "py", "ts", "sh", "md", "lua", "yml", "cpp", "h", "tex" }

for _, ext in pairs(exts) do
  exec("au BufWritePre *" .. ext .. " lua vim.lsp.buf.format()")
end

exec "au BufEnter *.h let b:fswitchdst ='cpp,c,cc,m'"
exec "au BufEnter *.cpp let b:fswitchdst ='h,hpp'"
exec(string.format("au BufWritePost %s :luafile %", vim.fn.stdpath "config" .. "/custom/plugins/dap.lua"))
opt.clipboard = { "unnamed", "unnamedplus" }
