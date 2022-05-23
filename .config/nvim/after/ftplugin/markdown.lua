-- TODO: mappings for VV
vim.keymap.set("n", "<A-m>", "<Plug>MarkdownPreview", { buffer = true, remap = true })
vim.keymap.set("n", "<A-M>", "<Plug>StopMarkdownPreview", { buffer = true, remap = true })

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = [[v:lua.require'delphinus.markdown'.foldexpr()]]
vim.opt.foldtext = [[v:lua.require'delphinus.markdown'.foldtext()]]
