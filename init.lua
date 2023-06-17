local opt = vim.opt
local o = vim.o
local g = vim.g
local a = vim.api
local exec = a.nvim_command
local fn = vim.fn
HOME = fn.environ()["HOME"]

require "custom.autocmds"

local global_options = {
  encoding = "utf-8",
  hidden = true,
  expandtab = true,
  title = true,
  shiftwidth = 4,
  tabstop = 4,
  grepprg = "rg --hidden --iglob '!node_modules/* !.git/*' --vimgrep --smart-case --follow",
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
  fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:⏵,diff:/]],
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
  matchup_matchparen_offscreen = { method = "status" },

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
  -- vimtex_compiler_method = "tectonic",
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
  python3_host_prog = "/home/mads/.pyenv/versions/neovim/bin/python3",
}

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

-- vim.diagnostic.config { virtual_lines = { only_current_line = true } }

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

for i = 1, 9, 1 do
  vim.keymap.set("n", string.format("<C-S-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end

local notify = vim.notify
vim.notify = function(msg, ...)
  if msg:match "warning: multiple different client offset_encodings" then
    return
  end

  notify(msg, ...)
end

exec("au BufWritePost " .. vim.fn.stdpath "config" .. "/custom/configs/dap.lua :luafile %")
opt.clipboard = { "unnamed", "unnamedplus" }
