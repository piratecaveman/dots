local lspconfig = require("lspconfig")

local on_attach = function(client)
	require("completion").on_attach(client)
end

lspconfig.rust_analyzer.setup(
	{
		on_attach = on_attach,
		settings = {
			["rust-analyzer"] = {
				assist = {
					importMergeBehavior = "none",
					importPrefix = "by_crate",
					importGroup = false,

				},
				cargo = {
					loadOutDirsFromCheck = true,
				},
				procMacro = {
					enable = true
				},
				checkOnSave = {
					command = "clippy",
				},
				inlayHints = {
					maxLength = 10,	
				},
			},
		},
		cmd = { "rust-analyzer" },
		filetypes = { "rust" },
	}
)

return lspconfig
