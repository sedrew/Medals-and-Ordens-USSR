
local composer = require( "composer" )

local scene = composer.newScene()

function scene:create( event )

    local sceneGroup = self.view

end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

    local GroupText1 = display.newText({
      parent = GroupText1,
      text = i18n('home'),
      x = display.contentCenterX, y = 1150,
      font = PROPS.font,
      fontSize = 90,
    })
    --
    function GroupText1:touch(e)
      if (e.phase == "began") then
      composer.gotoScene("scene.menu", {time = 800, effect="crossFade"})
      composer.removeScene("scene.handbook")
      display.remove(GroupText1)
      GroupText1 = nil
    end
    return true
  end
  GroupText1:addEventListener( "touch", GroupText1 )

local tool = {}
function tool:table_left(t)
  table.remove(t,1)
 return t
end

function tool:table_right(t)
  local t2 = {nil}
  table.remove(t,#t)

  for i = 1, #t do
    t2[#t2+i] = t[i]
  end
  t = t2
 return t
end


-- -- touch listener function
-- function touchIt( event )
--   if event.phase == "began" then
--     -- first we set the focus on the object
--     display.getCurrentStage():setFocus( card.self, event.id )
--     self.isFocus = true
--     -- then we store the original x and y position
--     self.markX = self.x
--     self.markY = self.y
--   elseif self.isFocus then
--
--     if event.phase == "moved" then
--       -- then drag our object
--       self.x = event.x - event.xStart + self.markX
--       self.y = event.y - event.yStart + self.markY
--     elseif event.phase == "ended" or event.phase == "cancelled" then
--       -- we end the movement by removing the focus from the object
--       display.getCurrentStage():setFocus( self, nil )
--       self.isFocus = false
--     end
--
--   end
-- -- return true so Corona knows that the touch event was handled propertly
--  return true
-- end


-- local widget = require( "widget" )
--
-- -- ScrollView listener
-- local function scrollListener( event )
--
--     local phase = event.phase
--     if ( phase == "began" ) then print( "Scroll view was touched" )
--     elseif ( phase == "moved" ) then print( "Scroll view was moved" )
--     elseif ( phase == "ended" ) then print( "Scroll view was released" )
--     end
--
--     -- In the event a scroll limit is reached...
--     if ( event.limitReached ) then
--         if ( event.direction == "up" ) then print( "Reached bottom limit" )
--         elseif ( event.direction == "down" ) then print( "Reached top limit" )
--         elseif ( event.direction == "left" ) then print( "Reached right limit" )
--         elseif ( event.direction == "right" ) then print( "Reached left limit" )
--         end
--     end
--
--     return true
-- end
--
-- -- Create the widget
-- local scrollView = widget.newScrollView(
--     {
--         top = 100,
--         left = 10,
--         width = 300,
--         height = 400,
--         scrollWidth = 600,
--         scrollHeight = 800,
--         listener = scrollListener
--     }
-- )
--
-- -- Create a image and insert it into the scroll view
-- --display.newImage(med, ,display.contentCenterX, 550)
-- local background = display.newImageRect( "img/medali_ten/".. 2 .. ".png", 768, 1024 )
-- local background2 = display.newImageRect( "img/medali_ten/".. 1 .. ".png", 768, 1024 )
-- scrollView:insert( background )
-- scrollView:insert( background2 )
--------------------------
    local i = 1
    local nazv = require("resource.words")[PROPS.lang]

    local medalRect = display.newRoundedRect(display.contentCenterX, 560, 650, 650, 15)
          medalRect:setFillColor(190/255,215/255,239/255)
    local myRoundedRect2 = display.newRoundedRect(sceneGroup, display.contentCenterX, 1000, 360, 160, 15)
          myRoundedRect2:setFillColor(190/255,215/255,239/255)

    function medalRect:touch(event)
      if (event.phase == "began") then
        local tb = {i,nazv[i]}
        composer.setVariable("table_name_med", tb)
        composer.showOverlay("scene.description",{isModal = true})
      end
      return true
    end
    medalRect:addEventListener("touch", medalRect)


    local right_bt = display.newText({
      parent = sceneGroup,
      width = 200,
      text = ">>",
      x = right-40, y = 1150,
      font = PROPS.font,
      fontSize = 100,
    })
    ---
    local left_bt = display.newText({
      parent = sceneGroup,
      width = 200,
      text = "<<",
      x = left+120, y = 1150,
      font = PROPS.font,
      fontSize = 100,
    })


   local med = display.newGroup()


   local gr = display.newGroup()


 local GroupText = display.newText({
  parent = GroupText,
  text = nazv[i],
  width = display.actualContentWidth,
  x = display.contentCenterX, y = 120,
  align = "center",
  font = PROPS.font,

})


local med1 = {}
      med1[i] = display.newImage(med, "img/medali_ten/".. i .. ".png",display.contentCenterX, 550)

local kol_not = {2,5,11,17,24,30,37,48,51,59,60}
local kol = {}
local kol1 = {}

for i = 1, #nazv do
  kol[i] = i
  for g, h in ipairs(kol_not)  do
    rawset(kol, h, 2)
  end
end
kol1[kol[i]] = display.newImage(med, "img/kolodki/".. i .. ".png",display.contentCenterX, 1000)
kol1[1]:scale(0.9*(350/kol1[1].width),0.9*(350/kol1[1].width))


local l = 1

function left_bt:touch(event)
  if ( event.phase == "began" ) then
    if (i > 1) then
      if (med1[i] ~= nil )  then
          med1[i]:removeSelf()
          med1[i] = nil
          kol1[1]:removeSelf()
          kol1[1] = nil
      end
          i = i - 1
          med1[i] = display.newImage(med, "img/medali_ten/".. i .. ".png",display.contentCenterX, 550)
          kol1[1] = display.newImage(med, "img/kolodki/".. kol[i] .. ".png",display.contentCenterX, 1000)
          kol1[1]:scale(0.9*(350/kol1[1].width),0.9*(350/kol1[1].width))
          GroupText.text = nazv[i]
          GroupText.size = 620/string.len(nazv[i])+32
      end
  end
  return true
end
left_bt:addEventListener( "touch", left_bt )

function right_bt:touch(event)
  if ( event.phase == "began" ) then
    if (i < #nazv) then
      if (med1[i] ~= nil )  then
        med1[i]:removeSelf()
        med1[i] = nil
        kol1[1]:removeSelf()
        kol1[1] = nil
    end
        i = i + 1
        med1[i] = display.newImage(med, "img/medali_ten/".. i .. ".png",display.contentCenterX, 550)
        kol1[1] = display.newImage(med, "img/kolodki/".. kol[i] .. ".png",display.contentCenterX, 1000)
        kol1[1]:scale(0.9*(350/kol1[1].width),0.9*(350/kol1[1].width))
        GroupText.text = nazv[i]
        GroupText.size = 620/string.len(nazv[i])+37
    end
  end
  return true
end
right_bt:addEventListener("touch", right_bt)

    sceneGroup:insert(GroupText)
    sceneGroup:insert(GroupText1)
    sceneGroup:insert(medalRect)
    sceneGroup:insert(med)
    sceneGroup:insert(gr)

  end
end


-- hide()
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

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
