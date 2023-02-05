vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  open_on_setup = true,
})

vim.keymap.set('n', '<leader>t', ':NvimTreeFindFileToggle<CR>')
