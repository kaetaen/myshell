vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  'folke/which-key.nvim',
  {
    'scrooloose/nerdtree',
    config = function ()
      vim.keymap.set("","ff", ":NERDTreeToggle<CR>")
      vim.g.NERDTreeWinSize = 20
      -- open nerdtree file on new tab
      vim.keymap.set("", "tl", "t")
    end
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    config = function()
      require("ibl").setup {}
    end
  },
  'mattn/emmet-vim',
  'pseewald/vim-anyfold',
  'jiangmiao/auto-pairs',
  'nvim-tree/nvim-web-devicons',
  'sheerun/vim-polyglot',
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'mfussenegger/nvim-lint',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  'ryanoasis/vim-devicons',
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
  {
    "CRAG666/code_runner.nvim",
    config = function()
      require('code_runner').setup({
        filetype = {
          python = "python3 -u",
          javascript = "node ",
          go  = "go run "
        },
      })
      vim.keymap.set("","nn", ":RunCode<CR>")

    end
  },
})

-- telescope

local builtin = require('telescope.builtin')
vim.keymap.set('', 'ss', builtin.find_files, {})
vim.keymap.set('', 'sd', builtin.live_grep, {})

-- MASON/LSP SETUP
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
  function (server_name)
      require("lspconfig")[server_name].setup {}
  end,
}


-- CMP COMPLETE SETUP

local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })





vim.opt.inccommand="split"
vim.opt.encoding="UTF-8"
vim.opt.softtabstop=2
vim.opt.shiftwidth=2
vim.opt.expandtab=true
vim.opt.tabstop=2
vim.opt.softtabstop=2
vim.opt.shiftwidth=2
vim.opt.number=true
vim.opt.autoindent=true
vim.opt.cindent=true
vim.opt.smartindent=true
vim.opt.encoding="utf-8"
vim.opt.splitright=true
vim.opt.history=300
vim.opt.undolevels=300
vim.opt.incsearch=true
vim.opt.ignorecase=true
vim.opt.hlsearch=true
vim.opt.scrolloff=5
vim.opt.foldmethod="indent"
vim.opt.foldnestmax=10
vim.opt.wrap=true
vim.opt.mouse="a" 
vim.opt.foldlevel=99
vim.opt.laststatus=2
vim.opt.splitbelow=true
vim.opt.clipboard="unnamedplus"

-- open terminal
vim.keymap.set("","tt", ":sp+terminal<CR>")
-- open/close code fold
vim.keymap.set("", "z", "za")
