return { 
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  config = function()
    require(vim.colorscheme).setup({
      custom_highlights = {
        -- Override colors here, see the onenord plugin file for examples.
      },
    })

    vim.cmd("colorscheme " .. vim.colorscheme)
  end
}
