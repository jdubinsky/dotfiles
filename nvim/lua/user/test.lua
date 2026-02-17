local M = {}

-- Get nearest function name using treesitter
function M.get_nearest_function_name()
  local bufnr = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1 -- Convert to 0-indexed

  -- Get the parser for the buffer (auto-detect language)
  local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
  if not ok or not parser then
    return nil
  end

  -- Parse and get the tree
  local trees = parser:parse()
  if not trees or #trees == 0 then
    return nil
  end

  local tree = trees[1]
  local root = tree:root()
  local node = root:named_descendant_for_range(row, col, row, col)

  if not node then
    return nil
  end

  while node do
    local node_type = node:type()

    if node_type == "function_declaration" or node_type == "method_declaration" then
      local name_node = node:field("name")[1]
      if name_node then
        local func_name = vim.treesitter.get_node_text(name_node, bufnr)
        return func_name
      end
    end
    node = node:parent()
  end

  return nil
end

-- Test current line/function
function M.TestCurrentLine()
  local filetype = vim.bo.filetype
  local file_path = vim.fn.expand('%:p')
  local line_num = vim.api.nvim_win_get_cursor(0)[1]
  local cmd

  if filetype == "go" then
    local func_name = M.get_nearest_function_name()
    if func_name then
      local pkg_path = "./" .. vim.fn.expand('%:.:h')
      cmd = ("go test -v -run %s %s"):format(func_name, pkg_path)
    else
      vim.notify("No test function found at cursor", vim.log.levels.WARN)
      return
    end
  elseif filetype == "ruby" then
    cmd = ("dev test %s:%d"):format(file_path, line_num)
  else
    vim.notify("No test command configured for filetype: " .. filetype, vim.log.levels.WARN)
    return
  end

  -- Execute command in toggleterm (opens if not open)
  require("toggleterm").exec(cmd)
end

-- Test current file
function M.TestCurrentFile()
  local file_path = vim.fn.expand('%:p')
  local filetype = vim.bo.filetype
  local cmd

  if filetype == "ruby" then
    cmd = ("dev test %s"):format(file_path)
  elseif filetype == "go" then
    cmd = ("go test -v ./%s"):format(vim.fn.expand('%:.:h'))
  else
    vim.notify("No test command configured for filetype: " .. filetype, vim.log.levels.WARN)
    return
  end

  -- Execute command in toggleterm (opens if not open)
  require("toggleterm").exec(cmd)
end

-- Debug current test
function M.DebugCurrentTest()
  local filetype = vim.bo.filetype
  local cmd

  if filetype == "go" then
    local func_name = M.get_nearest_function_name()
    if func_name then
      local pkg_path = "./" .. vim.fn.expand('%:.:h')
      cmd = ("dlv test %s -- -test.run %s"):format(pkg_path, func_name)
    else
      vim.notify("No test function found at cursor", vim.log.levels.WARN)
      return
    end
  else
    vim.notify("Debug command only configured for Go files", vim.log.levels.WARN)
    return
  end

  -- Execute command in toggleterm (opens if not open)
  require("toggleterm").exec(cmd)
end

return M
