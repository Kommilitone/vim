local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local handlers = require("user.lsp.handlers")

mason.setup()
mason_lspconfig.setup()

local opts = {
	on_attach = handlers.on_attach,
	capabilities = handlers.capabilities,
}

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			on_attach = handlers.on_attach,
			capabilities = handlers.capabilities,
		})
	end,
	["sumneko_lua"] = function()
		local lua_opts = require("user.lsp.settings.sumneko_lua")
		local extended_opts = vim.tbl_deep_extend("force", lua_opts, opts)
		require("lspconfig")["sumneko_lua"].setup(extended_opts)
	end,
	["jsonls"] = function()
		local json_opts = require("user.lsp.settings.jsonls")
		local extended_opts = vim.tbl_deep_extend("force", json_opts, opts)
		require("lspconfig")["jsonls"].setup(extended_opts)
	end,
})
