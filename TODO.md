- [x] Fix <Tab> behaviour by writing custom logic for nvim-cmp.
      => Wrote custom logic

- [x] vim-endwise does not work; find a solution

      => Used nvim-treesitter-endwise instead.

- [x] No more selectable ruby block textobjects available for motions. 
nelstrom/vim-textobj-rubyblock does not work in Lua, so find a modern solution.

      => nvim-treesitter-textobjects has support for ruby blocks, but it works
          differently than vim-textobj-rubyblock. The latter can handle
          both blocks and methods using "b", but treesitter only handles
          literal blocks. Methods are handled using "f".
          

- [x] nvim-ts-autotag does not properly format tags when they autoclose. I want:

      ```html
      <!-- After pressing ">" I expect to get a newline + autoclose -->
      <!-- Auto-formatting would also be nice. -->
      <ul> 
        CURSOR
      </ul>
      ```

      => I'll keep using vim-closetag for now. It just feels better.
         I'm leaving nvim-ts-autotag installed though.

- [ ] Elixir's Intellisense autocomplete seems worse than I remember it being 
      with coc-elixir. See/ask around on Discord how I can improve this.

- [ ] See if nvim-cmp and Copilot issues I had could be solved using zbirenbaum/copilot-cmp instead.

