
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





local card = display.newRoundedRect(300, 300, 400,150, 50)
local pop = require("maket")


local tool = {}
--tool.box = {}

pop:createRects({
  countX=3,countY=1,
  h=40,w=100,
  x=200,y=900,
  indentX = 9, indentY = 9,
  color = {1,0,0.3}
})

function tool:create_reacts()
end



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


function tool:slider(t)
    local t = t or {}
    self.x, self.y = t.box[1].x or 0, t.box[1].y or 0
    self.pos_left, self.pos_right = t.left or 0, t.right or 1
    self.pos = t.position or 0

    if self.x+self.pos < self.pos_left then
      print("LEFT")
    elseif self.x+self.pos > self.pos_right then
      print("RIGHT")
    end
end


function pop.rectGroup:touch( event )
  if event.phase == "began" then
    display.getCurrentStage():setFocus( self, event.id )
    self.isFocus = true

    self.markX = self.x
    --self.markY = self.y

  elseif self.isFocus then
    if event.phase == "moved" then

      self.x = event.x - event.xStart + self.markX
      --self.y = event.y - event.yStart + self.markY
      tool:slider({
        box = pop.box,
        left = 10, right = 400,
        position = event.x - event.xStart
      })

    elseif event.phase == "ended" or event.phase == "cancelled" then
      display.getCurrentStage():setFocus( self, nil )
      self.isFocus = false
    end
  end
 return true
end
pop.rectGroup:addEventListener( "touch", pop.rectGroup )
--------

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

   local nazv = require("resource.words")[PROPS.lang]
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
