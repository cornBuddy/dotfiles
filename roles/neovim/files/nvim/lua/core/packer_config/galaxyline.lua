local vim = vim
local gl = require('galaxyline')
gl.short_line_list = {
  'startify', 'undotree', 'fugitive', 'fugitiveblame', 'startuptime',
  'NvimTree', 'vista', 'dbui', 'packer'
}
gl.short_line_list = {
  'startify', 'undotree', 'fugitive', 'fugitiveblame', 'startuptime',
  'NvimTree', 'vista', 'dbui', 'packer'
}

local hsl = require('lush').hsl
-- Colors
local clrs = {
  nord0 = hsl(220, 16, 22),
  nord1 = hsl(222, 16, 28),
  nord2 = hsl(220, 17, 32),
  nord3 = hsl(220, 16, 36),
  nord3_bright = hsl(220, 17, 46),
  nord4 = hsl(219, 28, 88),
  nord5 = hsl(218, 27, 92),
  nord6 = hsl(218, 27, 94),
  nord7 = hsl(179, 25, 65),
  nord8 = hsl(193, 43, 67),
  nord9 = hsl(210, 34, 63),
  nord10 = hsl(213, 32, 52),
  nord11 = hsl(354, 42, 56),
  nord12 = hsl(14, 51, 63),
  nord13 = hsl(40, 71, 73),
  nord14 = hsl(92, 28, 65),
  nord15 = hsl(311, 20, 63)
}

local colors = {
  bg = clrs.nord0.hex,
  section_bg = clrs.nord1.hex,
  blue = clrs.nord9.hex,
  cyan = clrs.nord8.hex,
  darkblue = clrs.nord10.hex,
  fg = clrs.nord4.hex,
  green = clrs.nord14.hex,
  magenta = clrs.nord15.hex,
  orange = clrs.nord12.hex,
  red = clrs.nord11.hex,
  violet = clrs.nord15.da(10).hex,
  yellow = clrs.nord13.hex
}


-- Local helper functions
local is_buffer_empty = function()
  return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

local buffer_not_empty = function()
  return not is_buffer_empty()
end

local in_git_repo = function ()
  local vcs = require('galaxyline.provider_vcs')
  local branch_name = vcs.get_git_branch()

  return branch_name ~= nil
end

local mode_color = function()
  local mode_colors = {
    n = colors.cyan,
    i = colors.green,
    c = colors.orange,
    V = colors.magenta,
    [''] = colors.magenta,
    v = colors.magenta,
    R = colors.red,
  }

  local color = mode_colors[vim.fn.mode()]

  if color == nil then
    color = colors.red
  end

  return color
end

local gls = gl.section
local vcs = require('galaxyline.provider_vcs')
-- Left side
gls.left[1] = {
  FirstElement = {
    provider = function() return '▋ ' end,
    highlight = { colors.cyan, colors.bg }
  },
}
gls.left[2] = {
  ViMode = {
    provider = function()
      local alias = {
        n = 'N',
        i = 'I',
        c = 'C',
        V = 'V',
        [''] = 'V',
        v = 'V',
        R = 'R',
      }
      vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color())
      local alias_mode = alias[vim.fn.mode()]
      if alias_mode == nil then
        alias_mode = vim.fn.mode()
      end
      return alias_mode..' '
    end,
    highlight = { colors.bg, colors.bg },
    separator = "  ",
    separator_highlight = { colors.bg, colors.section_bg },
  },
}
gls.left[3] ={
  FileIcon = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color, colors.section_bg },
  },
}
gls.left[4] = {
  FileName = {
    provider = 'FileName',
    condition = buffer_not_empty,
    highlight = { colors.fg, colors.section_bg },
    separator = " ",
    separator_highlight = { colors.section_bg, colors.bg },
  }
}
-- gls.left[5] = {
--   GitIcon = {
--     provider = function() return '  ' end,
--     condition = in_git_repo,
--     highlight = {colors.red,colors.bg},
--   }
-- }
-- gls.left[6] = {
--   GitBranch = {
--     provider = function()
--       local vcs = require('galaxyline.provider_vcs')
--       local branch_name = vcs.get_git_branch()
--       if (string.len(branch_name) > 28) then
--         return string.sub(branch_name, 1, 25).."..."
--       end
--       return branch_name .. " "
--     end,
--     condition = in_git_repo,
--     highlight = {colors.fg,colors.bg},
--   }
-- }
gls.left[7] = {
  DiffAdd = {
    provider = vcs.diff_add,
    condition = in_git_repo,
    icon = ' ',
    highlight = { colors.green, colors.bg },
  }
}
gls.left[8] = {
  DiffModified = {
    provider = vcs.diff_modified,
    condition = in_git_repo,
    icon = ' ',
    highlight = { colors.orange, colors.bg },
  }
}
gls.left[9] = {
  DiffRemove = {
    provider = vcs.diff_remove,
    condition = in_git_repo,
    icon = ' ',
    highlight = { colors.red, colors.bg },
  }
}
gls.left[10] = {
  LeftEnd = {
    condition = buffer_not_empty,
    provider = function() return '' end,
    highlight = { colors.section_bg, colors.bg },
    separator = ' ',
    separator_highlight = { colors.section_bg, colors.section_bg },
  }
}
gls.left[11] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red,colors.section_bg}
  }
}
gls.left[12] = {
  Space = {
    provider = function () return ' ' end,
    highlight = {colors.section_bg,colors.section_bg},
  }
}
gls.left[13] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.orange,colors.section_bg},
  }
}
gls.left[14] = {
  Space = {
    provider = function () return ' ' end,
    highlight = {colors.section_bg,colors.section_bg},
  }
}
gls.left[15] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '  ',
    highlight = {colors.blue,colors.section_bg},
    separator = ' ',
    separator_highlight = { colors.section_bg, colors.bg },
  }
}

-- Right side
gls.right[1] = {
  LspClient = {
    provider = 'GetLspClient',
    icon = ' ',
    highlight = { colors.blue, colors.bg },
  }
}
gls.right[2] = {
  Separator = {
    provider = function () return '  ' end,
    highlight = { colors.section_bg, colors.bg },
  }
}
gls.right[3] = {
  Space = {
    provider = function () return ' ' end,
    highlight = { colors.section_bg, colors.bg },
  }
}
gls.right[4]= {
  FileFormat = {
    provider = function() return vim.bo.filetype end,
    highlight = { colors.fg, colors.section_bg },
  }
}
gls.right[5] = {
  LineInfo = {
    provider = 'LineColumn',
    highlight = { colors.fg, colors.section_bg },
    separator = ' | ',
    separator_highlight = { colors.bg, colors.section_bg },
  },
}

-- Short status line
gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    highlight = { colors.fg, colors.section_bg },
    separator = ' ',
    separator_highlight = { colors.section_bg, colors.bg },
  }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    highlight = { colors.yellow, colors.section_bg },
    separator = ' ',
    separator_highlight = { colors.section_bg, colors.bg },
  }
}

-- Force manual load so that nvim boots with a status line
gl.load_galaxyline()

local vcs = require('galaxyline.provider_vcs')
