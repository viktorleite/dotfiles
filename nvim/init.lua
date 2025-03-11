vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = true
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
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.foldenable = true
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"


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
require('lazy').setup({
 'tpope/vim-sleuth', -- Detecta tastop e shiftwidth automaticamente
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  {
    'nvim-telescope/telescope.nvim'
    , event = 'VimEnter'
    , branch = '0.1.x'
    , dependecies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fsf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      {
        'nvim-telescope/telescope-ui-select.nvim'
      },
      {
        'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font
      },

      config = function()
        require('telescope').setup {
          extensions = {
            ['uiselect'] = {
              require('telescope.themes').get_dropdown(),
            },
          },
        }

        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')


        local builtin = require 'telescope.builtin'

        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

        -- Slightly advanced example of overriding default behavior and theme
        vim.keymap.set('n', '<leader>/', function()
          -- You can pass additional configuration to Telescope to change the theme, layout, etc.
          builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = true,
          })
        end, { desc = '[/] Fuzzily search in current buffer'} )

        vim.keymap.set('n', '<leader>s/', function()
          builtin.live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end, { desc = '[S]earch [/] in Open Files' })

        -- Shortcut for searching your Neovim configuration files
        vim.keymap.set('n', '<leader>sn', function()
          builtin.find_files { cwd = vim.fn.stdpath 'config' }
        end, { desc = '[S]earch [N]eovim files' })
      end,
    },
  },
  -- [[ END Telescope ]]
  -- [[ Git Blame ]]
  {
    "f-person/git-blame.nvim",
    enabled = true,
    lazy = false,
    priority = 7,
  },

  -- [[ ./lua/plugins/ ]] --
  require("plugins.neo-tree"),
},
{
    ui = {
      icons = vim.g.have_nerd_font and {} or {
          cmd = '⌘',
          config = '🛠',
          event = '📅',
          ft = '📂',
          init = '⚙',
          keys = '🗝',
          plugin = '🔌',
          runtime = '💻',
          require = '🌙',
          source = '📄',
          start = '🚀',
          task = '📌',
          lazy = '💤 ',
      }
    },
})


