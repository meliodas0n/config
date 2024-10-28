-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      -- add more arguments for adding more treesitter parsers
      "python",
      "bash",
      "c",
      "cpp",
      "typescript",
      "scala",
    },
  },
}
