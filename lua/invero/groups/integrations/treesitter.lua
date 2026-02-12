local M = {}

function M.get(C)
  return {
    -- Variables
    ['@variable'] = { fg = C.syntax },
    ['@variable.builtin'] = { fg = C.syntax, italic = true },
    ['@variable.parameter'] = { fg = C.syntax },
    ['@variable.member'] = { fg = C.syntax },

    -- Constants
    ['@constant'] = 'Constant',
    ['@constant.builtin'] = { fg = C.accent, bold = true, italic = true },
    ['@constant.macro'] = { fg = C.syntax },

    -- Functions
    ['@function'] = 'Function',
    ['@function.builtin'] = { fg = C.syntax, italic = true },
    ['@function.call'] = { fg = C.syntax },
    ['@function.macro'] = { fg = C.syntax },
    ['@function.method'] = { fg = C.syntax },
    ['@function.method.call'] = { fg = C.syntax },

    -- Keywords
    ['@keyword'] = 'Statement',
    ['@keyword.conditional'] = 'Statement',
    ['@keyword.repeat'] = 'Statement',
    ['@keyword.return'] = 'Statement',
    ['@keyword.exception'] = 'Statement',
    ['@keyword.import'] = 'Statement',
    ['@keyword.operator'] = 'Statement',
    ['@keyword.function'] = 'Statement',
    ['@keyword.modifier'] = 'Statement',

    -- Literals
    ['@string'] = 'String',
    ['@string.escape'] = { fg = C.accent },
    ['@string.regex'] = { fg = C.accent },
    ['@string.special'] = { fg = C.accent },
    ['@string.documentation.python'] = 'Comment',
    ['@number'] = 'Number',
    ['@number.float'] = 'Number',
    ['@boolean'] = 'Boolean',
    ['@character'] = 'String',

    -- Types
    ['@type'] = 'Type',
    ['@type.builtin'] = { fg = C.syntax, italic = true },
    ['@type.definition'] = { fg = C.syntax },
    ['@type.qualifier'] = { fg = C.syntax },
    ['@attribute'] = { fg = C.syntax },
    ['@property'] = { fg = C.syntax },

    -- Operators & punctuation
    ['@operator'] = 'Operator',
    ['@punctuation.bracket'] = 'Delimiter',
    ['@punctuation.delimiter'] = 'Delimiter',
    ['@punctuation.special'] = 'Delimiter',

    -- Comments
    ['@comment'] = 'Comment',
    ['@comment.todo'] = 'Todo',
    ['@comment.note'] = { fg = C.blue, bold = true },
    ['@comment.warning'] = { fg = C.yellow, bold = true },
    ['@comment.error'] = { fg = C.red, bold = true },

    -- Markup
    ['@markup.italic'] = { fg = C.syntax },
    ['@markup.strong'] = { fg = C.syntax },
    ['@markup.underline'] = { fg = C.syntax },
    ['@markup.strikethrough'] = { fg = C.syntax },
    ['@markup.heading'] = 'Title',
    ['@markup.link'] = { fg = C.accent, underline = true },
    ['@markup.raw'] = { fg = C.green },

    -- Tags (HTML/JSX)
    ['@tag'] = { fg = C.syntax },
    ['@tag.attribute'] = 'Constant',
    ['@tag.delimiter'] = 'Delimiter',
    ['@_jsx_attribute'] = 'Constant',

    -- Misc
    ['@constructor'] = { fg = C.syntax },
    ['@label'] = { fg = C.syntax },
    ['@module'] = { fg = C.syntax },
  }
end

return M
