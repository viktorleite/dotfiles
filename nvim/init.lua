vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10

vim.keymap.set("n", "<Ch>", "<Cw><Ch>", { desc = "Mover o foco para a janela esquerda" })
vim.keymap.set("n", "<Cl>", "<Cw><Cl>", { desc = "Mover o foco para a janela direita" })
vim.keymap.set("n", "<Cj>", "<Cw><Cj>", { desc = "Mover o foco para a janela inferior" })
vim.keymap.set("n", "<Ck>", "<Cw><Ck>", { desc = "Mover o foco para a janela superior" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Destacar ao extrair (copiar) text.",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", {
		clear = true,
	}),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

vim.opt.rtp:prepend(lazypath)

-- [[ Configuração e Instalação de plugins ]]
--require('lazy').setup({
--'tpope/vim-sleuth',
--  {
--    opts = {
--      signs = {
--        add = { text = '+' },
--        change = { text = '~' },
--        delete = { text = '_' },
--        topdelete = { text = '-' },
--        changedelete = { text = '~' },
--      },
--    },
--  },
--
--})
