-- AI pair programmer :x
return {
  'zbirenbaum/copilot.lua', 
  config = function()
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
