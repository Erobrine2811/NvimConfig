vim.g.mapleader = " "
vim.keymap.set('n', '<leader>q', "<cmd>q<CR>");
vim.keymap.set('n', '<leader>w', "<cmd>write<CR>");
vim.keymap.set('n', '<C-j>', "<C-w>j");
vim.keymap.set('n', '<C-k>', "<C-w>k");
vim.keymap.set('n', '<C-h>', "<C-w>h");
vim.keymap.set('n', '<C-l>', "<C-w>l");

vim.keymap.set('n', '<C-S-j>', "<cmd>resize -1<CR>");
vim.keymap.set('n', '<C-S-k>', "<cmd>resize +1<CR>");
vim.keymap.set('n', '<C-S-h>', "<cmd>vertical resize -1<CR>");
vim.keymap.set('n', '<C-S-l>', "<cmd>vertical resize +1<CR>");

vim.keymap.set('n', '<leader>sv', "<cmd>vs<CR>");
vim.keymap.set('n', '<leader>sh', "<cmd>split<CR>");
vim.keymap.set("n", "<leader>no", vim.cmd.nohl);

vim.keymap.set("n", "<leader>ccc", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set('n', '<C-S-]>', "<cmd>tabnext<CR>");
vim.keymap.set('n', '<C-S-[>', "<cmd>tabprevious<CR>");
vim.keymap.set('n', '<leader>nt', "<cmd>tabnew<CR>");
