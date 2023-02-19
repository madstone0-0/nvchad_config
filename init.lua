local opt = vim.opt
local g = vim.g
local api = vim.api

opt.encoding = "utf-8"
opt.hidden = true
opt.expandtab = true
-- vim.opt.relativenumber = true
opt.title = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.grepprg = "rg --vimgrep --smart-case --follow"
opt.list = true
opt.listchars = "eol:↴,tab:>·,trail:~,extends:>,precedes:<,space:·"
opt.conceallevel = 1
opt.thesaurus = "/home/mads/thesaurus/thesaurii.txt"
opt.termguicolors = true
opt.timeout = true
opt.timeoutlen = 500
-- vim.o.timeout = true
-- vim.o.timeoutlen = 500

local enable_providers = {
  "python3_provider",
  -- "node_provider",
  -- and so on
}

for _, plugin in pairs(enable_providers) do
  vim.g["loaded_" .. plugin] = nil
  vim.cmd("runtime " .. plugin)
end

g.matchup_matchparen_offscreen = { method = "popup" }

g.mkdp_auto_start = 0
g.vim_markdown_math = 1

g.UltiSnipsExpandTrigger = "<A-A>"
g.UltiSnipsJumpForwardTrigger = "<A-A>"
g.UltiSnipsJumpBackwardTrigger = "<A-B>"
g.UltiSnipsEditSplit = "horizontal"

g.tex_flavour = "latex"
g.vimtex_view_method = "zathura"
g.vimtex_quickfix_mode = 0
g.tex_conceal = "abdmg"
g.copilot_assume_mapped = true
g.luasnippets_path = vim.fn.stdpath "config" .. "/lua/custom/snippets/LuaSnip"
-- g.UltiSnipsSnippetDirectories = {
--   vim.fn.stdpath "data" .. "/site/pack/packer/start/vim-snippets/UltiSnips/",
--   vim.fn.stdpath "config" .. "/lua/custom/snippets/UltiSnips/",
-- }
opt.conceallevel = 2

api.nvim_command "autocmd FileType markdown setlocal spell"
api.nvim_command "autocmd FileType markdown set spelllang=en_gb"

vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]

api.nvim_command "autocmd BufWritePre *.js lua vim.lsp.buf.format()"
api.nvim_command "autocmd BufWritePre *.py lua vim.lsp.buf.format()"
api.nvim_command "autocmd BufWritePre *.ts lua vim.lsp.buf.format()"
api.nvim_command "autocmd BufWritePre *.sh lua vim.lsp.buf.format()"
api.nvim_command "autocmd BufWritePre *.md lua vim.lsp.buf.format()"
api.nvim_command "autocmd BufWritePre *.lua lua vim.lsp.buf.format()"
api.nvim_command "autocmd BufWritePre *.yml lua vim.lsp.buf.format()"
