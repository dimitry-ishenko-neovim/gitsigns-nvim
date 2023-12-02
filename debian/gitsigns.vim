lua << EOF
require("gitsigns").setup({
  signs = {
    add          = { text = "┃" },
    change       = { text = "┃" },
    delete       = { text = "╽" },
    topdelete    = { text = "╿" },
    changedelete = { text = "┃" },
    untracked    = { text = "┆" },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, lhs, rhs, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    map("n", "]c", function()
      if vim.wo.diff then return "]c" end
      vim.schedule(gs.next_hunk)
      return "<Ignore>"
    end, { expr = true })

    map("n", "[c", function()
      if vim.wo.diff then return "[c" end
      vim.schedule(gs.prev_hunk)
      return "<Ignore>"
    end, { expr = true })

    map("n", "<leader>hb", function() gs.blame_line({ full = true }) end)
    map("n", "<leader>hd", gs.diffthis)
    map("n", "<leader>hp", gs.preview_hunk)
    map("n", "<leader>hr", gs.reset_hunk)
    map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
    map("n", "<leader>hR", gs.reset_buffer)
    map("n", "<leader>hs", gs.stage_hunk)
    map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
    map("n", "<leader>hS", gs.stage_buffer)
    map("n", "<leader>hu", gs.undo_stage_hunk)
    map("n", "<leader>td", gs.toggle_deleted)

    map({"o", "x"}, "ih", ":<c-u>Gitsigns select_hunk<cr>")
  end
})
EOF

highlight GitSignsAdd    ctermfg=darkgreen
highlight GitSignsChange ctermfg=darkyellow
highlight GitSignsDelete ctermfg=darkred
