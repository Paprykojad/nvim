-- DAP (Debug Adapter Protocol) Configuration

-- Setup mason-nvim-dap
require('mason-nvim-dap').setup({
    ensure_installed = { 'delve', 'codelldb', 'netcoredbg' },
    handlers = {}, -- sets up dap in the predefined manner
})

local dap = require("dap")
local dapui = require("dapui")

-- Setup DAP UI
dapui.setup()

-- Auto-open/close DAP UI
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

-- Add to your DAP configuration
dap.defaults.fallback.exception_breakpoints = {}
dap.defaults.fallback.breakOnThrow = false

-- Key bindings for DAP
vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = "Continue" })
vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = "Step Over" })
vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = "Step Into" })
vim.keymap.set('n', '<F12>', function() dap.step_out() end, { desc = "Step Out" })
vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
vim.keymap.set('n', '<Leader>B', function() 
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) 
end, { desc = "Set Conditional Breakpoint" })
vim.keymap.set('n', '<Leader>lp', function() 
    dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) 
end, { desc = "Set Log Point" })
vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end, { desc = "Open REPL" })
vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end, { desc = "Run Last" })

-- C/C++ Configuration
dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
        command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/codelldb",
        args = { "--port", "${port}" },
    }
}

dap.configurations.c = {
    {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    },
}

dap.configurations.cpp = dap.configurations.c

-- Load launch.json if available
require('dap.ext.vscode').load_launchjs(nil, { codelldb = { "c", "cpp" } })

-- Go Configuration
require("dap-go").setup()

-- C# Configuration
dap.adapters.coreclr = {
    type = 'executable',
    command = vim.fn.stdpath("data") .. '/mason/packages/netcoredbg/netcoredbg',
    args = { '--interpreter=vscode' }
}

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
    },
}
