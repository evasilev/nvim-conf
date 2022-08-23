local cmd = vim.cmd		-- execute Vim commands
local exec = vim.api.nvim_exec  -- execute Vimscript

local g = vim.g                 -- global variables
local opt = vim.opt             -- global/buffer/windows-scoped options

-- Main settings
opt.colorcolumn = '80'            -- Разделитель на 80 символов
opt.cursorline = true        -- Подсветка строки с курсором
-- opt.spelllang= { 'en_us', 'ru' }    -- Словари рус eng
opt.number = true                   -- Включаем нумерацию строк
opt.numberwidth = 2
opt.ruler = false
opt.relativenumber = false           -- Вкл. относительную нумерацию строк
opt.so=999                          -- Курсор всегда в центре экрана
opt.undofile = true                 -- Возможность отката назад
opt.splitright = true               -- vertical split вправо
opt.splitbelow = true               -- horizontal split вниз

-- color scheme
opt.termguicolors = true            --  24-bit RGB colors
cmd([[ colorscheme tokyonight ]])

opt.listchars = "eol:↲,tab:» ,trail:·,extends:<,precedes:>,conceal:┊,nbsp:␣"
opt.langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"


-- indention
cmd([[
filetype indent plugin on
syntax enable
]])
opt.expandtab = true      -- use spaces instead of tabs
opt.shiftwidth = 4        -- shift 4 spaces when tab
opt.tabstop = 4           -- 1 tab == 4 spaces
opt.smartindent = true    -- autoindent new lines
-- 2 spaces for selected filetypes
cmd([[
autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml,htmljinja setlocal shiftwidth=2 tabstop=2
]])

-- Подсвечивает на доли секунды скопированную часть текста
exec([[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup end
]], false)

if g.neovide then
  g.neovide_refresh_rate = 60
  -- g.neovide_transparency = 0.8
  -- g.neovide_floating_blur_amount_x = 2.0
  -- g.neovide_floating_blur_amount_y = 2.0
  g.neovide_cursor_animation_length = 0.01
  g.neovide_cursor_vfx_mode = "pixiedust"
  g.neovide_cursor_vfx_particle_density = 7.0
  g.neovide_input_use_logo = true
--  vim.g.neovide_background_color = '#f01117'.printf('%x', float2nr(255 * g:transparency))
end

opt.guifont = { "JetBrainsMono NF", "h12" }
