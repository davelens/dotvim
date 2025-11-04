return {
  'saghen/blink.cmp',
  version = '1.*',
  event = 'InsertEnter',
  opts_extend = { 'sources.default' },

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- Buggy at the time of installation, so disable for now.
    cmdline = { enabled = vim.fn.has('wsl') ~= 1 },
    -- Includes the defaults, but I want to be explicit about them.
    snippets = { preset = 'luasnip' },
    sources = {
      default = {
        'lsp',
        -- 'rails_routes',
        'path',
        'snippets',
        'buffer',
      },
      providers = {
        -- rails_routes = {
        --   module = 'config/lsp/rails_routes',
        -- },
        snippets = {
          -- Snippets beginning with ';' should always come out on top.
          -- Keeping until [#1340](https://github.com/Saghen/blink.cmp/issues/1340) is fixed.
          score_offset = function(tbl)
            return (tbl.line:sub(1, 1) == ';' and 1 or 200)
          end,
        },
      },
    },

    -- TODO: See about disabling completion menus in comments.

    -- Stick with the default Rust implementation for now.
    fuzzy = { implementation = 'prefer_rust_with_warning' },

    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      -- I define my own super-tab behaviour that works more consistently with
      -- the <Tab> keypress between open menus and snippet jumps.
      -- The default `super-tab` preset in blink.cmp straight up breaks regular
      -- default tab insertions, and doesn't behave as you'd expect within
      -- snippet jump contexts.
      --
      -- 1. Autocompletion menu visible, no selection.
      --    => nothing should happen.
      --
      -- 2. Autocompletion menu visible, selection made.
      --    => select + accept selection
      --
      -- 3. Snippet active, no autocompletion menu visible.
      --    => jump forward in snippet
      --
      -- 4. Snippet active, autocompletion menu visible, no selection.
      --    => jump forward in snippet
      --
      -- 5. Snippet active, autocompletion menu visible, selection made.
      --    => select + accept selection
      --
      -- 6. No autocompletion menu visible.
      --    => Feed default nvim <Tab> behaviour
      --
      -- The `enter` preset also enables <CR> to make selections.
      -- The rest of the defaults are sensible enough to live with.
      preset = 'enter',

      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      ['<Tab>'] = {
        function(cmp)
          local luasnip = require('luasnip')

          -- TODO: Extract the luasnip jumpable check and the <Tab> key feed
          -- to prevent repeating those bits.
          if cmp.is_menu_visible() then
            if cmp.get_selected_item() then
              cmp.select_and_accept()
            elseif luasnip.jumpable(1) then
              vim.schedule(function()
                luasnip.jump(1)
              end)
            else
              vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes('<Tab>', true, false, true),
                'n',
                false
              )
            end
          elseif luasnip.jumpable(1) then
            cmp.cancel()
            -- schedule() is needed to delay the jump until after blink closes.
            vim.schedule(function()
              luasnip.jump(1)
            end)
          else
            -- There is no cmp.fallback() in blink like nvim-cmp has, nor do
            -- the textual fallbacks seem to work. So I resorted to inserting
            -- a literal tab termcode myself to make the tab fallback work. -.-
            vim.api.nvim_feedkeys(
              vim.api.nvim_replace_termcodes('<Tab>', true, false, true),
              'n',
              false
            )
          end
        end,
      },
    },

    -- I prefer to see docs where available.
    completion = {
      documentation = { auto_show = true },
      list = {
        selection = {
          auto_insert = false,
          preselect = function(_)
            -- Preselect in embedded language filetypes only.
            return vim.tbl_contains(
              { 'eruby', 'heex', 'eelixir' },
              vim.bo.filetype
            )
          end,
        },
      },
    },
  },
}
