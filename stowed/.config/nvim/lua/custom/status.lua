vim.api.nvim_set_hl(0, "RedBG",       {bg   = vim.g.terminal_color_1, fg = vim.g.terminal_color_0, bold = true})
vim.api.nvim_set_hl(0, "RedFG",       {bg   = vim.g.terminal_color_8, fg = vim.g.terminal_color_1, bold = true})
vim.api.nvim_set_hl(0, "GreenBG",     {bg   = vim.g.terminal_color_2, fg = vim.g.terminal_color_0, bold = true})
vim.api.nvim_set_hl(0, "YellowBG",    {bg   = vim.g.terminal_color_3, fg = vim.g.terminal_color_0, bold = true})
vim.api.nvim_set_hl(0, "BlueBG",      {bg   = vim.g.terminal_color_4, fg = vim.g.terminal_color_0, bold = true})
vim.api.nvim_set_hl(0, "MagentaBG",   {bg   = vim.g.terminal_color_5, fg = vim.g.terminal_color_0, bold = true})
vim.api.nvim_set_hl(0, "CyanBG",      {bg   = vim.g.terminal_color_6, fg = vim.g.terminal_color_0, bold = true})


function status_line()
  local mode_map = {
    ['n']  = 'NORMAL',
    ['no'] = 'N·OPERATOR',
    ['v']  = 'VISUAL',
    ['V']  = 'V·LINE',
    ['']   = 'V·BLOCK',
    [''] = 'V·BLOCK',
    ['s']  = 'SELECT',
    ['S']  = 'S·LINE',
    [''] = 'S·BLOCK',
    ['i']  = 'INSERT',
    ['ic'] = 'INSERT',
    ['R']  = 'REPLACE',
    ['Rv'] = 'V·REPLACE',
    ['c']  = 'COMMAND',
    ['cv'] = 'VIM·EX',
    ['ce'] = 'EX',
    ['r']  = 'PROMPT',
    ['rm'] = 'MORE',
    ['r?'] = 'CONFIRM',
    ['!']  = 'SHELL',
    ['t']  = 'TERMINAL',
  }
  local mode = mode_map[vim.api.nvim_get_mode().mode] or '?'

  local statusline = ""

  local pos = " "
  do
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local chars =
    { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    pos = chars[index]
  end

  statusline = statusline .. "%#RedBG#"
  statusline = statusline .. " " .. mode .. " "

  statusline = statusline .. "%#YellowBG#"
  statusline = statusline .. " %f "

  statusline = statusline .. "%#default#"

  statusline = statusline .. "%#RedFG#"

  statusline = statusline .. "%="

  statusline = statusline .. "%#GreenBG#"
  statusline = statusline .. " %l:%c "

  statusline = statusline .. "%#RedFG#"
  statusline = statusline .. pos

  statusline = statusline .. "%#BlueBG#"
  statusline = statusline .. " %Y "

  return statusline
end


vim.opt.statusline = '%!v:lua.status_line()'

