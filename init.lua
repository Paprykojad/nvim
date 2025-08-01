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

local plugins = {
	{},
    {
        'MagicDuck/grug-far.nvim',
        config = function()
            require('grug-far').setup({
                -- options, see Configuration section below
                -- there are no required options atm
                -- engine = 'ripgrep' is default, but 'astgrep' or 'astgrep-rules' can
                -- be specified
            });
        end
    },
    {
        "williamboman/mason.nvim",
        "mfussenegger/nvim-dap",
        "jay-babu/mason-nvim-dap.nvim",
    },
    { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },
    "leoluz/nvim-dap-go",
    {'m4xshen/autoclose.nvim'},
    {'xiyaowong/transparent.nvim'},
    {"joshdick/onedark.vim"},
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	-- {"ellisonleao/gruvbox.nvim"},
	{"rebelot/kanagawa.nvim", lazy=false, priority=1000}, -- kolorki
	-- {'jacoborus/tender.vim'},
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {'mbbill/undotree'},
    { "CRAG666/code_runner.nvim", 
    config = true ,
    commit = "dcedccbf969a0f3bc00db446172b4966e83101dd",
    -- commit = "",
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- Fuzzy Finder Algorithm which requires local dependencies to be built.
            -- Only load if `make` is available. Make sure you have the system
            -- requirements installed.
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- NOTE: If you are having trouble with this installation,
                --       refer to the README for telescope-fzf-native for more instructions.
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
    },
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            {'folke/neodev.nvim', opts={}},
        },
    },
    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
        },
    },
    { 'folke/which-key.nvim', opts = {} }, -- pokazuje dostępne skrótu klawiszowe
	{'numToStr/Comment.nvim', opts={}}, -- komentowanie
	{'ThePrimeagen/harpoon', dependencies={'nvim-lua/plenary.nvim'}}, -- harpoon
    {'anuvyklack/pretty-fold.nvim'},
    {'Paprykojad/renamer.nvim'}
    -- {'JefferyBoy/renamer.nvim'}
}

require("lazy").setup(plugins)
require("pliki")
require("plugins")
