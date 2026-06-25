local servers = {
	"rust_analyzer",
	"lua_ls",
	"nil_ls",
	"qmlls",
}

local on_attach = function(_, bufnr)
	local bufmap = function(keys, func, desc)
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
	end

	bufmap("<leader>r", vim.lsp.buf.rename, "[r]ename")
	bufmap("<leader>gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
	bufmap("<leader>gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
	bufmap("<leader>gi", vim.lsp.buf.implementation, "[g]oto [i]mplementation")
	bufmap("<leader>gt", vim.lsp.buf.type_definition, "[g]oto [t]ype defintion")

	bufmap("<leader>sd", require("telescope.builtin").diagnostics, "[s]earch [d]iagnostics")

	bufmap("K", vim.lsp.buf.hover, "Hover")
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

for _, server in ipairs(servers) do
	vim.lsp.config(server, {
		capabilities = capabilities,
		on_attach = on_attach,
	})
	vim.lsp.enable(server)
end
