
local composer = require( "composer" )

local scene = composer.newScene()

function scene:create( event )

 local sceneGroup = self.view

end

function scene:show( event )

 local sceneGroup = self.view
 local phase = event.phase

 if ( phase == "will" ) then

   local centerX    = display.contentCenterX
   local centerY    = display.contentCenterY
   local fullw      = display.actualContentWidth
   local fullh      = display.actualContentHeight
   local left       = centerX - fullw/2
   local right      = left + fullw
   local top        = centerY - fullh/2
   local bottom     = top + fullh

   local group = display.newGroup()

   display.newRoundedRect(group, display.contentCenterX, 50, display.actualContentWidth, 100, 10):setFillColor(0/255, 130/255, 116/255 );

   local toMenu = display.newText({
     parent = group,
     text = i18('home'),
     x = display.contentCenterX, y = 40,
     font = "font/Blogger_Sans-Bold.otf",
     fontSize = 75,
   })


   function toMenu:touch(e)
     if (e.phase == "began") then
       composer.gotoScene("scene.menu", {time = 500, effect="crossFade"})
       composer.removeScene("scene.scene4", {time = 500})
       display.remove( toMenu )
       toMenu = nil
     end
     return true
   end
   toMenu:addEventListener( "touch", toMenu )


local gim = display.newImage( sceneGroup, "img/gim.png", display.contentCenterX, display.contentCenterY )
      gim:scale(1.5, 1.5)

local df = display.newRect(group,centerX,fullh-fullh/4,fullw,fullh/1.5)
      df:setFillColor(190/255,215/255,239/255)

local paper = display.newGroup()
  local doc = display.newRect(paper,centerX,fullh-fullh/4,fullw,fullh/1.5)
        doc:setFillColor(255/255,211/255,167/255)
  local stric = display.newRoundedRect(paper,left+180,doc.y/2+20,320,120,25)
        stric:setFillColor(255/255,211/255,167/255)
  local zad = display.newText({
    parent = paper,
    text = "Задание",
    x = left+180, y = doc.y/2+10,
    font = "font/Blogger_Sans-Bold.otf",
    fontSize = 65,
  })
        zad:setFillColor(239/255,101/255,99/255)

  local opisanie = display.newText({
    parent = paper,
    text = "Медаль «За отвагу» серебристого цвета, имеет форму круга диаметром 37 мм с выпуклым бортиком с обеих сторон. На лицевой стороне медали в верхней части изображены три летящих самолёта. Под самолётами помещена надпись в две строки «За отвагу», на буквы наложена красная эмаль. Под этой надписью изображён стилизованный танк Т-35. В нижней части медали надпись «СССР», покрытая красной эмалью. На реверсе (оборотной стороне) — номер медали. Медаль при помощи кольца крепится к пятиугольной колодке, обтянутой шёлковой муаровой лентой. Лента серого цвета с двумя продольными синими полосками по краям, ширина ленты 24 мм. Ширина полосок 2 мм. Первоначально медаль «За отвагу» крепилась к четырёхугольной колодке, обтянутой красной лентой.",
    align = "left",
    width = doc.width-20,
    height = doc.height,
    x = paper.x+380, y = doc.y+10,
    font = "font/Blogger_Sans-Bold.otf",
    fontSize = 45,
  })
        opisanie:setFillColor(118/255,113/255,112/255)

        transition.to(paper,{
        time=1000,
        tag = "vniz",
        alpha=1, y=fullh/1.72,
      } )
  function paper:touch(e)
      if (e.phase == "began") then
        if (paper.y < 300) then
          transition.cancel("verh")
          transition.to(paper,{
          time=800,
          tag = "vniz",
          alpha=1, y=fullh/1.72,
          onComplete = function()  end
        } )

       else
         transition.cancel("vniz")
         transition.to(paper,{
           time=800,
           tag = "verh",
           alpha=1, y=0,
           onComplete = function() end
         } )
       end
       print(paper.y)
      end
    return true
  end
  paper:addEventListener( "touch", paper )

  local circle2 = display.newRect(group,0,0,30,30)
  circle2.x = 240; circle2.y = 500
  circle2:setFillColor(1,1,0.2)

