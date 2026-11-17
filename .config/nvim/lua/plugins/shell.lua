-- LazyVim has no shell extra, and nearly every demo repo ships a few .sh scripts.
return {
  { "neovim/nvim-lspconfig", opts = { servers = { bashls = {} } } },
}
