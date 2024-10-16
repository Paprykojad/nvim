require('code_runner').setup({
  filetype = {
    java = {
      "cd $dir &&",
      "javac $fileName &&",
      "java $fileNameWithoutExt"
    },
    python = "python3 -u",
    typescript = "deno run",
    javascript = "node",
    go = {
	"go run .",
	-- "go run $dir/$fileName",
    },
    rust = {
      "cd $dir &&",
      "rustc $fileName &&",
      "$dir/$fileNameWithoutExt"
    },
    cpp = {
      "cd $dir &&",
      "g++ -o $fileNameWithoutExt $fileName &&",
      "$dir/$fileNameWithoutExt"
    },
    c = {
      "cd $dir &&",
      "gcc -o $fileNameWithoutExt $fileName &&",
      "$dir/$fileNameWithoutExt"
    },
    cs = {
        "dotnet build && dotnet run"
    },
    -- cpp = {
    --   "cd $dir &&",
    --   "make $fileNameWithoutExt", 
    --   "$dir/$fileNameWithoutExt"
    -- },
    -- c = {
    --   "cd $dir &&",
    --   "make $fileNameWithoutExt", 
    --   "$dir/$fileNameWithoutExt"
    -- },
    html = {"firefox $dir/$fileName"}
    -- html = {"chromium $dir/$fileName"}
  },
})

vim.keymap.set('n', '<leader>v', ':RunCode<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rft', ':RunFile tab<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rc', ':RunClose<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>crf', ':CRFiletype<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>crp', ':CRProjects<CR>', { noremap = true, silent = false })
