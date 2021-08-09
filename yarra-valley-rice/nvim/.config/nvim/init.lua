require("plugins")
require("plugin-loader")
require("keymap")

-- theme
-- require("zephyr")

-- alias for vim.api.nvim_set_option()
local o = vim.o 
-- vim.api.nvim_buf_set_option()
local bo = vim.bo 
-- vim.api.nvim_win_set_option()
local wo = vim.wo 


-- configuration
wo.number = true
wo.wrap = true
o.ruler = false
o.incsearch = true
o.hlsearch = true
o.completeopt = "menuone,noinsert"
o.termguicolors = true
o.mouse = "a"
