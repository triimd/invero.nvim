local util = require('invero.lib.utils')

local M = {}

function M.generate(colors, context)
  local is_day = context.variant == 'day'
  local values = vim.tbl_extend('force', colors, {
    name = context.name,
    tool_pending_bg = util.blend(colors.base, colors.blue, is_day and 0.06 or 0.1),
    tool_success_bg = util.blend(colors.base, colors.green, is_day and 0.06 or 0.1),
    tool_error_bg = util.blend(colors.base, colors.red, is_day and 0.06 or 0.1),
    custom_message_bg = util.blend(colors.base, colors.magenta, 0.1),
    tool_diff_added = is_day and util.blend(colors.green, colors.text, 0.06) or colors.green,
    tool_diff_removed = is_day and util.blend(colors.red, colors.text, 0.06) or colors.red,
  })

  return util.template(
    [[
{
  "$schema": "https://raw.githubusercontent.com/earendil-works/pi/main/packages/coding-agent/src/modes/interactive/theme/theme-schema.json",
  "name": "${name}",
  "vars": {
    "base": "${base}",
    "text": "${text}",
    "accent": "${accent}",
    "selection": "${selection}",
    "surface": "${surface}",
    "outline": "${outline}",
    "outlineLight": "${outline_light}",
    "muted": "${muted}",
    "syntax": "${syntax}",
    "red": "${red}",
    "green": "${green}",
    "yellow": "${yellow}",
    "blue": "${blue}",
    "cyan": "${cyan}",
    "diffAdded": "${tool_diff_added}",
    "diffRemoved": "${tool_diff_removed}",
    "toolPendingBg": "${tool_pending_bg}",
    "toolSuccessBg": "${tool_success_bg}",
    "toolErrorBg": "${tool_error_bg}",
    "customMessageBg": "${custom_message_bg}"
  },
  "colors": {
    "accent": "accent",
    "border": "outline",
    "borderAccent": "accent",
    "borderMuted": "outlineLight",
    "success": "green",
    "error": "red",
    "warning": "yellow",
    "muted": "muted",
    "dim": "outlineLight",
    "text": "text",
    "thinkingText": "muted",

    "selectedBg": "selection",
    "userMessageBg": "surface",
    "userMessageText": "text",
    "customMessageBg": "customMessageBg",
    "customMessageText": "text",
    "customMessageLabel": "syntax",
    "toolPendingBg": "toolPendingBg",
    "toolSuccessBg": "toolSuccessBg",
    "toolErrorBg": "toolErrorBg",
    "toolTitle": "text",
    "toolOutput": "muted",

    "mdHeading": "yellow",
    "mdLink": "blue",
    "mdLinkUrl": "muted",
    "mdCode": "cyan",
    "mdCodeBlock": "green",
    "mdCodeBlockBorder": "outline",
    "mdQuote": "muted",
    "mdQuoteBorder": "outline",
    "mdHr": "outline",
    "mdListBullet": "accent",

    "toolDiffAdded": "diffAdded",
    "toolDiffRemoved": "diffRemoved",
    "toolDiffContext": "muted",

    "syntaxComment": "muted",
    "syntaxKeyword": "syntax",
    "syntaxFunction": "syntax",
    "syntaxVariable": "syntax",
    "syntaxString": "green",
    "syntaxNumber": "accent",
    "syntaxType": "syntax",
    "syntaxOperator": "syntax",
    "syntaxPunctuation": "syntax",

    "thinkingOff": "outlineLight",
    "thinkingMinimal": "outlineLight",
    "thinkingLow": "outlineLight",
    "thinkingMedium": "outlineLight",
    "thinkingHigh": "outlineLight",
    "thinkingXhigh": "outlineLight",
    "thinkingMax": "outlineLight",
    "thinkingUltra": "outlineLight",

    "bashMode": "green"
  },
  "export": {
    "pageBg": "base",
    "cardBg": "surface",
    "infoBg": "toolPendingBg"
  }
}
]],
    values
  )
end

return M
