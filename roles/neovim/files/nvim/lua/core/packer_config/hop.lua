require('hop').setup({
  case_insensitive = true,
})

vim.keymap.set('n', '<leader><leader>w', ':HopWord<CR>')
