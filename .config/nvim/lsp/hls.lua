return {
  -- Server-specific settings. See `:help lsp-quickstart`
  settings = {
    haskell = {
      plugin = {
        rename = {
          config = {
            crossModule = true
          }
        }
      }
    }
  }
}
