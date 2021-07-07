local bufferline = require("bufferline").setup(
	{
		options = {
			view = "multiwindow",
			numbers = "ordinal",
			mappings = true,
			buffer_close_icon= '',
			modified_icon = '●',
			close_icon = '',
			left_trunc_marker = '',
			right_trunc_marker = '',
			max_name_length = 18,
			max_prefix_length = 15,
			tab_size = 18,
			show_buffer_close_icons = true,
			show_close_icon = true,
			show_tab_indicators = true,
			separator_style = "thin",
			always_show_bufferline = true,
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level, diagnostics_dict)
				local icon = level:match("error") and " " or " "
				return " " .. icon .. count
			end,
		},
	}
)
