return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        harper_ls = {
          filetypes = { 'markdown' }, -- Force only Markdown
          -- Optional: you can also configure Harper's internal settings here
          settings = {
            ['harper-ls'] = {
              userDictPath = vim.fn.stdpath 'config' .. '/spell/harper_dict.txt',
            },
          },
        },
      },
    },
  },
}
