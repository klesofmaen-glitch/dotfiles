-- [ НАСТРОЙКИ ИНТЕРФЕЙСА ]
local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.clipboard = "unnamedplus"
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
vim.g.mapleader = " "

-- [ УСТАНОВКА LAZY.NVIM ]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
end
vim.opt.rtp:prepend(lazypath)

-- [ ПЛАГИНЫ ]
require("lazy").setup({
  { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
  { "nvim-tree/nvim-web-devicons", lazy = false },

  -- Стартовый экран (Минимализм под Noto)
  {
    'goolord/alpha-nvim',
    config = function ()
        local alpha = require'alpha'
        local dashboard = require'alpha.themes.dashboard'
        
        dashboard.section.header.val = {

[[　'　,,/　 ヽ ヽﾞ､、 ヽ　ヽ ＼ヽ　､                 ]],
[[　 // 　 　 ﾞ､ヽヽ、 ﾞ､　 '､　＼'､ヽ                 ]],
[[　!! !　　　　 ',　'､',ヽ、ヽ　'､　 ヽ', ＼        ]],
[[　l ',l　　　　　',　 'i_,.､ゝ','､ ', 　 ヽ!       ]],
[[　い'､＿　　　 X"､;==ミ_ ＼!　　 i!、              ]],
[[　ヽﾞ､_､,,,_ヽ　　 ｀'iﾞ､)::::ﾞi｀'　|　　 iﾄ､        ]],
[[ヽ､ヽ','ﾞﾄバ ,　　　ヽ:;;;;ノ ,　 !　　/,>          ]],
[[ヾ'､'､_',.ﾐ;;ｼﾉ　　　｀`'''''´"　,'　/,/ム         ]],
[[　｀ヽい、　ヽ‐　 　 ,.．　　/ ,ｨ/_ゝr' ﾉ          ]],
[[　　　 ヾ'、 ﾌ７'"ﾌ´　　　/ ,ｲ,ヶ-‐ﾂ′              ]],
[[　　　　　ヽヽ-‐'′　 　 ,! i ! !{i　 {i（          ]],
[[　　　 　 　 ｀i ､_　_,、:.'':.:い!i ヾ､__ヾ       ]],
[[　　　　　　-'ノ / ） ,ﾊ　 :.ヽゝ､_ｯr''"           ]],
[[　　　 　 　 `ｰ'∠ノ_,.,!　 　 r''ｒ' _,.-          ]],
[[　　　　　　 ,r`;==´､ノ 　 〃/／                   ]], 
        }

        dashboard.section.buttons.val = {
            dashboard.button("f", "󰮗  Поиск файлов", ":Telescope find_files <CR>"),
            dashboard.button("r", "󰋚  Недавние", ":Telescope oldfiles <CR>"),
            dashboard.button("s", "󰒓  Конфигурация", ":e ~/.config/nvim/init.lua <CR>"),
            dashboard.button("q", "󰈆  Выход", ":qa<CR>"),
        }
        dashboard.opts.layout[1].val = 8
        alpha.setup(dashboard.opts)
    end
  },

  -- Чистый статусбар без лишних деталей
  { 
    "nvim-lualine/lualine.nvim", 
    opts = { 
      options = { 
        theme = 'tokyonight',
        globalstatus = true,
        component_separators = { left = ' ', right = ' '},
        section_separators = { left = ' ', right = ' '},
      } 
    } 
  },

  -- Дерево файлов
  { 
    "nvim-neo-tree/neo-tree.nvim", 
    branch = "v3.x", 
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
    opts = {
      default_component_configs = {
        indent = { with_markers = false },
        icon = { folder_closed = "󰉋", folder_open = "󰝰", default = "󰈚" },
      }
    },
    config = function(_, opts)
        require("neo-tree").setup(opts)
        vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>') 
    end 
  },

  -- Тонкие вкладки
  { 
    "akinsho/bufferline.nvim", 
    opts = { 
      options = { 
        separator_style = "thin",
        show_buffer_close_icons = false,
        modified_icon = "●",
      } 
    } 
  },

  -- Синтаксис и Поиск
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", opts = { ensure_installed = {"lua", "nix"}, highlight = {enable = true} } },
  { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } }
})

-- [ ЦВЕТОВАЯ СХЕМА ]
vim.cmd[[colorscheme tokyonight]]
local bg_color = "#25212e"
local hl_groups = { 
    "Normal", "NormalFloat", "NormalNC", "NeoTreeNormal", "NeoTreeNormalNC", 
    "SignColumn", "MsgArea", "AlphaHeader", "TelescopeBorder", "BufferLineFill" 
}
for _, g in ipairs(hl_groups) do vim.api.nvim_set_hl(0, g, { bg = bg_color }) end

-- Акценты под Noto (более мягкие)
vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#9ece6a", bold = true })
vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#7aa2f7" })
