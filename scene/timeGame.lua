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

 function B:upBar(score)
  self.sceneGroup = display.newGroup()
  self.score =  score or 0 
  
  display.newRoundedRect(self.sceneGroup, display.contentCenterX, 50, display.actualContentWidth, 100, 10):setFillColor(0/255, 130/255, 116/255 );
  local toMenu = display.newText({
    parent = self.sceneGroup,
    text = "Домой",
    x = display.contentCenterX, y = 40,
    font = "font/Blogger_Sans-Bold.otf",
    fontSize = 75,
  })
  local  textScore = display.newText({
    parent   = self.sceneGroup,
    text =  0,
    width =display.contentWidth,
    align = "center",
    x = 50, y = 40,
    font = "font/Blogger_Sans-Bold.otf",
    fontSize = 80,
  })

  local star = {}
  local del = 5
  local vertices = { 0,-110/del, 27/del,-35/del, 105/del,-35/del, 43/del,16/del, 65/del,90/del, 0,45/del, -65/del,90/del, -43/del,15/del, -105/del,-35/del, -27/del,-35/del, }
  for i = 1, 3 do
    star[i] = display.newPolygon(self.sceneGroup, 750-(i*70), 50, vertices )
    star[i].fill = {1, 1, 0}
    star[i].strokeWidth = 10
    star[i]:setStrokeColor( 255/255,242/255,107/255 )
  end
  
 function self.timeStripe(time)
      self.time = time or 10
      self.time = self.time * 1000
      local rt = 100

       function manageTime( event )
            rt = rt - 100/(self.time/100)
          end
      local evs = timer.performWithDelay( 100, manageTime, 0 )

      local plane = display.newRoundedRect(self.sceneGroup, left, 105, fullw, 10, 12)
        plane:setFillColor( 255/255,242/255,107/255 )
        plane.anchorX = 0
        transition.to(plane,{
        time=self.time,
        alpha=1, x = -fullw+left,
        tag="transTag",
        onCancel = function()
          lovkost[#lovkost+1] = rt
          timer.cancel(evs)
          --group:removeSelf()
		  self.gameOver()
        end,
        onComplete = function()
          timer.cancel(evs)
           --res = 1
           
          end
      } )
    return self
  end
  
 self.mistake = 0
 function self.update()
   if (self.mistake > 0 and self.mistake < 4) then
        star[self.mistake]:setStrokeColor(0.5, 0.5, 0.5)
        star[self.mistake].fill = {0.5, 0.5, 0.5}
       -- self.life =  self.life - 1
     else self.gameOver()--B.gameOV(composer) --composer.showOverlay("scene.gameOver", {time = 800, effect="crossFade", isModal = true,})
   end
   textScore.text = self.score
 end

-- function self.gameOver()
  -- self.gameOver()
-- end 

  -- function toMenu:touch(e)
    -- if (tumb == true) then
      -- if (e.phase == "began") then
        -- transition.cancel("transTag")
        -- composer.gotoScene("scene.menu", {time = 500, effect="crossFade"})
        -- composer.removeScene("scene.game", {time = 500})
    -- end
    -- return true
   -- end
  -- end
  -- toMenu:addEventListener( "touch", toMenu )
  return self
end


return B
