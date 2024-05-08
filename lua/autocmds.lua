require "nvchad.autocmds"
local au = vim.api.nvim_create_augroup
local cmd = vim.api.nvim_create_autocmd
local fn = vim.fn

local exts = { "*.js", "*.py", "*.ts", "*.sh", "*.md", "*.lua", "*.yml", "*.cpp", "*.h", "*.tex", "*.jsx" }
local filetypes = {
    "javascript",
    "python",
    "typescript",
    "sh",
    "markdown",
    "lua",
    "yaml",
    "cpp",
    "tex",
    "javascriptreact",
    "typescriptreact",
    "html",
    "json",
    "zig",
    "haskell",
    "r",
    "rust",
    "ardunio",
}

au("BufCheck", { clear = true })
au("remember_folds", { clear = true })
au("lint", { clear = true })

-- Literate Haskell
-- au("_lhaskell", { clear = true })
-- cmd({ "BufNewFile", "BufRead" }, {
--   group = "_lhaskell",
--   pattern = { "*.lhs" },
--   command = "set filetype=tex",
-- })

--Lint
cmd({ "BufWritePost", "InsertLeave", "TextChanged" }, {
    group = "lint",
    pattern = "*",
    callback = function()
        require("lint").try_lint()
    end,
})

-- Remember Folds
cmd("BufWinLeave", {
    group = "remember_folds",
    pattern = "*",
    command = "silent! mkview",
})

cmd("BufWinEnter", {
    group = "remember_folds",
    pattern = "*",
    command = "silent! loadview",
})

-- Restore last cursor position
cmd("BufReadPost", {
    group = "BufCheck",
    pattern = "*",
    callback = function()
        if vim.bo.filetype ~= "gitcommit" then
            if fn.line "'\"" > 0 and fn.line "'\"" <= fn.line "$" then
                fn.setpos(".", fn.getpos "'\"")
            end
        end
    end,
})

-- Start git messages in insert
cmd("FileType", {
    group = "BufCheck",
    pattern = { "gitcommit", "gitrebase" },
    command = "startinsert | 1",
})

-- Sync Clipboards
-- cmd("TextYankPost", {
--   group = "BufCheck",
--   pattern = "*",
--   callback = function()
--     fn.setreg("+", fn.getreg "*")
--   end,
-- })

-- Highlight on yank
au("YankHighlight", { clear = true })
cmd("TextYankPost", {
    group = "YankHighlight",
    callback = function()
        vim.highlight.on_yank { timeout = "400" }
    end,
})

-- Don't auto commenting new lines
cmd("BufEnter", {
    group = "BufCheck",
    pattern = "*",
    command = "set fo-=c fo-=r fo-=o",
})

-- au("_formatting", { clear = true })
-- cmd({ "BufWritePre" }, {
--   group = "_formatting",
--   pattern = "*",
--   callback = function()
--     local contains = false
--     for _, filetype in ipairs(filetypes) do
--       if filetype == vim.bo.filetype then
--         contains = true
--       end
--     end
--
--     if contains then
--       vim.lsp.buf.format()
--     end
--   end,
-- })

au("_markdown", { clear = true })
cmd({ "BufNewFile", "BufRead" }, {
    group = "_markdown",
    pattern = { "*.md" },
    command = "set filetype=markdown",
})
cmd({ "Filetype" }, {
    group = "_markdown",
    pattern = { "markdown" },
    command = "setlocal spell spelllang=en_gb complete+=kspell",
})

au("_latex", { clear = true })
cmd({ "Filetype" }, {
    group = "_latex",
    pattern = { "tex" },
    command = "setlocal spell spelllang=en_gb complete+=kspell",
})

cmd({ "Filetype" }, {
    group = "_latex",
    pattern = { "tex" },
    callback = function()
        vim.cmd "setlocal nocursorline"
        vim.cmd "NoMatchParen"
    end,
})

-- Compile latex on save
-- cmd("BufWritePost", {
--   group = "_latex",
--   pattern = { "*.tex" },
--   callback = function()
--     -- local path = "/home/mads/projects/C++/Learning"
--     -- -- local currPath = vim.fn.expand "%:h:h:h"
--     -- local currPath = vim.fn.getcwd()
--     -- if currPath == path then
--     -- vim.fn.feedkeys(" co", "n")
--     vim.cmd ":call feedkeys(' pr')"
--     -- end
--   end,
-- })

au("_git", { clear = true })
cmd({ "Filetype" }, {
    group = "_git",
    pattern = { "gitcommit" },
    command = "setlocal spell spelllang=en_gb complete+=kspell",
})

au("_cpp", { clear = true })
cmd({ "BufEnter" }, {
    group = "_cpp",
    pattern = { "*.h" },
    command = "let b:fswitchdst ='cpp,c,cc,m'",
})
cmd({ "BufEnter" }, {
    group = "_cpp",
    pattern = { "*.cpp" },
    command = "let b:fswitchdst ='h,hpp'",
})

-- Cmake on cpp save
cmd("BufWritePost", {
    group = "_cpp",
    pattern = { "*.cpp" },
    callback = function()
        local path = "/home/mads/projects/C++/Learning"
        -- local currPath = vim.fn.expand "%:h:h:h"
        local currPath = vim.fn.getcwd()
        if currPath == path then
            -- vim.fn.feedkeys(" co", "n")
            vim.cmd ":call feedkeys(' co')"
        end
    end,
})

au("_kdl", { clear = true })
cmd({ "BufNewFile", "BufRead" }, {
    group = "_kdl",
    pattern = { "*.kdl" },
    command = "set filetype=kdl",
})

au("_snippets", { clear = true })
cmd({ "BufNewFile", "BufRead" }, {
    group = "_snippets",
    pattern = { "*.snippets" },
    command = "set filetype=snippets",
})
