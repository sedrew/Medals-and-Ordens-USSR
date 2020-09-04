local B = {}

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
  local textScore = display.newText({
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
    self.time = time or 2
    self.time = self.time * 1000
    local rt = 100

    function manageTime( event )
      rt = rt - 100/(self.time/100)
    end
	self.time_game = timer.performWithDelay( 100, manageTime, 0 )
	
    self.line_time = display.newRoundedRect(self.sceneGroup, left, 105, fullw, 10, 12)
    self.line_time:setFillColor(255/255,242/255,107/255)
    self.line_time.anchorX = 0
	
    transition.to(self.line_time,{
      time=self.time,
      alpha=1, x = -fullw+left,
      tag="tagPauseLineTime",
      onCancel = function()
        timer.cancel(self.time_game)
      end,
      onComplete = function()
        timer.cancel(self.time_game)
		self.gameOver()
      end
    })
   return self
  end
  
  self.mistake = 0
  function self.update()
    if (self.mistake > 0 and self.mistake < 4) then
      star[self.mistake]:setStrokeColor(0.5, 0.5, 0.5)
      star[self.mistake].fill = {0.5, 0.5, 0.5}
    elseif (self.mistake > 3) then 
	   self.gameOver()
	   --B.gameOV(composer) --composer.showOverlay("scene.gameOver", {time = 800, effect="crossFade", isModal = true,})
    end
    textScore.text = self.score
   end



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