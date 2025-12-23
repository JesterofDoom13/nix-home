return {
  'arakkkkk/kanban.nvim',
  -- Optional
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  keys = {
    { '<leader>mk', '<cmd>KanbanOpen ~/Documents/.vaults/', desc = 'Kanban Primary' },
  },

  opts = {
    markdown = {
      description_folder = './.', -- Path to save the file corresponding to the task.
      list_head = '## ',
    },
  },
}