--   local circle = display.newRect(group,0,0,100,100)
--   circle.x = 200; circle.y = 200
--
-- -- create the touch listener effect for the circle
-- function circle:touch( event )
--    if event.phase == "began"  then
--        self.markX = self.x    -- store x location of object
--        self.markY = self.y    -- store y location of object
--    elseif event.phase == "moved" then
--        local x = (event.x - event.xStart) + self.markX
--        local y = (event.y - event.yStart) + self.markY
--        self.x, self.y = x, y    -- move object based on calculations above
--        display.getCurrentStage():setFocus( self, event.id )
--        --print(self)
--        --  print(circle.x+circle.width/2,"TTTT",circle.x-circle.width/2)
--        --  print(circle.y-circle.height/2,"TTT",circle.y+circle.height/2)
--        --print(((240/self.x)+(500/self.y))/2)
--      elseif event.phase == "ended" or event.phase == "cancelled" then
--          if ( (circle.x+circle.width/2 >= circle2.x-circle2.width/2 and circle.x-circle.width/2 <= circle2.x+circle2.width/2 or
--          circle.x-circle.width/2 >= circle2.x-circle2.width/2 and circle.x-circle.width/2 <= circle2.x+circle2.width/2) and
--          (circle.y+circle.height/2 >= circle2.y-circle2.height/2 and circle.y-circle.height/2 <= circle2.y+circle2.height/2 or
--          circle.y-circle.height/2 >= circle2.y-circle2.height/2 and circle.y-circle.height/2 <= circle2.y+circle2.height/2)
--        ) then
--          transition.scaleTo( circle, { xScale=0.5, yScale=0.5, time=100 } )
--          transition.moveTo( circle, { x=circle2.x, y=circle2.y, time=100 } )
--        else
--          transition.scaleTo( circle, { xScale=1, yScale=1, time=100 } )
--          print("BINGO")
--        end
--    end
--    return true
-- end
-- if ( circle.x+circle.width/2 >= circle2.x-circle2.width/2 and circle.x-circle.width/2 <= circle2.x+circle2.width/2 or
--      circle.x-circle.width/2 >= circle2.x-circle2.width/2 and circle.x-circle.width/2 <= circle2.x+circle2.width/2 and
--      circle.y+circle.height/2 >= circle2.y-circle2.height/2 and circle.y-circle.height/2 <= circle2.y+circle2.height/2 or
--      circle.y-circle.height/2 >= circle2.y-circle2.height/2 and circle.y-circle.height/2 <= circle2.y+circle2.height/2
--    ) then

-- add the event listener to the circle
circle:addEventListener( "touch", circle )


--------------------

display.setStatusBar(display.HiddenStatusBar)

-- create a circle and put it in the center of the screen

local circle = {}
for i =1, 3 do
  circle[i] = display.newCircle(display.contentWidth*0.5,display.contentHeight*0.5, 75, {x = 100+(i*10)})
  circle[i].x = i*75
circle[i]:setFillColor( 0,1-(i/10),1 )
end
-- touch listener function
function touchIt( event )
  if event.phase == "began" then
    -- first we set the focus on the object
    for i=1,3 do
    display.getCurrentStage():setFocus( circle[i].self, event.id )
      self.isFocus = true
    -- then we store the original x and y position
    circle[i].self.markX = circle[i].self.x
    circle[i].self.markY = circle[i].self.y
  end
  elseif self.isFocus then
    if event.phase == "moved" then
      -- then drag our object
      for i=1,3 do
      circle[i].self.x = event.x - event.xStart + circle[i].self.markX
      circle[i].self.y = event.y - event.yStart + circle[i].self.markY
end
    elseif event.phase == "ended" or event.phase == "cancelled" then
    for i=1, 3 do
      if ( (circle[i].x+circle[i].width/2 >= circle2.x-circle2.width/2 and circle[i].x-circle[i].width/2 <= circle2.x+circle2.width/2 or
      circle[i].x-circle[i].width/2 >= circle2.x-circle2.width/2 and circle[i].x-circle[i].width/2 <= circle2.x+circle2.width/2) and
      (circle[i].y+circle[i].height/2 >= circle2.y-circle2.height/2 and circle[i].y-circle[i].height/2 <= circle2.y+circle2.height/2 or
      circle[i].y-circle[i].height/2 >= circle2.y-circle2.height/2 and circle[i].y-circle[i].height/2 <= circle2.y+circle2.height/2)
    ) then
      transition.scaleTo( circle[i], { xScale=0.5, yScale=0.5, time=100 } )
      transition.moveTo( circle[i], { x=circle2.x, y=circle2.y, time=100 } )
    else
      transition.scaleTo( circle[i], { xScale=1, yScale=1, time=100 } )
      print("BINGO")
    end
      -- we end the movement by removing the focus from the object
      display.getCurrentStage():setFocus( self, nil )
      self.isFocus = false
    end
    end

  end
-- return true so Corona knows that the touch event was handled propertly
 return true
end
-- finally, add an event listener to our circle to allow it to be dragged
for i=1,3 do
circle[i]:addEventListener( "touch", touchIt )
end

sceneGroup:insert(group)
sceneGroup:insert(paper)

  end
end

function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

    elseif ( phase == "did" ) then
    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view

end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )


return scene
