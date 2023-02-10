local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {
  -- webdev
  b.formatting.prettier,
  b.code_actions.eslint_d,

  -- lua
  b.formatting.stylua,

  -- shell
  b.formatting.shfmt,
  b.diagnostics.shellcheck,

  -- python
  -- b.diagnostics.pylint,
  b.formatting.black,

  -- yaml
  b.formatting.yamlfmt,

  -- markdown
  -- b.diagnostics.markdownlint,
  -- b.code_actions.proselint,
  b.formatting.remark.with {
    extra_args = { "--use remark-math" },
  },
  -- b.diagnostics.write_good,
  -- b.diagnostics.cspell,
  -- b.code_actions.cspell,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
