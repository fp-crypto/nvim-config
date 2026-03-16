require("user.options")
require("user.keymap")
require("user.autocmd")
require("user.lazy")
require("user.nvimtree")
require("user.lsp")
require("user.cmp")
require("user.autopairs")
require("user.dap")

-- Load all macros from ~/.config/nvim/lua/user/macros/
local macro_dir = vim.fn.stdpath("config") .. "/lua/user/macros"
for _, file in ipairs(vim.fn.glob(macro_dir .. "/*.lua", false, true)) do
  local name = file:match(".*/(.*)%.lua$")
  require("user.macros." .. name)
end
