require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "ansiblels",
    "bashls",
    "dockerls",
    "jsonls",
    "sumneko_lua",
    "pylsp",
    "tflint",
    "yamlls",
  }
})

vim.diagnostic.config({
  virtual_text = false,
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', '<C-r>', vim.lsp.buf.rename)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
  vim.keymap.set('n', 'gr', require("telescope.builtin").lsp_references)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover)
  vim.keymap.set('n', '<F1>', vim.lsp.buf.signature_help)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lsp_setup = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

require("lspconfig").ansiblels.setup(lsp_setup)
require("lspconfig").bashls.setup(lsp_setup)
require("lspconfig").dockerls.setup(lsp_setup)
require("lspconfig").jsonls.setup(lsp_setup)
require("lspconfig").sumneko_lua.setup(lsp_setup)
require("lspconfig").pylsp.setup(lsp_setup)
require("lspconfig").tflint.setup(lsp_setup)
