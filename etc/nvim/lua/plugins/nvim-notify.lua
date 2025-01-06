require('notify').setup {
    timeout = 1000,
}
require('telescope').load_extension('notify')
vim.notify = require 'notify'
