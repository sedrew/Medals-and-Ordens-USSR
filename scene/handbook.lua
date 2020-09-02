
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
      text = "Домой",
      x = display.contentCenterX, y = 1150,
      font = "font/Blogger_Sans-Bold.otf",
      fontSize = 90,
    })
    --
    function GroupText1:touch(e)
      if (e.phase == "began") then
      composer.gotoScene("scene.menu", {time = 800, effect="crossFade"})
      composer.removeScene("scene.handbook")
      display.remove( GroupText1 )
      GroupText1 = nil
    end
    return true
  end
  GroupText1:addEventListener( "touch", GroupText1 )


-- local card = display.newGroup()
-- local box = {}
--
-- function bx()
--   x, y = 0, 100
--   n = 2
--   for i = 1, 10 do
--     if (i > n ) then
--       y = y + 320
--       n = n + 2
--       x = 0
--     end
--     x = x + 270
--     box[i] = display.newRoundedRect(card, x, y, 250, 300, 15)
--   end
-- end
-- bx()
--
-- -- local card = display.newcard( display.contentWidth*0.5,display.contentHeight*0.5, 75)
-- -- card:setFillColor( 120 )
--
-- -- touch listener function
--
-- local dead = 2
-- local creat = true
-- local vector = {}
-- local nul = 0
-- function card:touch( event )
--   if event.phase == "began" then
--     -- first we set the focus on the object
--     display.getCurrentStage():setFocus( self, event.id )
--     self.isFocus = true
--
--
--     -- then we store the original x and y position
--     --self.markX = self.x
--     self.markY = self.y
--
--   elseif self.isFocus then
--
--     if event.phase == "moved" then
--
--       if (self.y < nul ) then
--         vector.y1 = box[dead-1].y   vector.y2 = box[dead].y
--         box[dead-1]:removeSelf()    box[dead]:removeSelf()
--         box[dead-1] = nil           box[dead] = nil
--         creat = false
--         dead = dead+2
--         nul = nul - 160
--       end
--       print(self.y)
--
--       if (self.y > nul and creat == false) then
--       --  nul = nul + 160
--         box[dead-1]=display.newRoundedRect(card, 270, vector.y1, 250, 300, 15)
--         box[dead]=display.newRoundedRect(card, 270*2, vector.y2, 250, 300, 15)
--         dead = dead-2
--         creat = true
--       end
--
--       -- then drag our object
--     --  self.x = event.x - event.xStart + self.markX
--       self.y = event.y - event.yStart + self.markY
--     elseif event.phase == "ended" or event.phase == "cancelled" then
--       -- we end the movement by removing the focus from the object
--       display.getCurrentStage():setFocus( self, nil )
--       self.isFocus = false
--
--     end
--
--   end
--
-- -- return true so Corona knows that the touch event was handled propertly
--  return true
-- end
--
-- card:addEventListener( "touch", card )
--------

-- -- touch listener function
-- function touchIt( event )
--   if event.phase == "began" then
--     -- first we set the focus on the object
--     display.getCurrentStage():setFocus( card.self, event.id )
--       self.isFocus = true
--     -- then we store the original x and y position
--     card.self.markX = card.self.x
--     card.self.markY = card.self.y
--   elseif self.isFocus then
--     if event.phase == "moved" then
--       -- then drag our object
--       card.self.x = event.x - event.xStart + card.self.markX
--       card.self.y = event.y - event.yStart + card.self.markY
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



--------------------------
    local myRoundedRect = display.newRoundedRect(display.contentCenterX, 560, 650, 650, 15)
          myRoundedRect:setFillColor(190/255,215/255,239/255)
    local myRoundedRect2 = display.newRoundedRect(sceneGroup, display.contentCenterX, 1000, 360, 160, 15)
          myRoundedRect2:setFillColor(190/255,215/255,239/255)

    local right = display.newText({
      parent = right,
      text = ">>",
      x = 660, y = 1150,
      font = "font/Blogger_Sans-Bold.otf",
      fontSize = 100,
    })
    ---
    local left = display.newText({
      parent = left,
      text = "<<",
      x = 50, y = 1150,
      font = "font/Blogger_Sans-Bold.otf",
      fontSize = 100,
    })

   local i = 1
   local med = display.newGroup()

   local nazv = require("words")
   local gr = display.newGroup()


 local GroupText = display.newText({
  parent = GroupText,
  text = nazv[i],
  width = display.actualContentWidth,
  x = display.contentCenterX, y = 120,
  align = "center",
  font = "font/Blogger_Sans-Bold.otf",

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

function left:touch(event)
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
left:addEventListener( "touch", left )

function right:touch(event)
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
right:addEventListener("touch", right)

    sceneGroup:insert(GroupText)
    sceneGroup:insert(GroupText1)
    sceneGroup:insert(right)
    sceneGroup:insert(left)
    sceneGroup:insert(myRoundedRect)
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
