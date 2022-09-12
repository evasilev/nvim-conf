local map = vim.api.nvim_set_keymap
local dopts = {noremap = true, silent = true}

vim.g.mapleader = ' '

-- System clip shift+Y
map('v', 'S-Y', '"+y', {})

-- disable arrows, use only hjkl
map('', '<up>', ':echoe "Use k"<CR>', {noremap = true, silent = false})
map('', '<down>', ':echoe "Use j"<CR>', {noremap = true, silent = false})
map('', '<left>', ':echoe "Use h"<CR>', {noremap = true, silent = false})
map('', '<right>', ':echoe "Use l"<CR>', {noremap = true, silent = false})

map('n', '<F5>', ':exec &nu==&rnu? "se nu!" : "se rnu!"<CR>', dopts)

-- simple indention
map('v', '>', '>gv', dopts)
map('v', '<', '<gv', dopts)

-- unbind Q
map('n', 'Q', '<nop>', dopts)

--
map('n', '<leader>h', ':wincmd h<CR>', {noremap = true, silent = false})
map('n', '<leader>pv', ':wincmd v<bar> :Ex <bar> :vertical resize 30<CR>', {noremap = true, silent = false})


RefreshGuiFont = function()
  vim.opt.guifont = string.format("%s:h%s",vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
  vim.g.gui_font_size = vim.g.gui_font_size + delta
  RefreshGuiFont()
end

ResetGuiFont = function ()
  vim.g.gui_font_size = vim.g.gui_font_default_size
  RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

-- Keymaps
vim.keymap.set({'n', 'i'}, '<C-+>', function() ResizeGuiFont(1)  end, dopts)
vim.keymap.set({'n', 'i'}, '<C-->', function() ResizeGuiFont(-1) end, dopts)
vim.keymap.set({'n', 'i'}, '<C-BS>', function() ResetGuiFont() end, dopts)
