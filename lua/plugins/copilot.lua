return {
    {
      "zbirenbaum/copilot.lua",
  },
  {
  "zbirenbaum/copilot-cmp",
  config = function ()
    require("copilot_cmp").setup({
      filetypes = { "lua", "python", "javascript", "dart" }  -- Ensure Dart isn't missing here
      })
  end
}
}
