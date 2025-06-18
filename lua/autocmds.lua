require "nvchad.autocmds"
local utils = require "utils"
local au = vim.api.nvim_create_augroup
local cmd = vim.api.nvim_create_autocmd
local fn = vim.fn
local paths = {
    C = utils.Set {
        "/home/mads/projects/C/Learning",
    },
    Cpp = utils.Set {
        "/home/mads/projects/C++/Learning",
        "/home/mads/projects/C++/live",
        "/home/mads/projects/C++/mlinalg",
        "/mnt/windows/Users/HP/Programming/C++/school",
        "/home/mads/projects/C++/space",
        "/home/mads/projects/C++/ml",
        "/home/mads/projects/C++/game_dev",
        "/home/mads/projects/C++/wasm",
        "/home/mads/projects/C++/mdsa",
        -- "/home/mads/projects/C++/msim",
    },
    Go = utils.Set {
        "/home/mads/projects/Go/Learning",
        "/home/mads/projects/Go/gowal",
        "/home/mads/projects/Go/lotr_bpe",
    },
}

au("BufCheck", { clear = true })
au("remember_folds", { clear = true })
au("lint", { clear = true })
au("defaults", { clear = true })

-- Auto create directories
cmd("BufWritePre", {
    group = "defaults",
    callback = function(event)
        if event.match:match "^%w%w+://" then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- Auto close certain windows with 'q'
cmd("FileType", {
    group = "defaults",
    pattern = {
        "help",
        "startuptime",
        "qf",
        "lspinfo",
        "man",
        "checkhealth",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", ":close<CR>", { buffer = event.buf, silent = true })
    end,
})

--Lint
cmd({ "BufWritePost", "InsertLeave", "TextChanged" }, {
    group = "lint",
    pattern = "*",
    callback = function()
        require("lint").try_lint()
    end,
})

au("autosave", { clear = true })
cmd({ "BufLeave" }, {
    group = "autosave",
    pattern = "*",
    callback = function()
        if vim.bo.buftype == "" and vim.bo.modified then
            vim.cmd "silent! w"
        end
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

au("_asm", { clear = true })
cmd({ "BufNewFile", "BufRead" }, {
    group = "_asm",
    pattern = { "*.asm" },
    command = "set filetype=asm",
})

au("_markdown", { clear = true })
cmd({ "BufNewFile", "BufRead" }, {
    group = "_markdown",
    pattern = { "*.md" },
    command = "set filetype=markdown",
})

-- cmd({ "Filetype" }, {
--     group = "_markdown",
--     pattern = { "markdown" },
--     command = "setlocal spell spelllang=en_gb complete+=kspell",
-- })

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
        vim.cmd "set nowrap"
        vim.cmd "PencilSoft"
        vim.cmd "let g:pencil#conceallevel = 2"
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
    pattern = { "*.cpp", "*.c" },
    command = "let b:fswitchdst ='h,hpp'",
})
cmd({ "BufNewFile", "BufRead" }, {
    group = "_cpp",
    pattern = { "*.tpp" },
    command = "set filetype=cpp",
})
cmd({ "BufEnter" }, {
    group = "_cpp",
    pattern = { "*.cpp", "*.c" },
    callback = function()
        vim.bo.commentstring = "// %s"
    end,
})

au("_build", { clear = true })
-- Global build on save TODO: Make this toggeable
cmd("BufWritePost", {
    group = "_build",
    pattern = "*",
    callback = function()
        local currPath = vim.fn.getcwd()
        local buildScriptPath = currPath .. "/build.sh"
        if vim.fn.filereadable(buildScriptPath) == 1 then
            vim.cmd ":call feedkeys(' cos')"
        end
    end,
})

-- Cmake on cpp save
-- cmd("BufWritePost", {
--     group = "_cpp",
--     pattern = { "*.cpp", "*.h", "*.hpp" },
--     callback = function()
--         local currPath = vim.fn.getcwd()
--         if paths["Cpp"][currPath] then
--             vim.cmd ":call feedkeys(' cos')"
--         end
--     end,
-- })

-- Cmake on c save
-- cmd("BufWritePost", {
--     group = "_cpp",
--     pattern = { "*.h", "*.c" },
--     callback = function()
--         local currPath = vim.fn.getcwd()
--         if paths["C"][currPath] then
--             vim.cmd ":call feedkeys(' cos')"
--         end
--     end,
-- })

-- Build on go save
au("_go", { clear = true })
-- cmd("BufWritePost", {
--     group = "_go",
--     pattern = { "*.go" },
--     callback = function()
--         local currPath = vim.fn.getcwd()
--         if paths["Go"][currPath] then
--             -- vim.fn.feedkeys(" co", "n")
--             vim.cmd ":call feedkeys(' cos')"
--         end
--     end,
-- })

-- au("_lean", { clear = true })
-- cmd({ "BufNewFile", "BufRead" }, {
--     group = "_lean",
--     pattern = { "*.lean" },
--     command = "set filetype=lean",
-- })

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

cmd("Signal", {
    pattern = "SIGUSR1",
    callback = function()
        require("nvchad.utils").reload()
    end,
})
