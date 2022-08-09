local present, lualine = pcall(require, 'lualine')
if not present then
    return
end

lualine.setup {
  options = {
    icons_enabled = true,
    globalstatus = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'NeogitStatus', 'Packer' },
  },
  sections = {
    lualine_a = { 'branch' },
    lualine_b = {
      {
        'filename',
        path = 1,
      }
    },
    lualine_c = { 'diagnostics' },
    lualine_x = {},
    lualine_y = { 'diff' } ,
    lualine_z = { 'encoding' },
  },
}
