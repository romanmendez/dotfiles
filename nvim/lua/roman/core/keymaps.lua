-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- move the selected lines up and down in the document
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- delete to void
keymap.set("n", "<leader>d", '"_d')
keymap.set("v", "<leader>d", '"_d')
keymap.set("x", "<leader>p", '"_dP') -- delete and paste

-- system clipboard
keymap.set({ "n", "v" }, "<leader>y", '"+y')
keymap.set({ "n", "v" }, "<leader>Y", '"+Y')

-- Search and replace
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- keep the cursor in place
keymap.set("n", "J", "mzJ`z") -- when appending the next line to the end of the current
keymap.set("n", "n", "nzzzv") -- when navigating through search terms
keymap.set("n", "N", "Nzzzv") -- when navigating through search terms

-- moving around the document
keymap.set({ "n", "v" }, "<leader>j", "<C-d>") -- when moving half-pages down
keymap.set({ "n", "v" }, "<leader>k", "<C-u>") -- when moving half-pages up
keymap.set({ "n", "v" }, "<CR>", "}") -- jump down between line-breaks with return key
keymap.set({ "n", "v" }, "<BS>", "{") -- jump up between line-breaks with delete key

-- buffer navigation
keymap.set("n", "<C-]>", "<cmd>bnext<CR>")

-- Nop
keymap.set("n", "<C-u>", "<Nop>")
keymap.set("n", "<C-d>", "<Nop>")
keymap.set("n", "q", "<Nop>")
