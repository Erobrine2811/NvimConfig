vim.opt.completeopt = { "menu", "menuone", "preview", "noselect" }

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

local has_words_after = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line, col, line, -1, {})[1]:match("^%s*$") == nil
end

local lspkind = require("lspkind")
lspkind.init()


local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, {desc = "Open diagnostics", unpack(opts)})
    -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, {desc = "Next diagnostic", unpack(opts)})
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, {desc = "Previous diagnostic", unpack(opts)})

    -- vim.keymap.set("n", "<leader>lca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>lrn", function() vim.lsp.buf.rename() end, opts)
end)

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
        htmx = function()
            require('lspconfig').htmx.setup({})
        end
        -- pyright = function()
        --     print(lsp_zero)
        --     local pyright_opts = lsp_zero.nvim_pyright({
        --         settings = {
        --             pyright = { autoImportCompletion = true, },
        --             python = { analysis = { autoSearchPaths = true, diagnosticMode = 'openFilesOnly', useLibraryCodeForTypes = true, typeCheckingMode = 'off' } }
        --         }
        --     })
        --     print(pyright_opts)
        --     require('lspconfig').pyright.setup(pyright_opts)
        -- end,
    }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = "copilot", group_index = 1 },
        -- { name = 'nvim_lua' },
        { name = 'luasnip',   keyword_length = 2 },
        { name = 'path' },
        { name = 'buffer',    keyword_length = 3 },
        -- { name = "copilot" }, -- , group_index = 1 }, -- Only show when no LSP results
    },
    formatting = lsp_zero.cmp_format({
    format = require("nvim-highlight-colors").format
  }),
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = vim.schedule_wrap(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end),
        ['<S-Tab>'] = vim.schedule_wrap(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end),
        ['<C-Enter>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true
            },
            { "i", "c" }
        ),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),

    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
})

local ls = require("luasnip")
require("luasnip.loaders.from_lua").lazy_load()
ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
})

-- Snippet keybindings
vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })
