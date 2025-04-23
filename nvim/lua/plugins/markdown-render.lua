return {
  { "ryleelyman/latex.nvim", opts = {} },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
    opts = {
      latex = { enabled = false },
      win_options = { conceallevel = { rendered = 2 } },
    },
  },
}
