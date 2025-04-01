if true then
  return
end
-- Autocompletion
return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'saadparwaiz1/cmp_luasnip', -- Snippet engine glue towards nvim-cmp.
    'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp.
    'hrsh7th/cmp-path', -- Path source for nvim-cmp.
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    -- We need the vscode loaders to load in rafamadriz/friendly-snippets.
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup()
    luasnip.filetype_extend('ruby', { 'rails' }) -- Not enabled by default.

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = {
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<CR>'] = cmp.mapping(
          cmp.mapping.confirm({ select = true }),
          { 'i', 'c' }
        ),

        -- I expect <Tab> to behave as following in insert mode:
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
        ['<Tab>'] = cmp.mapping(function(fallback)
          local copilot = require('copilot.suggestion')

          if copilot.is_visible() then
            copilot.accept()
          elseif cmp.visible() then
            -- I chose to not use <Tab> for navigation here considering I
            -- already use <C-p> / <C-n>, but I'll leave the snippet in case
            -- I ever change my mind.
            --cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            if cmp.get_selected_entry() then
              cmp.mapping.confirm({ select = true })({ 'i', 'c' })
            else
              return
            end
          elseif luasnip.expandable() then
            luasnip.expand()
          else
            fallback()
          end
        end, { 'i', 's' }),

        -- This makes it so the autocompletion floats are scrollable.
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        -- Whenever a nvim-cmp autocompletion float is active, I want to be
        -- able to navigate through the suggestions using <C-p> and <C-n> BUT
        -- any Github Copilot suggestions should then be hidden.

        ['<C-p>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            vim.b.copilot_suggestion_hidden = true
            cmp.mapping.select_prev_item()({ 'i', 'c' })
          else
            fallback()
          end
        end),

        ['<C-n>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            vim.b.copilot_suggestion_hidden = true
            cmp.mapping.select_next_item()({ 'i', 'c' })
          else
            fallback()
          end
        end),
      },

      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
      },
    })

    -- We hide the suggestions whenever we're navigating inside the
    -- autocompletion floats, so we need to stop hiding them whenever we're
    -- done with the autocompletion float.
    cmp.event:on('menu_closed', function()
      vim.b.copilot_suggestion_hidden = false
    end)
  end,
}
