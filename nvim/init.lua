--[[
    Simple Neovim configuration, adapted from my original Vim config
    (`.vimrc`) and [Kickstart](https://github.com/nvim-lua/kickstart.nvim).
--]]

-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Currently not using Nerd Font, but maybe one day
vim.g.have_nerd_font = false

-- Basic configuration
vim.o.breakindent = true
vim.o.confirm = true
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.inccommand = 'split'
vim.o.mouse = 'a'
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 10
vim.o.shiftwidth = 4
vim.o.showmode = false
vim.o.signcolumn = 'yes'
vim.o.smartcase = true
vim.o.softtabstop = 4
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.tabstop = 4
vim.o.timeoutlen = 300
vim.o.undofile = true
vim.o.updatetime = 250

-- Sync OS clipboard
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Whitespace character display
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Basic keymaps (not plugin dependent)
vim.keymap.set('n', '<leader>z', '<cmd>bp<Cr>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>x', '<cmd>bn<Cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>w', '<C-w><C-w>', { desc = 'Change [w]indow' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open [q]uickfix list' })

-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Configure and install plugins
require 'config.lazy'
require('lazy').setup('plugins', {
  ui = {
    -- Provide icon definitions if not using a Nerd Font
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
    },
  },
})
