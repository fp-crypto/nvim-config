require("user.options")
require("user.keymap")
require("user.autocmd")
require("user.lazy")
require("user.treesitter")
require("user.colors")
require("user.line")
require("user.nvimtree")
require("user.lsp")
require("user.cmp")
require("user.autopairs")
require("user.illuminate")
require("user.dap")
require("user.git")

-- Load all macros from ~/.config/nvim/lua/user/macros/
local macro_dir = vim.fn.stdpath("config") .. "/lua/user/macros"
for _, file in ipairs(vim.fn.glob(macro_dir .. "/*.lua", false, true)) do
  local name = file:match(".*/(.*)%.lua$")
  require("user.macros." .. name)
end
