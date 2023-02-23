require("mason").setup()
local language_servers = {
  "ansiblels",
  "bashls",
  "dockerls",
  "jsonls",
  "lua_ls",
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
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
  end
  nmap('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[c]ode [a]ction')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols,
    '[d]ocument [s]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
    '[w]orkspace [s]ymbols')
  nmap('gd', vim.lsp.buf.definition, "[g]o to [d]efinition")
  nmap('gi', vim.lsp.buf.implementation, "[g]o to [i]mplementation")
  nmap('gr', require("telescope.builtin").lsp_references, "[g]o to [r]eferences")
  nmap('K', vim.lsp.buf.hover, "hover documentation")
  nmap('<C-k>', vim.lsp.buf.signature_help, 'signature documentation')
  nmap('<F4>', ":TroubleToggle document_diagnostics<CR>", "diagnostic")
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
