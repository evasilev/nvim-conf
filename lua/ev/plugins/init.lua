local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git', 
    'clone', 
    '--depth', 
    '1', 
    'https://github.com/wbthomason/packer.nvim', 
    install_path
  })
  print('Press Enter to install packer and plugins')
  print('After install -- close and reopen Neovim to load conf')
  print(install_path)
  vim.cmd [[packadd packer.nvim]]
end

-- use a protected call
local present, packer = pcall(require, 'packer')

if not present then
  return
end

return packer.startup {
  function(use)
    -- Core
    use { 'wbthomason/packer.nvim', opt = true }
    use { 'nvim-lua/plenary.nvim', module_pattern = 'plenary.*' }
    use 'nvim-lua/popup.nvim'

    -- Colorschemes
    use 'shaunsingh/nord.nvim'
    use 'folke/tokyonight.nvim'
    
    use {
      'kyazdani42/nvim-web-devicons', 
      config = function()
        require('nvim-web-devicons').setup({
          override = {},
          default = true
        })
      end
    }

    use { 
      'nvim-lualine/lualine.nvim',
       requires = { 'kyazdani42/nvim-web-devicons' }, 
      config = function()
        require('ev.plugins.lualine')
      end, 
    }

    use { 
      'goolord/alpha-nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function ()
        require('alpha').setup(require('alpha.themes.startify').opts)
        local startify = require('alpha.themes.startify')
        startify.section.mru_cwd.val = {{ type = 'padding', val = 0 }}
        startify.section.bottom_buttons.val = {
          startify.button('e', 'new file', ':ene <bar> startinsert <cr>'),
          startify.button('v', 'neovim config', ':e ~/.config/nvim/init.lua<cr>'),
          startify.button('q', 'quit nvim', ':qa<cr>'),
        }  
        vim.api.nvim_set_keymap('n', '<c-n>', ':Alpha<cr>', {noremap = true})
      end
    }

    use {
      'kyazdani42/nvim-tree.lua',
      requires = { 'kyazdani42/nvim-web-devicons' },  -- optional, for file icons
      tag = 'nightly', -- optional, updated every week. (see issue #1193)
      config = function()
        require('nvim-tree').setup{
          sync_root_with_cwd = true,
          respect_buf_cwd = true,
          update_focused_file = {
            enable = true,
            update_root = true
          },
          actions = {
            open_file = {
              quit_on_open = true,
            },
          },
        }

        vim.api.nvim_set_keymap(
        'n', 
        '<leader>vv', 
        [[:NvimTreeToggle<CR>]], 
        { noremap = true, silent = true }
        )
        vim.api.nvim_set_keymap(
        'n', 
        '<leader>tf', 
        [[:NvimTreeFindFile<CR>]], 
        { noremap = true, silent = true }
        )
      end
    }

    use {
      'nvim-telescope/telescope.nvim',
      event = 'VimEnter',
      config = function()
        require('ev.plugins.telescope')
      end,
      requires = {
        { 'nvim-telescope/telescope-fzf-native.nvim', run = "make" },
        { 'nvim-telescope/telescope-file-browser.nvim' },
        { 'nvim-telescope/telescope-live-grep-raw.nvim' },
      }
    }

    -- Tree sitter
    use { 
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        require('ev.plugins.treesitter')
      end,
    }

    use {
      "ahmedkhalf/project.nvim",
      config = function()
        require("project_nvim").setup()
      end
    }

    -- lsp

    use {
      'neovim/nvim-lspconfig',
      event = 'BufReadPre',
      config = function()
        require('ev.plugins.lsp')
      end,
    }

    use {                                                                       
      'williamboman/nvim-lsp-installer',                                        
      config = function()
        require('ev.plugins.lsp-installer')
      end,
      after = 'nvim-lspconfig'
    }

    use {
      'jose-elias-alvarez/null-ls.nvim',
      module = 'null-ls',
      after = 'nvim-lspconfig'
    }

    use {
      'folke/trouble.nvim',
      after = 'nvim-lspconfig',
      cmd = { 'Trouble', 'TroubleToggle' },
      config = function()
        require('trouble').setup {
          auto_close = true
        }
      end,
    }

    -- ?????????????????????? ?????? ???????????? ????????????????????????????
    -- ???????????? ???????????????????????????? ?????? LSP
    use {
      'hrsh7th/nvim-cmp',
      event = { 'InsertEnter', 'CmdLineEnter' },
      config = function()
        require('ev.plugins.cmp')
      end,
      wants = { 'LuaSnip' },
      requires = {
        { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-lspconfig' },
        { 'f3fora/cmp-spell', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
        { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
      },
    }

    use {
      'L3MON4D3/LuaSnip',
      event = 'InsertEnter',
      config = function()
        require('ev.plugins.snippets')
      end,
    }

    use {
      'ray-x/go.nvim',
      requires = {
        { 'ray-x/guihua.lua' },
      },
      config = function()
        require('go').setup()
      end
    }

    use({
      'ray-x/navigator.lua',
      requires = {
        { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
        { 'neovim/nvim-lspconfig' },
      },
    })

    use {
      'akinsho/toggleterm.nvim',
      config = function()
        require('toggleterm').setup({
          direction = 'float'
        })
        vim.api.nvim_set_keymap(
        'n', 
        'ttm', 
        ':ToggleTerm<cr>', 
        { noremap = true, silent = true }
        )
        vim.api.nvim_set_keymap(
        't', 
        '<c-o>', 
        [[<C-\><C-n>]], 
        { noremap = true, silent = true }
        )
      end
    }

    use 'tpope/vim-surround'
    use {
      'windwp/nvim-autopairs',
      config = function ()
        require('nvim-autopairs').setup({
          disable_filetype = { 'TelescopePrompt' , 'vim' }
        })
      end
    }

    -- Hotkeys helpt
    use {
      'folke/which-key.nvim',
      config = function()
        require('which-key').setup()
      end
    }

    use {
      'mattn/emmet-vim'
    }

    use {
      'iloginow/vim-stylus'
    }

    use {
      'ianks/vim-tsx'
    }

    use {
      'leafgarland/typescript-vim'
    }
    -- Automatically set up conf after cloning packer.nvim
    if packer_bootstrap then
      require('packer').sync()
    end
  end,

  -- packer config
  log = { level = 'info' },
  config = {
    display = { prompt_border = 'single' },
    profile = { enable = true, threshold = 0 }
  },
}
