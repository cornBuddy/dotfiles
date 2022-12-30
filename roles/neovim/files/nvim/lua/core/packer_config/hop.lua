require('hop').setup({
  case_insensitive = true,
})

vim.keymap.set('n', '<leader><leader>w', ':HopWordAC<CR>')
vim.keymap.set('n', '<leader><leader>b', ':HopWordBC<CR>')
