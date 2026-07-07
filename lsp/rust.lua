return {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', 'rust-project.json' },
  settings = {
    ['rust-analyzer'] = {
      cargo = { allFeatures = true },
      -- Modern rust-analyzer schema: checkOnSave is a boolean, and the checker
      -- command lives under `check`.
      checkOnSave = true,
      check = { command = 'clippy' },
    },
  },
}
