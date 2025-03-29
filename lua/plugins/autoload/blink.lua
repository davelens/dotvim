return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- These are the defaults for now, but I want to be explicit about them.
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- Stick with the default Rust implementation for now.
    fuzzy = { implementation = "prefer_rust_with_warning" },

    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = 'none',
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      -- My main Esc mapping is C-[ - using that here preserves insert mode.
      ['<C-[>'] = { 'hide', 'fallback' },
      ['<CR>'] = { 'select_and_accept', 'fallback_to_mappings' },

      -- <Tab> behaviour in insert mode:
      --
      -- 1. Without autocompletion floats active or Copilot suggestions,
      --    I want a literal tab to be inserted.
      --
      -- 2. With an autocompletion float active and no Copilot suggestions,
      --    and no autocomplete selections made, nothing should happen.
      --
      -- 3. With an autocompletion float active and no Copilot suggestions,
      --    but an autocomplete selection was made, it should confirm the
      --    autocomplete selection.
      --
      -- 4. With an autocompletion float active and a Copilot suggestion,
      --    it should accept the Copilot suggestion.
      --
      -- 5. With an autocompletion float active and a Copilot suggestion,
      --    the moment I navigate within the autocompletion float, it
      --    should hide Copilot suggestions. Otherwise it would start
      --    making suggestions on the autocompletion selections that get
      --    autoinserted at the cursor, which is confusing.
      --
      ['<Tab>'] = {
        function(cmp)
          local copilot = require('copilot.suggestion')

          if copilot.is_visible() then
            copilot.accept()
          elseif cmp.is_menu_visible() then
            if cmp.get_selected_item() then
              cmp.select_and_accept()
            else
              return
            end
          -- TODO:
          -- elseif luasnip.expandable() then
          --   luasnip.expand()
          else
            -- There is no cmp.fallback() in blink like nvim-cmp has, nor do 
            -- the textual fallbacks work at this point. So I need to insert
            -- a literal tab termcode myself to make tab work. Not ideal, but
            -- it works.
            vim.api.nvim_feedkeys(
              vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 
              'n', 
              false
            )
          end
        end
      },

      -- TODO: Find a way to re-enable the suggestion after initial hide.
      ['<C-p>'] = {
        function(cmp)
          if cmp.is_menu_visible() then
            vim.b.copilot_suggestion_hidden = true
            cmp.select_prev()
          end
        end,
        'fallback_to_mappings' 
      },

      -- TODO: Find a way to re-enable the suggestion after initial hide.
      ['<C-n>'] = {
        function(cmp)
          if cmp.is_menu_visible() then
            vim.b.copilot_suggestion_hidden = true
            cmp.select_next()
          end
        end,
        'fallback_to_mappings'
      },

      -- Less finger-wrecking than C-b/f
      ['<S-k>'] = { 'scroll_documentation_up', 'fallback' },
      ['<S-j>'] = { 'scroll_documentation_down', 'fallback' },

      ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
    },

    -- I prefer to see docs where available.
    completion = { documentation = { auto_show = true } },
  },
  opts_extend = { "sources.default" }
}
