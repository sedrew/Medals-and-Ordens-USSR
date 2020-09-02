local composer = require("composer");
local widget = require("widget");
local scene = composer.newScene();
function scene:create(event)
	local sceneGroup = self.view;
-- ScrollView listener
local box = display.newGroup()
      local yu = {}
      for i = 1, 6 do
          local y = 220
          local sx = -130
          local b = 2
        if (i > 2) then
          y = 650
          sx = -790
        end
      yu[i] = display.newImage(box, "img/medali_ten/" .. i .. ".png", sx+(i*330), y)
      yu[i]:scale(0.6, 0.6)
      end
      sceneGroup:insert(box)
			local toMenu = display.newText({
	      parent = sceneGroup,
	      text = "Домой",
	      x = display.contentCenterX, y = 30,
	      font = "CoreMellowBold.ttf",
	      fontSize = 65,
	    })


	    function toMenu:touch(event)
	      if ( event.phase == "ended" ) then
	        composer.gotoScene("scene.menu", {time = 500, effect="crossFade"})
	        composer.removeScene("scene.diary", {time = 500})
	        display.remove( toMenu )
	        toMenu = nil
	      end
	      return true
	    end
	    toMenu:addEventListener( "touch", toMenu )



local function scrollListener( event )

    local phase = event.phase
    if ( phase == "began" ) then print( "Scroll view was touched" )
    elseif ( phase == "moved" ) then print( "Scroll view was moved" )
    elseif ( phase == "ended" ) then print( "Scroll view was released" )
    end

    -- In the event a scroll limit is reached...
    if ( event.limitReached ) then
        if ( event.direction == "up" ) then print( "Reached bottom limit" )
        elseif ( event.direction == "down" ) then print( "Reached top limit" )
        elseif ( event.direction == "left" ) then print( "Reached right limit" )
        elseif ( event.direction == "right" ) then print( "Reached left limit" )
        end
    end

    return true
end

-- Create the widget
local scrollView = widget.newScrollView(
    {
        top = 100,
        left = 10,
        width = 300,
        height = 400,
        scrollWidth = 600,
        scrollHeight = 800,
        listener = scrollListener
    }
)

-- Create a image and insert it into the scroll view
end
scene:addEventListener("create", scene);
return scene;
