local composer = require( "composer" )

local scene = composer.newScene()
function scene:create( event )

    local sceneGroup = self.view

end

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
      local json = require("json")

      function loadSettings(filename)
        -- получаем путь к файлу
        local path = system.pathForFile(filename, system.ResourceDirectory)
        local contents = ""
        local myTable = {}
        local file = io.open(path, "r") -- открываем файл
        if (file) then -- если такой файл существует
           local contents = file:read( "*a" ) -- читаем из него данные
           myTable = json.decode(contents) -- расшифровываем их
           io.close(file) -- закрываем файл
           return myTable -- возвращаем параметры из файла
        end
        return nil
      end


      setting = loadSettings("settings.json"); -- загружаем параметры из файла
      if (setting) then
        score	= setting.score
        minus = setting.minus
      end

      local box = display.newGroup()
      local vp = {}
      local d = 0
      local x, y = 185-540, 290-360
      for i = 1,6 do
        x = x + (540-185)
            if ( i > d ) then
                x = 185
                d = d + 2
                y = y + 360
            end
            if (i > 4) then
            end
            vp[i] = display.newImage(box, "img/12.png", x, y)
            vp[i]:scale(0.68,0.68)
            vp[i].tag = i
          end

          function touchIt(e)
            if(e.phase == "ended" ) then
              composer.setVariable( "cards", e.target.tag )
              print(e.target.tag)
              composer.showOverlay("scene.diaryCards",{isModal = true, time = 800, effect="crossFade"})
            end
          end

          for i=1,6 do
            vp[i]:addEventListener("touch",touchIt)
          end

      sceneGroup:insert(1,box)

    -- elseif ( phase == "did" ) then
      local dir = display.newImage("img/diary.png", display.contentCenterX,display.contentCenterY )
            dir:scale(0.9*(720/display.contentHeight),0.9*(720/display.contentHeight))
            sceneGroup:insert(1,dir)

    local toMenu = display.newText({
      parent = sceneGroup,
      text = "Домой",
      x = display.contentCenterX, y = 30,
      font = "font/Blogger_Sans-Bold.otf",
      fontSize = 65,
    })



-- local centerX    = display.contentCenterX
-- local centerY    = display.contentCenterY
-- local fullw      = display.actualContentWidth
-- local fullh      = display.actualContentHeight
-- local left       = centerX - fullw/2
-- local right      = left + fullw
-- local top        = centerY - fullh/2
-- local bottom     = top + fullh
--
-- local scrollThreshold = 100
-- local resetColorOnScrolled = false
-- local snapRate = 800 -- pixels per second
--
-- local scrollW = fullw
-- local scrollH = fullh
-- local buttonW = math.floor(fullw/1)
-- local buttonH = 1000--math.floor(fullh/2)
--
-- local function isInBounds( obj, obj2 )
--    if(not obj2) then return false end
--    local bounds = obj2.contentBounds
--    if( obj.x > bounds.xMax ) then return false end
--    if( obj.x < bounds.xMin ) then return false end
--    if( obj.y > bounds.yMax ) then return false end
--    if( obj.y < bounds.yMin ) then return false end
--    return true
-- end
--
-- local buttons = {}
--
-- local function listener( event )
--
--    if( event.phase == "began" ) then
--       event.target.scrolled = false
--       for i = 1, #buttons do
--          if( isInBounds( event, buttons[i] ) ) then
--             buttons[i]:setFillColor(0.5, 0.8, 0.5)
--          else
--             buttons[i]:setFillColor(0.8, 0.5, 0.5)
--          end
--       end
--    elseif(event.phase == "ended" ) then
--       event.target:realign()
--       for i = 1, #buttons do
--          buttons[i]:setFillColor(0.8, 0.5, 0.5)
--       end
--
--       -- Is it a click?
--       if( not event.target.scrolled ) then
--          local button
--          for i = 1, #buttons do
--             if( isInBounds( event, buttons[i] ) ) then
--                button = buttons[i]
--             end
--          end
--          if( button ) then
--             button:clickAction()
--             button:setFillColor(0.5,1,1)
--             timer.performWithDelay( 333, function() button:setFillColor(0.8,0.5,0.5) end )
--          end
--       end
--
--    elseif(event.phase == "moved" ) then
--
--       -- Update to 'scrolled' if drag passes threshold
--       local lastState = event.target.scrolled
--       event.target.scrolled = event.target.scrolled or (math.abs(event.x-event.xStart) >= scrollThreshold )
--
--       -- If state changed, recolor all buttons to 'off'
--       if( resetColorOnScrolled and lastState ~= event.target.scrolled ) then
--          for i = 1, #buttons do
--             buttons[i]:setFillColor(0.8, 0.5, 0.5)
--          end
--       end
--    end
-- end
--
--
-- local widget = require "widget"
--
-- local options =
-- {
--
--    x = centerX,
--    width = fullw,
--    height = fullh,
--    backgroundColor = { 0.8, 0.8, 0.8, 0 },
--    hideScrollBar = true,
--    listener = listener,
--    top = 70,
--    --         topPadding = 1200,
--    --         bottomPadding = 1200,
--     --       horizontalScrollDisabled  = true,
--    verticalScrollDisabled = true,
--    --         listener = scrollListener,
--    --         backgroundColor = { 0.8, 0.8, 0.8, 0 }
-- }
--
-- local menu = widget.newScrollView( options )
--
-- -- This function make sure the buttons align nicely to the top edge
-- function menu.realign(self)
--    local minX = -self:getView().contentWidth + 6 * buttonW
--    local x,y = self:getContentPosition()
--
--    if( x <= minX ) then
--       print( "Skipping" .. -self:getView().contentWidth + 3 * buttonW)
--    elseif( x >= 0 ) then
--       print("Skipping2")
--    else
--
--       local dy = x
--       local count = 0
--       local toX
--       while(dy < 0) do
--          count = count + 1
--          dy = dy + buttonW
--       end
--
--       if( dy > buttonW/2 ) then
--          toX = x + (buttonW-dy)
--       else
--          toX = x + (buttonW-dy) - buttonW
--       end
--
--       local distance = math.abs(x-toX)
--
--       print("Realign it" , x, minX, count, toX, distance )
--       self:scrollToPosition( {  x = toX, time = 1000 *  distance/snapRate })
--    end
--
-- end
--
--
-- for i = 1, 3 do
--    local button = display.newRect((i-0.5) * buttonW, buttonH/2, buttonW-2, buttonH-2 )
--    menu:insert(button)
--    button:setFillColor(0.8, 0.5, 0.5)
--    button:setStrokeColor(0)
--    button.strokeWidth = 2
--    buttons[#buttons+1] = button
--    button.label = display.newText( i, button.x, button.y, native.systemFont, 20 )
--    button.label:setFillColor(0)
--    menu:insert(button.label)
--
--    button.id = i
--
--    function button.clickAction( self )
--       print("Clicked button ", self.id )
--       -- Do click work here
--    end
--
-- end
--
--   sceneGroup:insert(menu)

-------------
    function toMenu:touch(event)
      if ( event.phase == "ended" ) then
        composer.gotoScene("scene.menu", {time = 500, effect="crossFade"})
        composer.removeScene("scene.diary", {time = 500})
        display.remove( toMenu )
        toMenu = nil
      end
      return true
    end
    toMenu:addEventListener( "touch", toMenu )

    end
end

function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
