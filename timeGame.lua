
local centerX    = display.contentCenterX
local centerY    = display.contentCenterY
local fullw      = display.actualContentWidth
local fullh      = display.actualContentHeight
local left       = centerX - fullw/2
local right      = left + fullw
local top        = centerY - fullh/2
local bottom     = top + fullh
local B = {}

lovkost = {}
 function B.timeStripe(a,composer,time)
      local time = time * 1000
      local group = display.newGroup()
      local rt = 100

       function manageTime( event )
            rt = rt - 100/(time/100)
          end
      local evs = timer.performWithDelay( 100, manageTime, 0 )

      local plane = display.newRoundedRect(group, left, top+105, fullw, 10, 12)
        plane:setFillColor( 255/255,242/255,107/255 )
        plane.anchorX = 0
        transition.to(plane,{
        time=time,
        alpha=1, x = -fullw+left,
        tag="transTag",
        onCancel = function()
          lovkost[#lovkost+1] = rt
          timer.cancel(evs)
          group:removeSelf()
        end,
        onComplete = function()
          timer.cancel(evs)
           res = 1
           close(true)
          end
      } )
a:insert(group)
end


 function B.upBar(scene,tumb,score,composer)
  display.newRoundedRect(scene, display.contentCenterX, top+50, display.actualContentWidth, 100, 10):setFillColor(0/255, 130/255, 116/255 );
  local toMenu = display.newText({
    parent = scene,
    text = "Домой",
    x = display.contentCenterX, y = top+40,
    font = "font/Blogger_Sans-Bold.otf",
    fontSize = 75,
  })
  local  textScore = display.newText({
    parent   = scene,
    text =  score,
    width =display.contentWidth,
    align = "center",
    x = 50, y = top+40,
    font = "font/Blogger_Sans-Bold.otf",
    fontSize = 80,
  })

  local star = {}
  local del = 5
  local vertices = { 0,-110/del, 27/del,-35/del, 105/del,-35/del, 43/del,16/del, 65/del,90/del, 0,45/del, -65/del,90/del, -43/del,15/del, -105/del,-35/del, -27/del,-35/del, }
  for i = 1, 3 do
    star[i] = display.newPolygon(scene, 750-(i*70), top+50, vertices )
    star[i].fill = {1, 1, 0}
    star[i].strokeWidth = 10
    star[i]:setStrokeColor( 255/255,242/255,107/255 )
end

local o = 1
    function B.starColor(composer)
      if (o < 4) then
        star[o]:setStrokeColor(0.5, 0.5, 0.5)
        star[o].fill = {0.5, 0.5, 0.5}
        o = o + 1
      else close(true)--B.gameOV(composer) --composer.showOverlay("scene.gameOver", {time = 800, effect="crossFade", isModal = true,})
      end
  end

  function toMenu:touch(e)
    if ( true) then
      if (e.phase == "began") then
          close()
        end
      return true
    end
  end
  toMenu:addEventListener( "touch", toMenu )

   function B.setScore(score)
    textScore.text = score
  end

end


return B
