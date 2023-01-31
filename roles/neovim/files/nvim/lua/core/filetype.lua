vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "helm",
  callback = function(_)
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.softtabstop = 2
    vim.cmd [[ LspStop ]]
  end,
})
