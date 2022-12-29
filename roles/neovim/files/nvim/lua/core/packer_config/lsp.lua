require("mason").setup()
local language_servers = {
  "ansiblels",
  "bashls",
  "dockerls",
  "jsonls",
  "sumneko_lua",
  "pylsp",
  "terraformls",
  "gopls",
  "yamlls",
}
require("mason-lspconfig").setup({
  ensure_installed = language_servers,
})

vim.diagnostic.config({
  virtual_text = false,
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, _)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', '<C-r>', vim.lsp.buf.rename)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
  vim.keymap.set('n', 'gr', require("telescope.builtin").lsp_references)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover)
  vim.keymap.set('n', '<F1>', vim.lsp.buf.signature_help)
  vim.keymap.set('n', '<F4>', ":TroubleToggle document_diagnostics<CR>")
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lsp_setup = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

for _, lang in pairs(language_servers) do
  require("lspconfig")[lang].setup(lsp_setup)
end
