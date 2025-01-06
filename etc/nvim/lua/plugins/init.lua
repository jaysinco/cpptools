local fn = vim.fn
local packer_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(packer_path)) > 0 then
    vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
    fn.system { 'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', packer_path }
    return
end

local packer = require('packer')
packer.startup({
    function(use)
        local rpath = function(name)
            return string.format("require('plugins.%s')", name)
        end

        -- NVIM v0.7.2 released at 2022/06/26, next version 2022/09/30
        -- general
        use { 'EdenEast/nightfox.nvim', config = rpath('nightfox'), commit = "59c3dbcec362eff7794f1cb576d56fd8a3f2c8bb" }
        use { 'wbthomason/packer.nvim', commit = "6afb67460283f0e990d35d229fd38fdc04063e0a" }
        use { 'nvim-lua/plenary.nvim', commit = "9e7c62856e47053ec7b17f82c5da0f1e678d92c8" }
        use { 'Shatur/neovim-session-manager', config = rpath('session-manager'), commit = "4005dac93f5cd1257792259ef4df6af0e3afc213" }

        -- widget
        use { 'feline-nvim/feline.nvim', config = rpath('feline'), commit = "496975425a28ef1f974e90e9664fe3409738f071" }
        use { 'akinsho/bufferline.nvim', config = rpath('bufferline'), commit = "50448e99ead112e828259f97fa8ce19ad8078b0a" }
        use { 'glepnir/dashboard-nvim', config = rpath('dashboard'), commit = "1c4802a654c9127c745cbe2ffff9909a3a9ff965"  }
        use { 'nvim-treesitter/nvim-treesitter', config = rpath('nvim-treesitter'), commit = "aebc6cf6bd4675ac86629f516d612ad5288f7868" }
        use { 'simrat39/symbols-outline.nvim', config = rpath('symbols-outline'), commit = "6a3ed24c5631da7a5d418bced57c16b32af7747c" }
        use { "akinsho/toggleterm.nvim", config = rpath('toggleterm'), commit = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda" }
        use { 'nvim-tree/nvim-web-devicons', commit = "563f3635c2d8a7be7933b9e547f7c178ba0d4352" }
        use { 'nvim-tree/nvim-tree.lua', config = rpath('nvim-tree'), commit = "45d386a3591f87390390c0d718a81e05895465ca" }
        use { 'folke/trouble.nvim', config = rpath('trouble'), commit = "929315ea5f146f1ce0e784c76c943ece6f36d786" }
        use { 'rcarriga/nvim-notify', config = rpath('nvim-notify'), commit = "142069baf554c3d41c8de4a6f7472c618a58becc" }
        use { 'L3MON4D3/LuaSnip', commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84" }

        -- lsp & autocomplete
        use { 'neovim/nvim-lspconfig', commit = "af43c300d4134db3550089cd4df6c257e3734689" }
        use { 'hrsh7th/nvim-cmp', commit = "2427d06b6508489547cd30b6e86b1c75df363411" }
        use { 'hrsh7th/cmp-nvim-lsp', commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" }
        use { 'saadparwaiz1/cmp_luasnip', commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }
        use { 'lukas-reineke/lsp-format.nvim', commit = "b611bd6cea82ccc127cf8fd781a1cb784b0d6d3c" }

        -- debug 
        use { 'sakhnik/nvim-gdb', config = rpath('nvim-gdb'), commit = "4408d2c10618636101945e9cd9ef9d68fc335e19" }

        -- git
        use { 'sindrets/diffview.nvim', commit = "6baa30d0a6f63da254c2d2c0638a426166973976" }
        use { 'lewis6991/gitsigns.nvim', config = rpath('gitsigns'), commit = "f98c85e7c3d65a51f45863a34feb4849c82f240f" }
        use { 'TimUntersberger/neogit', config = rpath('neogit'), commit = "1843330963cc0299fd453145248681f3d33862b3" }

        -- edit
        use { 'tversteeg/registers.nvim', config = rpath('nvim-registers'), commit = "7e47d1a04ce1418edea1cc0a8decdbf4dfa660f2" }
        use { 'inkarkat/vim-ReplaceWithRegister', commit = "aad1e8fa31cb4722f20fe40679caa56e25120032" }
        use { 'preservim/nerdcommenter', config = rpath('nerdcommenter'), commit = "2a0a05ff983aa62d74ba868aadf89deb93dd5454" }
        use { 'nvim-pack/nvim-spectre', config = rpath('nvim-spectre'), commit = "6d877bc1f2262af1053da466e4acd909ad61bc18" }
        use { "lukas-reineke/indent-blankline.nvim", config = rpath('indent-blankline'), commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" }
        use { "nvim-telescope/telescope.nvim", config = rpath('telescope'), commit = "d4204618dddf1628e7a19ad4a7b910864d1120a5" }
        use { 'kevinhwang91/nvim-hlslens', config = rpath('nvim-hlslens'), commit = "5e6ea33cfdf8be57bb33146f1927b7723d3ddff6" }

    end,

    config = {
        git = {
            default_url_format = 'https://github.com/%s'
        }
    }
})
