local builtin = require('telescope.builtin')

vim.keymap.set('n', '<c-p>', builtin.find_files, {})
vim.keymap.set('n', '<c-f>', builtin.live_grep, {})
vim.keymap.set('n', '<c-b>', builtin.buffers, {})
