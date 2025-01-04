require ('mason-nvim-dap').setup({
    ensure_installed = {'delve', 'codelldb', 'netcoredbg'},
    handlers = {}, -- sets up dap in the predefined manner
})

local dap, dapui = require("dap"), require("dapui")
require("dapui").setup()

-- dapui
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end


-- bindings for dap
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
-- vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)



-- dap.adapters.codelldb = {
--   type = 'server',
--   port = "${port}",
--   executable = {
--     -- command = '/path/to/codelldb', -- Path to your codelldb binary
--     command = '/home/fg/.local/share/nvim/mason/packages/codelldb/codelldb',
--     args = { "--port", "${port}" },
--   },
-- }

dap.adapters.lldb = {
    type = 'executable',
    -- command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
    command = '/home/fg/.local/share/nvim/mason/packages/codelldb/codelldb',
    name = 'lldb'
}

dap.configurations.cpp = {
  {
    name = "Debug",
    -- type = "codelldb",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}/build',  -- Current working directory
    stopOnEntry = false,
    args = {},
  },
}

dap.configurations.c = dap.configurations.cpp


--- go
require("dap-go").setup()
dap.adapters.delve = {
    type = "server",
    host = "127.0.0.1",
    port = 38697,
}

dap.adapters.delve = function(callback, config)
    if config.mode == 'remote' and config.request == 'attach' then
        callback({
            type = 'server',
            host = config.host or '127.0.0.1',
            port = config.port or '38697'
        })
    else
        callback({
            type = 'server',
            port = '${port}',
            executable = {
                command = 'dlv',
                args = { 'dap', '-l', '127.0.0.1:${port}', '--log', '--log-output=dap' },
                detached = vim.fn.has("win32") == 0,
            }
        })
    end
end


--cs 
dap.adapters.coreclr = {
  type = 'executable',
  command = '/home/fg/.local/share/nvim/mason/packages/netcoredbg/netcoredbg',
  args = {'--interpreter=vscode'}
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}

