local map = vim.keymap.set

map("n", "<esc>", "<cmd>nohlsearch<cr><esc>")
map("n", "<leader>w", "<cmd>w!<cr>", { desc = "NVIM: Write file" })
map("n", "<leader>ww", "<cmd>wa!<cr>", { desc = "NVIM: Write all files" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "NVIM: Quit" })

map("n", "<C-j>", "<cmd>cnext<CR>zz")
map("n", "<C-k>", "<cmd>cprev<CR>zz")
map("n", "<C-s>", "<cmd>vs<CR>")

-- diagnostic keymaps
-- map('n', '<leader>d', vim.diagnostic.setloclist, { desc = 'open diagnostic [q]uickfix list' })

-- exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. otherwise, you normally need to press <c-\><c-n>, which
-- is not what someone will guess without a bit more experience.
--
-- note: this won't work in all terminal emulators/tmux/etc. try your own mapping
-- or just use <c-\><c-n> to exit terminal mode
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "exit terminal mode" })

-- keybinds to make split navigation easier.
--  use ctrl+<hjkl> to switch between windows
--
--  see `:help wincmd` for a list of all window commands
-- map("n", "<c-h>", "<c-w><c-h>", { desc = "move focus to the left window" })
-- map("n", "<c-l>", "<c-w><c-l>", { desc = "move focus to the right window" })
-- map("n", "<c-j>", "<c-w><c-j>", { desc = "move focus to the lower window" })
-- map("n", "<c-k>", "<c-w><c-k>", { desc = "move focus to the upper window" })

-- note: some terminals have colliding keymaps or are not able to send distinct keycodes
-- map("n", "<c-s-h>", "<c-w>h", { desc = "move window to the left" })
-- map("n", "<c-s-l>", "<c-w>l", { desc = "move window to the right" })
-- map("n", "<c-s-j>", "<c-w>j", { desc = "move window to the lower" })
-- map("n", "<c-s-k>", "<c-w>k", { desc = "move window to the upper" })

map("n", "<leader>nd", "<cmd>NoiceDismiss<cr>", { desc = "NOTIFICATIONS: Dismiss noice notifications" })
map("i", "<C-k>", vim.lsp.buf.signature_help, { noremap = true, silent = true })

map("n", "L", "<C-^>", { noremap = true, silent = true }) -- Go to previous buffer
map("n", "<C-x>", "<cmd>bd<CR>", { noremap = true, silent = true })
map("i", "<C-l>", "<Esc>la", { noremap = true, silent = true })
map("i", "<C-h>", "<Esc>i", { noremap = true, silent = true })

vim.keymap.set("n", "<A-n>", ":cnext<CR>", { silent = true })
vim.keymap.set("n", "<A-p>", ":cprev<CR>", { silent = true })
