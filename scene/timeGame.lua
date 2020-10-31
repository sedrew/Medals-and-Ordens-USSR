local B = {}

function B:upBar(score)
  self.sceneGroup = display.newGroup()
  self.score =  score or 0

  display.newRoundedRect(self.sceneGroup, display.contentCenterX, 50, display.actualContentWidth, 100, 10):setFillColor(unpack(PROPS.color.up_bar))

  local toMenu = display.newImage(self.sceneGroup, "img/menu/home_white.png", centerX, top+50)
  toMenu:scale(0.3,0.3)

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

  for i = 1, 3 do
    star[i] = display.newImage(self.sceneGroup, "img/UI/2x/star.png",  750-(i*70), 50)
    star[i]:setFillColor(unpack(PROPS.color.achieve))
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
    	    self.gameOver("time_out")
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
      star[self.mistake]:setFillColor(unpack(PROPS.color.grey))
    elseif (self.mistake > 3) then
	   self.gameOver()
    end
    textScore.text = self.score
   end

   function toMenu:touch(event)
     if (event.phase == "began") then
      B.gameOver("pause")
     end
    return true
   end
   toMenu:addEventListener( "touch",toMenu)

  return self
end

return B
