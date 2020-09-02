local B = {}

math.randomseed(os.time())

B.number_random = 0
function B.random()
  local kod = {1,3,4,6,7,8,9,10,12,13,14,15,16,18,19,20,21,22,23,25,26,27,28,29,31,32,33,34,35,36,38,39,40,41,42,43,44,45,46,47,49,50,52,53,54,55,56,57,58}
  local nameMedal = math.random(rand.r-2, rand.r)


  function random(r, deb)
    local bg = {}
            pl = {}
        if (#bg == 0) then
          for i = 1, r do
            local p = i + (deb - 3)
              if (variant == "kolodki_4") then
                bg[i] = kod[p]
              else
                bg[i] = p
            end
          end
        local ran = 1
        while (#pl < r) do
              j = math.random(1,r)
              if (bg[j] ~= nil) then
                pl[ran] = bg[j]
                bg[j] = nil
                ran = ran + 1
              end
            end
          else bg = {} pl = {}
        end
      end
random(bloc.kl,rand.r)
end


--local group = display.newGroup()
--bx = display.newRoundedRect(sceneGroup, centerX, 420, 600, 600, 12)
--bx:setFillColor(190/255,215/255,239/255)
function B.collor(tab)
	return tab[1], tab[2], tab[2]
end

function B:createRects(self,rectGroup,collor, x, y, w, h, countX, centerY)
	self.rectGroup = rectGroup or display.newGroup()
    self.setFillColor = collor or {190/255,215/255,239/255}
	self.x, self.y, self.w, self.h, self.r = x, y, w, h or 10, 10, 10, 10, 10
	self.countX, self.centerY = countX, centerY or 1, 1
	self.indent = 100
	B.rect = nil
	local i = 1
	for i = 1, self.countX + self.centerY do
		if (i == bloc.v+1 and variant == "medal_4") then
            self.x = self.x + bloc.vr2
            self.y = -bloc.h
		end
		self.y = self.y + bloc.vr
		B.rect[i] = display.newRoundedRect(self.rectGroup, self.x, aelf.y, self.w, self.h, self.r)
		B.rect[i]:setFillColor(B.collor(self.setFillColor))
		B.rect[i].tag = i
		B.rect[i].tap = true

	end
 end

function B.react(t,scene)
  group = display.newGroup()
  local tabl = t
  local x, y = tabl.x, tabl.y
  local k = 1
  for i = 1, tabl.arrey.x do
    for j = 1, tabl.arrey.y do
      B.box[k] = display.newRoundedRect(group, x, y, tabl.w, tabl.h, tabl.r)--:setFillColor(tabl.color.r, tabl.color.b, tabl.color.g )
      B.box[k]:setFillColor(tabl.color.r, tabl.color.b, tabl.color.g )
      B.box[k].tag = k
      B.box[k].tap = true
      y = y + tabl.vr
      k = k + 1
    end
    y = tabl.y
    x = x + tabl.vr
  end
  group.anchorChildren = true
  group.anchorX, group.anchorY  = 0.5, 0.5
  group.x, group.y = display.contentCenterX, display.contentCenterY+270--340 --КОСТЫЛь!!!!!!!!!!!
  scene:insert(group)
end


return B