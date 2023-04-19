local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {
  -- webdev
  b.formatting.prettier.with {},
  b.code_actions.eslint_d,

  -- lua
  b.formatting.stylua,

  -- shell
  b.formatting.shfmt,
  -- b.diagnostics.shellcheck,

  -- python
  b.formatting.black,
  b.diagnostics.ruff,
  b.formatting.ruff,

  -- yaml
  b.formatting.yamlfmt,
  b.diagnostics.yamllint,

  -- markdown
  b.formatting.remark.with {
    extra_args = { "--use remark-math" },
  },
  b.formatting.cbfmt,
  -- b.diagnostics.write_good,
  b.diagnostics.cspell.with {
    filetypes = { "markdown" },
  },
  b.code_actions.cspell,

  -- latex
  b.formatting.latexindent,

  -- c++
  b.formatting.clang_format.with {
    extra_args = { "--style=file" },
  },
}

null_ls.setup {
  debug = true,
  sources = sources,
}
