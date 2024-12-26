-- AI pair programmer :x
return {
  'zbirenbaum/copilot.lua', 
  config = function()
    vim.api.nvim_set_hl(0, 'CopilotSuggestion', { fg = '#83a598' })
    vim.api.nvim_set_hl(0, 'CopilotAnnotation', { fg = '#83a598' })

    require('copilot').setup({
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<C-l>",
          --next = "<C-u>",
          --prev = "<C-i>",
          --dismiss = "<C-]>",
        },
      },
    })
  end
}
