local lspconfig = require('lspconfig')
lspconfig.ruby_lsp.setup({
  init_options = {
    formatter = 'rubocop',
    linters = { 'rubocop' },
  },
})

vim.lsp.set_log_level("debug")

-- defaults adapted from https://linovox.com/configuring-language-server-protocol-lsp-in-neovim/
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "gl", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>lf", function()
  vim.lsp.buf.format({ async = true })
end)
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>lj", function()
  vim.diagnostic.goto_next({buffer=0})
end)
vim.keymap.set("n", "<leader>lk", function()
  vim.diagnostic.goto_prev({buffer=0})
end)
vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help)
vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist)

-- not supported by ruby-lsp
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gI", vim.lsp.buf.implementation)
vim.keymap.set("n", "gr", vim.lsp.buf.references)

-- format on save
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

-- coq config
vim.g.coq_settings = {
  auto_start = true,
}
