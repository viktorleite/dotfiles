local map = vim.keymap.set

-- telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
-- Corrigir
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
--
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })

local builtin = require("telescope.builtin")

map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
map("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
map("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
map("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

map("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = true,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

map("n", "<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[S]earch [/] in Open Files" })

map("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })
-- Geral
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Abri lista de diagnostico [Q]uickfix" })

-- Se <C-\\><C-n> nao funcionar
-- tentar <C-\><Cn>
map("t", "tt", [[<C-\><C-n>]], { desc = "Sair do modo terminal" })
map("t", "<C-t>", [[<C-\><C-n>:q!<CR>]])
map("n", "<leader>t", ":terminal<CR>")
map("n", "<leader>st", ":split | :terminal<CR>")
map("n", "<leader>vt", ":vsplit | :terminal<CR>")

map("n", "<C-h>", "<C-w><C-h>", { desc = "Mover o foco para a janela esquerda" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Mover o foco para a janela direita" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Mover o foco para a janela inferior" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Mover o foco para a janela superior" })

-- Simula Shift+End
map("n", "<S-End>", "v$", { noremap = true, silent = true})
map("i", "<S-End>", "<Esc>v$a", { noremap = true, silent = true})
map("v", "<S-End>", "$", { noremap = true, silent = true})
