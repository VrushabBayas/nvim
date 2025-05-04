require('lualine').setup({
  options = {
    theme = 'auto',
    icons_enabled = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { statusline = {}, winbar = {} },
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { { 'mode', icon = '' } },
    lualine_b = {
      { 'branch', icon = '' },
      'diff',
      { 'diagnostics', sources = { 'nvim_diagnostic' } },
    },
    lualine_c = {
      {
        'filename',
        path = 1,
        symbols = {
          modified = ' 🟢',
          readonly = ' 🔒',
          unnamed = '[No Name]',
        }
      },
     -- {
     --   function()
     --     local dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
     --     return '🗂️ ' .. dir
     --   end,
     --   icon = '🗂️',
     --   color = { fg = '#7aa2f7' },
     -- },
    },
    lualine_x = {
      {
        function()
          local clients = vim.lsp.get_clients({ bufnr = 0 })
          if #clients == 0 then
            return ''
          end
          local names = {}
          for _, client in ipairs(clients) do
            table.insert(names, client.name)
          end
          return ' ' .. table.concat(names, ', ')
        end,
        icon = '',
        color = { fg = '#9ece6a' },
      },
      'encoding',
      'fileformat',
      'filetype',
    },
    lualine_y = {
      { 'progress', separator = ' ', padding = { left = 1, right = 1 } },
    },
    lualine_z = { { 'location', icon = '' } },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        'filename',
        path = 1,
      },
    },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { 'fugitive', 'lazy', 'nvim-tree', 'quickfix', 'toggleterm' },
})

