local B = {}

function B:upBar(score)
  self.sceneGroup = display.newGroup()
  self.score =  score or 0


  display.newRoundedRect(self.sceneGroup, display.contentCenterX, 50, display.actualContentWidth, 100, 10):setFillColor(unpack(PROPS.color.up_bar));
  local toMenu = display.newText({
    parent = self.sceneGroup,
    text = "Домой",
    x = display.contentCenterX, y = 40,
    font = PROPS.font,
    fontSize = 75,
  })
  local textScore = display.newText({
    parent = self.sceneGroup,
    text = "0",
    width = 200,
    align = "left",
    x = left+120, y = top+45,
    font =  PROPS.font,
    fontSize = 70,
  })

  local star = {}
  local del = 5
  local vertices = { 0,-110/del, 27/del,-35/del, 105/del,-35/del, 43/del,16/del, 65/del,90/del, 0,45/del, -65/del,90/del, -43/del,15/del, -105/del,-35/del, -27/del,-35/del, }
--  local vertices = {}


  for i = 1, 3 do
    star[i] = display.newPolygon(self.sceneGroup, 750-(i*70), 50, vertices )
    star[i].fill = {unpack(PROPS.color.achieve)}
    star[i].strokeWidth = 0
    star[i]:setStrokeColor(unpack(PROPS.color.achieve))
    --star[i].x = centerX
    --star[i].y = centerY
  end


  function self.timeStripe(time)
    local rt = 100
    local child_class = {}
    self.time = time or 2
    self.time = self.time * 1000
    self.line_time = display.newRoundedRect(self.sceneGroup, left, 105, fullw, 10, 12)
    self.line_time:setFillColor(unpack(PROPS.color.achieve))
    self.line_time.anchorX = 0

    function child_class.startTime()
      function manageTime( event )
        rt = rt - 100/(self.time/100)
      end
  	  self.time_game = timer.performWithDelay( 100, manageTime, 0 )

      transition.to(self.line_time,{
        time=self.time,
        alpha=1, x = -fullw+left,
        tag="tagPauseLineTime",
        onCancel = function()
          timer.cancel(self.time_game)
          self.line_time.x = left
          --self.line_time:removeSelf()
        end,
        onComplete = function()
          timer.cancel(self.time_game)
    	    self.gameOver()
        end
       })
      return child_class
     end
     child_class.startTime()
   return child_class
  end

  self.mistake = 0
  function self.update()
    if (self.mistake > 0 and self.mistake < 4) then
      star[self.mistake]:setStrokeColor(unpack(PROPS.color.grey))
      star[self.mistake].fill = {unpack(PROPS.color.grey)}
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
