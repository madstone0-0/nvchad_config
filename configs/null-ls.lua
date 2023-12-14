local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {
  -- webdev
  -- b.formatting.prettierd.with {
  --   filetypes = {
  --     "javascript",
  --     "javascriptreact",
  --     "typescript",
  --     "typescriptreact",
  --     "vue",
  --     "css",
  --     "scss",
  --     "less",
  --     "html",
  --     "json",
  --     "jsonc",
  --     "markdown.mdx",
  --     "graphql",
  --     "handlebars",
  --     "svelte",
  --   },
  -- },
  b.code_actions.eslint_d,
  -- b.formatting.rustywind,

  -- lua
  -- b.formatting.stylua,

  -- shell
  -- b.formatting.shfmt,
  -- b.diagnostics.shellcheck,

  -- python
  -- b.formatting.black.with {
  --   extra_args = { "-l 120" },
  -- },
  -- b.diagnostics.ruff,
  -- b.formatting.ruff,
  b.diagnostics.mypy.with {
    extra_args = function()
      local virtual = os.getenv "VIRTUAL_ENV" or os.getenv "CONDA_DEFAULT_ENV" or "/usr"
      return { "--python-executable", virtual .. "/bin/python3" }
    end,
  },

  -- yaml
  -- b.formatting.yamlfmt,
  -- b.diagnostics.yamllint,

  -- markdown
  -- b.formatting.remark.with {
  --   extra_args = { "--use remark-math" },
  -- },
  -- b.formatting.cbfmt,
  -- b.diagnostics.write_good,
  -- b.diagnostics.cspell.with {
  --   filetypes = { "markdown" },
  -- },
  -- b.code_actions.cspell.with {
  --   filetypes = { "markdown" },
  -- },

  -- latex
  -- b.formatting.latexindent,

  -- c++
  -- b.formatting.clang_format.with {
  --   extra_args = { "--style=file" },
  -- },

  -- zig
  -- b.formatting.zigfmt,

  -- haskell
  -- b.formatting.fourmolu,

  -- words
  -- b.diagnostics.codespell,

  -- git
  -- b.diagnostics.commitlint,

  -- sql
  -- b.formatting.sqlfmt,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
