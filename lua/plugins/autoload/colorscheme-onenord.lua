return {
  "rmehri01/onenord.nvim",
  lazy = false,
  config = function()
    local colors = require('homebrew.colors')

    require('onenord').setup({
      borders = true,
      fade_nc = false,
      styles = {
        strings = "NONE",
        keywords = "NONE",
        functions = "NONE",
        variables = "NONE",
        diagnostics = "italic",
      },
      disable = {
        background = false,
        cursorline = false,
        eob_lines = true,
      },
      custom_highlights = {
        -- Examples
        -- LspDiagnosticsUnderlineInformation = { style = config.styles.diagnostics, sp = colors.info },
        -- ["@text.uri"] = { fg = colors.cyan, style = "underline" },
        -- Todo = { fg = colors.yellow, bg = colors.none, style = "bold,italic" },
        -- DiagnosticError = { link = "LspDiagnosticsDefaultError" },

        -- Nvim Core
        Folded = { fg = colors.grey10 },
        -- VertSplit = { fg = colors.lblue },
        -- MsgArea = { fg = colors.grey7 },
        -- NormalFloat = { bg = colors.grey14 },
        -- FloatBorder = { bg = colors.grey14, fg = colors.grey14 },
        -- IncSearch = { style = "reverse" },

        -- LSP Document Highlights
        LspReferenceText = { bg = colors.grey11, style = "none" },
        LspReferenceRead = { link = "LspReferenceText", style = "none" },
        LspReferenceWrite = { link = "LspReferenceText", style = "none" },

        -- Better Quick List
        BqfPreviewFloat = { bg = colors.bg_dark },
        BqfPreviewBorder = { bg = colors.bg_dark, fg = colors.magenta },
        BqfPreviewTitle = { bg = colors.bg_dark, fg = colors.magenta },
        -- BqfPreviewThumb
        -- BqfPreviewSbar
        -- BqfPreviewCursor
        -- BqfPreviewCursorLine
        -- BqfPreviewRange
        -- BqfPreviewBufLabel

        -- Whichkey
        WhichKeyFloat = { bg = colors.grey14 },
        WhichKey = { fg = colors.magenta },
        WhichKeyGroup = { fg = colors.grey7 },
        WhichKeySeparator = { fg = colors.grey12 },
        WhichKeyDesc = { fg = colors.grey7 },
        WhichKeyValue = { fg = colors.grey7 },

        -- Color columns
        VirtColumn = { bg = colors.bg_dark, fg = colors.grey13 },
        NonText = { fg = colors.grey13 },

        --
        IblIndent = { fg = colors.grey13 },

        -- Buffer Line
        -- BufferLineIndicatorSelected = { fg = colors.cyan, bg = colors.bg_dark },
        -- BufferLineFill = { fg = colors.fg, bg = colors.grey14 },

        -- Git Signs
        GitSignsAdd = { fg = colors.green },
        GitSignsChange = { fg = colors.yellow },
        GitSignsDelete = { fg = colors.red },

        GitConflictCurrent = { bg = colors.green, fg = colors.fg },
        GitConflictCurrentLabel = { bg = colors.green, fg = colors.fg },
        GitConflictIncoming = { bg = colors.red, fg = colors.bg_dark },
        GitConflictIncomingLabel = { bg = colors.red, fg = colors.bg_dark },

        -- Lualine
        StatusLine = { bg = colors.bg_dark },
        StatusLineNC = { bg = colors.bg_dark },
        StatusLineTerm = { bg = colors.bg_dark },

        -- Telescope
        -- https://github.com/nvim-telescope/telescope.nvim/blob/master/plugin/telescope.lua
        --TelescopeMatching = { fg = colors.magenta_light }, -- sections which match the search
        --TelescopePreviewBorder = { bg = colors.bg_dark, fg = colors.magenta },
        --TelescopePreviewNormal = { bg = colors.bg_dark, fg = colors.magenta },
        --TelescopePreviewTitle = { bg = colors.bg_dark, fg = colors.magenta },

        --TelescopePromptNormal = { bg = colors.bg_dark },
        --TelescopePromptBorder = { bg = colors.bg_dark, fg = colors.magenta },
        --TelescopePromptPrefix = { bg = colors.bg_dark },
        --TelescopePromptTitle = { fg = colors.magenta },

        --TelescopeResultsBorder = { bg = colors.bg_dark, fg = colors.magenta },
        --TelescopeResultsNormal = { fg = colors.grey9, bg = colors.bg_dark }, -- results returned

        -- -- The current item
        --TelescopeSelection = { fg = colors.magenta },
        --TelescopeSelectionCaret = { fg = colors.magenta },

        -- Snacks picker
        -- TODO: The path excluding the filename is currently too grey, so
        -- see about adjusting that.
        SnacksPickerDir = { fg = colors.grey7 },
      }
    })
    
    -- Set the inactive background color after everything else.
    --vim.api.nvim_set_hl(0, 'NormalNC', { bg = colors.bg_inactive })

  end
}
