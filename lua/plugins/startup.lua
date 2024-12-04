return {
    {'nvim-telescope/telescope-ui-select.nvim'},
    {"nvim-telescope/telescope.nvim",
     dependencies = {
         {"nvim-telescope/telescope-fzf-native.nvim",
          build = "make",
          config = function()
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("ui-select")
          end,
          },
          "nvim-telescope/telescope-live-grep-args.nvim",

        },
    },
    {"nvim-telescope/telescope-file-browser.nvim"},
    {"nvim-lua/plenary.nvim"},
    {
        "startup-nvim/startup.nvim",
  }
}
