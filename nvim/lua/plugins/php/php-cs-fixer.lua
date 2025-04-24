 return {
  'stephpy/vim-php-cs-fixer',
  ft = 'php',
  config = function()
    vim.g.php_cs_fixer_path = os.getenv("HOME") .. "/.composer/vendor/bin/php-cs-fixer"
    vim.g.php_cs_fixer_enable_default_mapping = 0 -- desabilita mapeamentos padrões
    vim.api.nvim_create_user_command("PhpCsFixerFix", function()
       vim.cmd("!php-cs-fixer fix " .. vim.fn.shellescape(vim.fn.expand("%")))
     end, {})
    vim.api.nvim_set_keymap('n', '<leader>cf', ':PhpCsFixerFix<CR>', { noremap = true, silent = true })
  end
}
