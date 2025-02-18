return { 
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  config = function()
    require(vim.colorscheme).setup({
      custom_highlights = {
        -- Override colors here, see the onenord plugin file for examples.
        -- Keeping this present until (if) I'm broken into catppuccin.
      },
    })

    vim.cmd("colorscheme " .. vim.colorscheme)
  end
}
