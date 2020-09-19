local composer = require("composer")
local scene = composer.newScene()

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

    local obj = {}
    function obj:createRects()
      self.rectGroup = t.rectGroup or display.newGroup()
      self.setFillColor = t.color or {unpack(PROPS.color.cart)}
      self.x, self.y = 0, 0
      self.globalX, self.globalY = t.x, t.y
      self.w, self.h = t.w or 10, t.h or 10
      self.countX, self.countY = t.countX or 1, t.countY or 1
      self.indentX, self.indentY = self.w + (t.indentX or 20), self.h + (t.indentY or 20)
      self.box = {}
      --self.numbersList = t.numbersList or {}
      self.mainScene = display.newGroup()

      local k = 1
      for i = 1, self.countX do
        for j = 1, self.countY do
          self.box[k] = display.newRect( self.rectGroup, self.x, self.y, self.w, self.h)
          self.box[k]:setFillColor(unpack(self.setFillColor))
          self.box[k].tag = k
          self.box[k].tap = true
          self.y = self.y + self.indentY
          k = k + 1
        end
      self.y = 0
      self.x = self.x + self.indentX
      end
    end

    local lang = display.newText({
      parent = sceneGroup,
      text = "Язык",
      x = display.contentCenterX, y = 40,
      font = "font/Blogger_Sans-Bold.otf",
      fontSize = 75,
    })

    local widget = require( "widget" )


    -- Handle press events for the checkbox
    local function onSwitchPress( event )
        local switch = event.target
        print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
    end

    -- Create the widget
    local onOffSwitch = widget.newSwitch({
            left = right-300,
            top = 200,
            style = "onOff",
            id = "onOffSwitch",
            onPress = onSwitchPress,
            initialSwitchState = true,
        })
    onOffSwitch:scale(2,2)

    end
  end
scene:addEventListener("show", scene)
return scene
