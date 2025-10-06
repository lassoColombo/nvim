local function get_visual_selection_text()
  local _, srow, scol = unpack(vim.fn.getpos 'v')
  local _, erow, ecol = unpack(vim.fn.getpos '.')

  if vim.fn.mode() == 'V' then
    if srow > erow then
      return vim.api.nvim_buf_get_lines(0, erow - 1, srow, true)
    else
      return vim.api.nvim_buf_get_lines(0, srow - 1, erow, true)
    end
  end

  if vim.fn.mode() == 'v' then
    if srow < erow or (srow == erow and scol <= ecol) then
      return vim.api.nvim_buf_get_text(0, srow - 1, scol - 1, erow - 1, ecol, {})
    else
      return vim.api.nvim_buf_get_text(0, erow - 1, ecol - 1, srow - 1, scol, {})
    end
  end

  if vim.fn.mode() == '\22' then
    local lines = {}
    if srow > erow then
      srow, erow = erow, srow
    end
    if scol > ecol then
      scol, ecol = ecol, scol
    end
    for i = srow, erow do
      table.insert(lines, vim.api.nvim_buf_get_text(0, i - 1, math.min(scol - 1, ecol), i - 1, math.max(scol - 1, ecol), {})[1])
    end
    return lines
  end
end

local M = {}

M.apply = function()
  local mode = vim.fn.mode()

  local exit_code = 1
  local result = {}

  if mode:match '[vV]' then
    local lines = get_visual_selection_text()
    local manifest = table.concat(lines, '\n')

    result = vim.fn.systemlist({ 'kubectl', 'apply', '-f', '-' }, manifest)
    exit_code = vim.v.shell_error
  else
    result = vim.fn.systemlist { 'kubectl', 'apply', '-f', vim.fn.expand '%' }
    exit_code = vim.v.shell_error
  end

  local title = 'kubectl apply'
  if exit_code == 0 then
    vim.notify(table.concat(result, '\n'), vim.log.levels.INFO, { title = title })
  else
    vim.notify(table.concat(result, '\n'), vim.log.levels.ERROR, { title = title })
  end
end

return M
