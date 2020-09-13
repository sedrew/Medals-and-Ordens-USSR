local composer = require("composer")
local scene = composer.newScene()

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

      local toMenu = display.newText({
        parent = sceneGroup,
        text = "Домой",
        x = display.contentCenterX, y = 40,
        font = "font/Blogger_Sans-Bold.otf",
        fontSize = 75,
      })

      local pop = require("maket")
      pop:createRects({
        countX=2,countY=2,
        h=150,w=320,
        x=200,y=900,
        indentX = 9, indentY = 9,
      })

      function statistic()

      end


-- function newSuperellipse(t)
--   local t = t or {}
--   local len_vert = 40
--   local n,m = 5,6
--   local a, b = (t.width or 100)/2, (t.height or 100)/2
--   local i = 0
--   local lerp = (math.pi*2)/len_vert
--   local x_coord, y_coord = t.x or 0, t.y or 0
--
--   function sgn(x)
--     local sign = 0
--     if x<0  then sign=1  end
--     if x>0  then sign=-1 end
--     if x==0 then sign=0  end
--    return sign
--   end
--
--   local vertices = {}
--   local len = #vertices
--   local indices = {}
--
--   for k = 1, len_vert*2, 2 do
--     i = i + lerp
--     local ys = ((math.abs(math.sin(i))^(2/n))*sgn(math.sin(i)))*b-- b*(math.sin(i)^(2/n))
--     local xs = ((math.abs(math.cos(i))^(2/m))*sgn(math.cos(i)))*a--a*(math.cos(i)^(2/n))
--     vertices[k] = xs
--     vertices[k+1] = ys
--   end
--   --display.newRoundedRect(400, 400, 500, 500,70 )
--   local p = display.newPolygon(x_coord, y_coord, vertices)
--  return p
-- end



      local sbros = display.newText({
        parent = sceneGroup,
        text = "Сбросить статистику",
        x = display.actualContentWidth-200, y = display.actualContentHeight-25,
        font = "font/Blogger_Sans-Bold.otf",
        fontSize = 40,
      })

      function sbros:touch(e)
        if (e.phase == "began") then

        end
        return true
      end
      sbros:addEventListener( "touch", sbros )

      function toMenu:touch(e)
        if (e.phase == "began") then
          composer.gotoScene("scene.menu", {time = 500, effect="crossFade"})
          composer.removeScene("scene.affair", {time = 500})
          display.remove( toMenu )
          toMenu = nil
        end
        return true
      end
      toMenu:addEventListener( "touch", toMenu )



      local PlayGame = 40
      local score	= 100
      local minus = 30
      local lovk = 70
      local res = 30



      local text ='Сыграно '.. PlayGame .. ' раза\nОтвечено правильно '..score..' раза'
      local case = display.newText({
        parent = sceneGroup,
        align = "left",
        text = text,
        x = display.contentCenterX, y = 200,
        font = "font/Blogger_Sans-Bold.otf",
        fontSize = 50,
      })

      local halfW = display.contentWidth * 0.5
      local halfH = display.contentHeight * 0.5

      local text = 'Ловкость '..res..'%'
      local case = display.newText({
        parent = sceneGroup,
        align = "left",
        text = text,
        x = display.contentCenterX+100, y = display.contentCenterY-200,
        font = "font/Blogger_Sans-Bold.otf",
        fontSize = 50,
      })

      local ragdogLib = require "scene.ragdogLib"


      local data = {
        radius = 100,
        values = {
          {percentage = 100-res, color = {118/255,113/255,112/255}},
          {percentage = res, color = {0.572,0.815,80/255}},
          }
        }


    local pie = ragdogLib.createPieChart(data)
    pie.x, pie.y = display.contentCenterX-200, display.contentCenterY-200

    sceneGroup:insert(pie)


    end
  end
scene:addEventListener("show", scene)
return scene
