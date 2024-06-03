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
    local gs = require("gitsigns")

    local function map(mode, lhs, rhs, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gs.nav_hunk("next")
      end
    end)

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end)

    map("n", "tb", function() gs.blame_line({ full = true }) end)
    map("n", "td", gs.diffthis)
    map("n", "tp", gs.preview_hunk)
    map("n", "tr", gs.reset_hunk)
    map("v", "tr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
    map("n", "tR", gs.reset_buffer)
    map("n", "ts", gs.stage_hunk)
    map("v", "ts", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
    map("n", "tS", gs.stage_buffer)
    map("n", "tu", gs.undo_stage_hunk)
    map("n", "tt", gs.toggle_deleted)

    map({"o", "x"}, "t", ":<c-u>Gitsigns select_hunk<cr>")
  end
})
EOF

highlight GitSignsAdd    ctermfg=darkgreen
highlight GitSignsChange ctermfg=darkyellow
highlight GitSignsDelete ctermfg=darkred

highlight GitSignsAddInline    ctermbg=green
highlight GitSignsChangeInline ctermbg=yellow
highlight GitSignsDeleteInline ctermbg=red
