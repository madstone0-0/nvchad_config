local a = vim.api
local fn = vim.fn
local cmd = vim.cmd

local M = {}

function M.setupCmds()
    AIComment()
    RunCmakeFile()
end

function AIComment()
    -- run :AICommitMsg from a commit buffer to get an AI generated commit message
    a.nvim_create_user_command("AICommitMsg", function()
        local text = vim.fn.system "ai-commit-msg"
        a.nvim_put(vim.split(text, "\n", {}), "", false, true)
    end, {})

    -- open a commit buffer with an AI generated commit message
    a.nvim_create_user_command("AICommit", function()
        vim.cmd "Git commit"
        vim.cmd "AICommitMsg"
    end, {})

    -- stage everything, then open a commit buffer with an AI generated commit message
    a.nvim_create_user_command("AICommitAll", function()
        fn.system "git add ."
        vim.cmd "Git commit"
        vim.cmd "AICommitMsg"
    end, {})
end

function RunCmakeFile()
    a.nvim_create_user_command("RunC", function()
        -- Get current filename
        local filepath = a.nvim_buf_get_name(0)
        local splits = fn.split(filepath, "/src")
        local filename = fn.split(splits[2], "\\.")[1]
        if filename ~= nil then
            local binary = splits[1] .. "/build/src" .. filename
            -- Run debug build with AsyncRun
            local c = "AsyncRun " .. binary
            cmd(c)
        else
            print "Filename not found"
        end
    end, {})
end

return M
