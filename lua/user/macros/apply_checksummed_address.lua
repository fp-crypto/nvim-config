local M = {}
local checksummed_address = require("user.macros.checksummed_address")

-- Function to apply checksummed address to selected text
function M.apply_to_selection()
	-- Get the current visual selection
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")

	-- Get the content of the selection
	local lines = vim.fn.getline(start_pos[2], end_pos[2])

	-- Handle multi-line selections
	if #lines > 1 then
		-- Adjust the first and last line to only include the selected part
		lines[1] = string.sub(lines[1], start_pos[3])
		lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
	else
		-- Single line selection
		lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
	end

	-- Join the lines to get the selected text
	local selected_text = table.concat(lines, "\n")

	-- Apply the checksummed address function
	local result, err = checksummed_address.to_checksummed_address(selected_text)

	if err then
		-- Show error message if conversion failed
		vim.api.nvim_echo({ { err, "ErrorMsg" } }, true, {})
		return
	end

	-- Replace the selected text with the checksummed address
	vim.api.nvim_buf_set_text(
		0, -- Current buffer
		start_pos[2] - 1, -- Start line (0-indexed)
		start_pos[3] - 1, -- Start column (0-indexed)
		end_pos[2] - 1, -- End line (0-indexed)
		end_pos[3], -- End column (0-indexed)
		{ result } -- Replacement text as a table of lines
	)

	-- Show success message
	vim.api.nvim_echo({ { "Address checksummed successfully", "Normal" } }, true, {})
end

-- Create a command to apply the checksummed address
vim.api.nvim_create_user_command("ChecksumAddress", function()
	M.apply_to_selection()
end, {
	range = true,
	desc = "Convert selected Ethereum address to checksummed format",
})

-- Optional: Add a mapping for the command
vim.keymap.set("v", "<leader>ca", ":<C-u>ChecksumAddress<CR>", {
	noremap = true,
	silent = true,
	desc = "Checksum Ethereum address",
})
