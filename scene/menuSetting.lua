local composer = require("composer")
local widget = require( "widget" )
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

    local toMenu = display.newImage( sceneGroup, "img/menu/home_white.png", centerX, top+50)
    toMenu:scale(0.3,0.3)

    function toMenu:touch(e)
      if (e.phase == "began") then
        composer.gotoScene("scene.menu", {time = 500, effect="crossFade"})
        composer.removeScene("scene.menuSetting", {time = 500})
        display.remove( toMenu )
        toMenu = nil
      end
      return true
    end
    toMenu:addEventListener( "touch", toMenu )



    local left_add = 460
    local fontSize = 65
    local lang = display.newText({
      parent = sceneGroup,
      align = "left",
      text = "Язык",
      width = 800,
      x = left+left_add, y = 200,
      font = PROPS.font,
      fontSize = fontSize,
    })

    local theme = display.newText({
      parent = sceneGroup,
      align = "left",
      text = "Темы",
      width = 800,
      x = left+left_add, y = lang.y+100,
      font = PROPS.font,
      fontSize = fontSize,
    })

    local sound = display.newText({
      parent = sceneGroup,
      align = "left",
      text = "Звуки",
      width = 800,
      x = left+left_add, y = theme.y+100,
      font = PROPS.font,
      fontSize = fontSize,
    })

    local music = display.newText({
      parent = sceneGroup,
      align = "left",
      text = "Музыка",
      width = 800,
      x = left+left_add, y = sound.y+100,
      font = PROPS.font,
      fontSize = fontSize,
    })

    local fonts = display.newText({
      parent = sceneGroup,
      align = "left",
      text = "Шрифт",
      width = 800,
      x = left+left_add, y = music.y+100,
      font = PROPS.font,
      fontSize = fontSize,
    })

    local size_fonts = display.newText({
      parent = sceneGroup,
      align = "left",
      text = "Размер шрифта",
      width = 800,
      x = left+left_add, y = fonts.y+100,
      font = PROPS.font,
      fontSize = fontSize,
    })

    -- Handle press events for the checkbox
    local function onSwitchPress( event )
        local switch = event.target
        print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
    end
    local music_switch = widget.newSwitch({
            x = music.x,
            y = music.y,
            -- left = right-300,
            -- top = 200,
            style = "onOff",
            id = "onOffSwitch",
            onPress = onSwitchPress,
            initialSwitchState = true,
        })
    music_switch:scale(2,2)
    sceneGroup:insert(music_switch)

    -- Handle press events for the checkbox
    local function onSwitchPress( event )
        local switch = event.target
        print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
    end
    local sound_switch = widget.newSwitch({
            x = music.x,
            y = sound.y,
            -- left = right-300,
            -- top = 200,
            style = "onOff",
            id = "onOffSwitch",
            onPress = onSwitchPress,
            initialSwitchState = true,
        })
    sound_switch:scale(2,2)
    sceneGroup:insert(sound_switch)

    local currentNumber = 12
    local function onStepperPress( event )
        if ( "increment" == event.phase ) then
            currentNumber = currentNumber + 1
        elseif ( "decrement" == event.phase ) then
            currentNumber = currentNumber - 1
        end
        print( currentNumber )
    end

    local newStepper = widget.newStepper({
            x = size_fonts.x+100,
            y = size_fonts.y,
            minimumValue = 12,
            maximumValue = 120,
            onPress = onStepperPress
        })
    sceneGroup:insert(newStepper)

----------
    end
  end
scene:addEventListener("show", scene)
return scene
