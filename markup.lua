local centerX    = display.contentCenterX
local centerY    = display.contentCenterY
local fullw      = display.actualContentWidth
local fullh      = display.actualContentHeight
local left       = centerX - fullw/2
local right      = left + fullw
local top        = centerY - fullh/2
local bottom     = top + fullh
local B = {}

B.tabl = {
  orint = {
    centerX = centerX,
    centerY    = centerY,
    fullw      = fullw,
    fullh      = fullh,
    left       = left,
    right      = right,
    top        = top,
    bottom     = bottom,
  },
  scene1 = {
    id = "medal",
    x=left, y=top, w=320, h=320, r=12,
    color = {r=190/255, b=215/255, g=239/255},
    arrey = {x=2, y=2},
    headReact = {},
    vr = 330
    },
  scene2 = {
    id = "text",
    x=left, y=top, w=620, h=160, r=12,
    color = {r=190/255, b=215/255, g=239/255},
    arrey = {x=2, y=3},
    vr = 170,
    rect = {x=centerX, y=top, w=600, h=600, r=12},
  },
  scene3 = {
    id = "kolodki",
    x=left, y=top, w=300, h=150, r=12,
    color = {r=190/255, b=215/255, g=239/255},
    arrey = {x=2, y=2},
    vr = 310,
    rect = {x=centerX, y=top, w=600, h=600, r=12},
  },
}

return B
