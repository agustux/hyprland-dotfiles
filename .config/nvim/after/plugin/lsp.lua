vim.lsp.config("*", {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

vim.lsp.enable({
    "lua_ls",
    "bashls",
    "pyright",
    "clangd",
    "markdown_oxide",
})

