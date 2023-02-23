require("nvim-tree").setup({})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = function()
  require("nvim-tree.api").tree.open()
end })

vim.keymap.set('n', '<leader>t', ':NvimTreeFindFileToggle<CR>')
