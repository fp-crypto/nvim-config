-- Configuration options for the ABI to Interface converter
local config = {
	-- Solidity version to use in the generated interface
	solidity_version = "^0.8.18",
	-- Default name for the generated interface
	interface_name = "IGeneratedInterface",
	-- License identifier for the generated interface
	license = "AGPL-3.0",
	-- Whether to add SPDX license identifier
	include_spdx = true,
	-- Whether to include state mutability modifiers (view, pure)
	include_mutability = true,
	-- Whether to include parameter names in outputs
	include_output_names = true,
	-- Formatting options
	indent = "    ",
	add_empty_lines_between_items = true,
	add_comments = true,
	-- Sorting options
	sort_methods = true,
	group_by_type = true,
	-- Type remapping
	type_remapping = {},
	-- Auto-detection options
	auto_detect_name = true,
	auto_detect_version = true,
	-- Documentation options
	include_natspec = true,
	-- Memory location options
	default_input_location = "calldata", -- Options: "memory", "calldata", "storage"
	default_output_location = "memory", -- Options: "memory", "calldata", "storage"
}

-- Function to check if a type is a reference type that needs memory location
local function is_reference_type(type_str)
	-- Arrays are always reference types
	if type_str:find("%[") then
		return true
	end

	-- String and bytes (dynamic) are reference types
	if type_str == "string" or type_str == "bytes" then
		return true
	end

	-- Fixed-size bytes (bytes1 through bytes32) are NOT reference types
	if type_str:match("^bytes%d+$") then
		return false
	end

	-- All other primitive types are NOT reference types
	local primitive_types = {
		"address",
		"bool",
		"uint",
		"uint8",
		"uint16",
		"uint32",
		"uint64",
		"uint128",
		"uint256",
		"int",
		"int8",
		"int16",
		"int32",
		"int64",
		"int128",
		"int256",
	}

	for _, ptype in ipairs(primitive_types) do
		if type_str == ptype then
			return false
		end
	end

	-- Assume any other type might be a custom struct or other reference type
	return true
end

-- Function to add memory location to reference types
local function add_memory_location(type_str, location)
	if is_reference_type(type_str) then
		return type_str .. " " .. location
	end
	return type_str
end

-- Function to convert JSON ABI to Solidity interface
local function abi_to_solidity_interface()
	-- Get the current buffer content
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local content = table.concat(lines, "\n")

	-- Get the current buffer name and extract interface name
	local interface_name = config.interface_name
	if config.auto_detect_name then
		local buffer_name = vim.fn.expand("%:t") -- Get filename without path
		local name_match = string.match(buffer_name, "^(.+)%.sol$")
		if name_match then
			-- Only prepend "I" if the name doesn't already start with "I"
			if string.sub(name_match, 1, 1) == "I" then
				interface_name = name_match
			else
				interface_name = "I" .. name_match
			end
		elseif buffer_name ~= "" then
			-- If it's not a .sol file but has a name
			local base_name = string.match(buffer_name, "^(.+)%.[^%.]+$") or buffer_name
			-- Only prepend "I" if the name doesn't already start with "I"
			if string.sub(base_name, 1, 1) == "I" then
				interface_name = base_name
			else
				interface_name = "I" .. base_name
			end
		end
	end

	-- Parse the JSON ABI
	local ok, abi = pcall(vim.json.decode, content)
	if not ok then
		vim.api.nvim_err_writeln("Invalid JSON ABI")
		return
	end

	-- Validate ABI
	if type(abi) ~= "table" or #abi == 0 then
		vim.api.nvim_err_writeln("Invalid or empty ABI")
		return
	end

	-- Start building the Solidity interface
	local solidity_interface = ""

	-- Add SPDX license if enabled
	if config.include_spdx then
		solidity_interface = "// SPDX-License-Identifier: " .. config.license .. "\n"
	end

	-- Add pragma and interface declaration
	solidity_interface = solidity_interface
		.. "pragma solidity "
		.. config.solidity_version
		.. ";\n\n"
		.. "interface "
		.. interface_name
		.. " {\n"

	-- Iterate over each ABI entry
	for _, item in ipairs(abi) do
		if item.type == "function" then
			-- Handle function entries
			local inputs = {}
			for _, input in ipairs(item.inputs or {}) do
				local input_type = add_memory_location(input.type, config.default_input_location)
				table.insert(inputs, input_type .. " " .. input.name)
			end
			local outputs = {}
			for _, output in ipairs(item.outputs or {}) do
				local output_type = add_memory_location(output.type, config.default_output_location)
				local output_str = output_type
				if config.include_output_names and output.name and output.name ~= "" then
					output_str = output_str .. " " .. output.name
				end
				table.insert(outputs, output_str)
			end
			-- Add function state mutability if enabled
			local mutability = ""
			if config.include_mutability and item.stateMutability then
				if item.stateMutability == "view" or item.stateMutability == "pure" then
					mutability = " " .. item.stateMutability
				end
			end

			solidity_interface = solidity_interface
				.. "    function "
				.. item.name
				.. "("
				.. table.concat(inputs, ", ")
				.. ") external"
				.. mutability
			if #outputs > 0 then
				solidity_interface = solidity_interface .. " returns (" .. table.concat(outputs, ", ") .. ")"
			end
			solidity_interface = solidity_interface .. ";\n"
		elseif item.type == "event" then
			-- Handle event entries
			local params = {}
			for _, param in ipairs(item.inputs or {}) do
				table.insert(params, param.type .. (param.indexed and " indexed " or " ") .. param.name)
			end
			solidity_interface = solidity_interface
				.. "    event "
				.. item.name
				.. "("
				.. table.concat(params, ", ")
				.. ");\n"
		end
	end

	solidity_interface = solidity_interface .. "}\n"

	-- Replace the buffer content with the generated Solidity interface
	vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(solidity_interface, "\n"))
end

-- Map the function to a command or keybinding
vim.api.nvim_create_user_command("AbiToInterface", abi_to_solidity_interface, {})
