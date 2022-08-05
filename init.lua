-- require "user.options"
-- require "user.keymaps"
-- require "user.plugins"
-- require "user.autocommands"
-- require "user.colorscheme"
-- require "user.cmp"
-- require "user.telescope"
-- require "user.treesitter"
-- require "user.autopairs"
-- require "user.comment"
-- require "user.gitsigns"
-- require "user.nvim-tree"
-- require "user.lualine"
-- require "user.toggleterm"
-- require "user.impatient"
-- require "user.indentline"
-- require "user.lsp"
-- require "user.dap"
-- require "user.expandregion"
-- require "user.sneak"

vim.cmd([[
try
  set diffopt+=vertical
catch
  set diffopt-=internal
endtry

" dont save { and } jumps to jump history
:nnoremap <silent> } :<C-u>execute 'keepjumps normal!' v:count1 . '}'<CR>
:nnoremap <silent> { :<C-u>execute 'keepjumps normal!' v:count1 . '{'<CR>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

vnoremap <silent> <leader>v :call VisualSelection('search', '')<CR>
]])

local modules = {
 "user.options",
 "user.keymaps",
 "user.plugins",
 "user.autocommands",
 "user.colorscheme",
 "user.cmp",
 "user.telescope",
 "user.treesitter",
 "user.autopairs",
 "user.comment",
 "user.gitsigns",
 "user.nvim-tree",
 "user.lualine",
 "user.toggleterm",
 "user.impatient",
 "user.indentline",
 "user.lsp",
 "user.dap",
 "user.expandregion",
 "user.sneak",
 "user.luasnip",
}
for k, v in pairs(modules) do
  package.loaded[v] = nil
  require(v)
end
