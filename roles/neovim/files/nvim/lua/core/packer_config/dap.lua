local dap = require("dap")
dap.adapters.go = function(callback, _)
  local stdout = vim.loop.new_pipe(false)
  local handle
  local pid_or_err
  local port = 38697
  local opts = {
    stdio = { nil, stdout },
    args = { "dap", "-l", "127.0.0.1:" .. port },
    detached = true,
  }
  handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
    stdout:close()
    handle:close()
    if code ~= 0 then
      print("dlv exited with code", code)
    end
  end)
  assert(handle, "Error running dlv: " .. tostring(pid_or_err))
  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require("dap.repl").append(chunk)
      end)
    end
  end)
  vim.defer_fn(function()
    callback({ type = "server", host = "127.0.0.1", port = port })
  end, 100)
end
dap.configurations.go = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    program = "${file}",
  },
  {
    type = "go",
    name = "Debug test",
    request = "launch",
    mode = "test",
    program = "${file}",
  },
  {
    type = "go",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}",
  },
}

local dapui = require("dapui")
dapui.setup({
  controls = {
    icons = {
      pause = "",
      play = "",
      run_last = "",
      step_back = "",
      step_into = "",
      step_out = "",
      step_over = "",
      terminate = ""
    }
  },
  icons = {
    collapsed = "",
    current_frame = "",
    expanded = ""
  },
  mappings = {
    edit = "e",
    expand = "<CR>",
    open = "o",
    remove = "d",
    repl = "r",
    toggle = "t"
  },
})
dap.listeners.after.event_initialized["dapui_config"] = function()
  vim.opt.mouse = "n"
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  vim.opt.mouse = nil
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  vim.opt.mouse = nil
  dapui.close()
end
