local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
 		return
end

toggleterm.setup({
	open_mapping = [[<leader>n]],
	direction = "horizontal",
  autochdir = true,
	size = 20,
  shade_terminals = false,
  insert_mappings = false,
  terminal_mappings = false,
})

function get_nearest_function_name()
  local bufnr = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1 -- Convert to 0-indexed

  print("DEBUG: bufnr = " .. bufnr .. ", row = " .. row .. ", col = " .. col)
  print("DEBUG: filetype = " .. vim.bo.filetype)

  -- Get the parser for the buffer (auto-detect language)
  local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
  if not ok then
    print("DEBUG: Failed to get treesitter parser, error: " .. tostring(parser))
    return nil
  end
  if not parser then
    print("DEBUG: Parser is nil")
    return nil
  end
  print("DEBUG: Got parser successfully")

  -- Parse and get the tree
  local trees = parser:parse()
  if not trees or #trees == 0 then
    print("DEBUG: No syntax trees found")
    return nil
  end
  print("DEBUG: Got " .. #trees .. " trees")

  local tree = trees[1]
  local root = tree:root()
  local node = root:named_descendant_for_range(row, col, row, col)

  print("DEBUG: starting node = " .. vim.inspect(node))
  if not node then
    print("DEBUG: No treesitter node at cursor")
    return nil
  end

  print("DEBUG: starting node type = " .. vim.inspect(node:type()))

  while node do
    local node_type = node:type()
    print("DEBUG: checking node type = " .. vim.inspect(node_type))

    if node_type == "function_declaration" then
      local name_node = node:field("name")[1]
      if name_node then
        local func_name = vim.treesitter.get_node_text(name_node, bufnr)
        print("DEBUG: found function name = " .. vim.inspect(func_name))
        return func_name
      end
    end
    node = node:parent()
  end

  print("DEBUG: No function_declaration found in parent chain")
  return nil
end

function TestCurrentLine()
  local filetype = vim.bo.filetype
  local file_path = vim.fn.expand('%:p')
  local line_num = vim.api.nvim_win_get_cursor(0)[1]
  local cmd

  if filetype == "go" then
    local func_name = get_nearest_function_name()
    print("DEBUG: func_name = " .. vim.inspect(func_name))
    if func_name then
      local pkg_path = "./" .. vim.fn.expand('%:.:h')
      cmd = ("go test -v -run %s %s"):format(func_name, pkg_path)
    else
      vim.notify("No test function found at cursor", vim.log.levels.WARN)
      return
    end
  elseif filetype == "ruby" then
    cmd = ("dev test %s:%d"):format(file_path, line_num)
    -- Alternative: cmd = ("bin/rails test %s:%d"):format(file_path, line_num)
  else
    vim.notify("No test command configured for filetype: " .. filetype, vim.log.levels.WARN)
    return
  end

  -- Get the terminal with id 1 (change if you use a different id)
  local term_id = 1
  local term = require("toggleterm.terminal").get(term_id)
  if not term then
    -- Open terminal if not already open
    require("toggleterm").exec("", term_id, 12, "horizontal")
    term = require("toggleterm.terminal").get(term_id)
  end

  -- Send the command to the terminal
  term:send(cmd, true)
end

function TestCurrentFile()
  local file_path = vim.fn.expand('%:p')
  local filetype = vim.bo.filetype
  local cmd

  -- Build command based on filetype
  if filetype == "ruby" then
    cmd = ("dev test %s"):format(file_path)
    -- Alternative: cmd = ("bin/rails test %s"):format(file_path)
  elseif filetype == "go" then
    cmd = ("go test -v ./%s"):format(vim.fn.expand('%:.:h'))
  else
    vim.notify("No test command configured for filetype: " .. filetype, vim.log.levels.WARN)
    return
  end

  -- Get the terminal with id 1 (change if you use a different id)
  local term_id = 1
  local term = require("toggleterm.terminal").get(term_id)
  if not term then
    -- Open terminal if not already open
    require("toggleterm").exec("", term_id, 12, "horizontal")
    term = require("toggleterm.terminal").get(term_id)
  end

  -- Send the command to the terminal
  term:send(cmd, true)
end

function DebugCurrentTest()
  local filetype = vim.bo.filetype
  local cmd

  if filetype == "go" then
    local func_name = get_nearest_function_name()
    print("DEBUG: func_name = " .. vim.inspect(func_name))
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

  -- Get the terminal with id 1 (change if you use a different id)
  local term_id = 1
  local term = require("toggleterm.terminal").get(term_id)
  if not term then
    -- Open terminal if not already open
    require("toggleterm").exec("", term_id, 12, "horizontal")
    term = require("toggleterm.terminal").get(term_id)
  end

  -- Send the command to the terminal
  term:send(cmd, true)
end

vim.keymap.set('n', '<leader>t', TestCurrentLine)
vim.keymap.set('n', '<leader>T', TestCurrentFile)
vim.keymap.set('n', '<leader>d', DebugCurrentTest)

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<C-o>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
