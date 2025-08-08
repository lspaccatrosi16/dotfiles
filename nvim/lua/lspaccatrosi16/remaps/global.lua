vim.g.mapleader = " "

-- move lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keep cursor in place with J
vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor central for half page jumps
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- paste over without loosing cur buffer value
-- vim.keymap.set("x", "<leader>p", "\"_dP")

-- cut and paste to system register
vim.keymap.set({"n", "v"}, "<leader>y", "\"+y")
vim.keymap.set({"n", "v"}, "<leader>Y", "\"+Y")

-- delete to null register
vim.keymap.set({"n", "v"}, "<leader>d", "\"_d")

-- prime says so ??
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>s", ":Shortcuts<CR>")
