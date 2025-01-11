-- https://github.com/tpope/vim-markdown/issues/21
-- underscores ("_") are highlighted in markdown as error
-- this prevents the highlight
vim.cmd [[ syn match markdownError "\w\@<=\w\@=" ]]
