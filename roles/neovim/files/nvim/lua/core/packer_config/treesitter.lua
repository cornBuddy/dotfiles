require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    "bash",
    "comment",
    "dockerfile",
    "hcl",
    "python",
    "rust",
    "toml",
    "yaml",
    "lua",
  },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
}
