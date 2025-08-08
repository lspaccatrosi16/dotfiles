vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use 'nvim-treesitter/playground'
    use 'theprimeagen/harpoon'
    use 'mbbill/undotree'
    use 'EdenEast/nightfox.nvim'
    use 'numToStr/Comment.nvim'
    use 'akinsho/toggleterm.nvim'
    use 'echasnovski/mini.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'folke/neodev.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'ray-x/go.nvim'
    use 'ray-x/guihua.lua'
    use 'mfussenegger/nvim-jdtls'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = { { 'nvim-lua/plenary.nvim' } },
    }

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'neovim/nvim-lspconfig' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
            { 'onsails/lspkind.nvim' }
        }
    }

    use {
        'Wansmer/treesj',
        requires = { 'nvim-treesitter/nvim-treesitter' }
    }

end)
