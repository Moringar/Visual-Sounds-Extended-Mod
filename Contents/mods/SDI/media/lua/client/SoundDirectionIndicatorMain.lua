require "Foraging/ISSearchManager.lua";

SDI = ISUIElement:derive("SDI");
local mySDI = nil
local currentTime = os.time()
local maxTimeOnScreen 
local VerticalYOffset
local isUp 
local isDown 


function SDI:initialise()
    ISUIElement.initialise(self);
	self:addToUIManager();
	self.javaObject:setWantKeyEvents(false)
	self.javaObject:setConsumeMouseEvents(false)
	--self:setEnabled(false)
	--self:lol()
	self:setVisible(false)
end
----------------------------------need these mouse functiosn to return false to prevent interfering aiming and context menu click attempts on the UIElement
function SDI:onMouseMove(d)
	return false
end
function SDI:onMouseUp(d)
	return false
end
function SDI:onRightMouseUp(d)
	return false
end
function SDI:onMouseDown(d)
	return false
end
function SDI:onRightMouseDown(d)
	return false
end
function SDI:onRightMouseDownOutside(d)
	return false
end
function SDI:onRightMouseUpOutside(d)
	return false
end
function SDI:setDistance(dist)
	self.distancetoPoint = dist
end
function SDI:setAngleFromPoint(x,y)
	if(x and y) then
		local radians = math.atan2(y - self.playerObj:getY(), x - self.playerObj:getX()) + math.pi
		local degrees = ((radians * 180 / math.pi + 270) + 45) % 360 -- add 45 deg because of the isometric view? or idk for some reason i need to. 
	
	  self.angle = degrees
	  self.lastpx = x;
	  self.lastpy = y;
  end
end
function SDI:setAngle(value)
  self.angle = value
end
function SDI:setDuration(value)
  self.duration = value
  self.flashticks = 0
  self.flashingon = true
end





local capturedSound

function SDI:render()

	local currentTime = os.time()
    if self.visible and self.duration > 0 then

        for _, sound in ipairs(self.sounds) do

            self:setDistance(IsoUtils.DistanceTo(self:getPlayer():getX(), self:getPlayer():getY(), sound.x, sound.y))
            self:setAngleFromPoint(sound.x, sound.y)
            self:setDuration(100)  -- base duration of the visual indicator
            self:setVisible(true)

            local centerX = self.width / 2
            local centerY = self.height / 2

			
			-- Set base lifetime for visual indicators
			if sound.typesound == "objects" then
				maxTimeOnScreen = 4
			elseif sound.typesound == "alerts" then
				maxTimeOnScreen = 0.1
			else
				maxTimeOnScreen = 1
			end


            local texturetoUse = self.texSameSquare

			-- If the indicator is not a additional information

				if sound.typesound == "zeds" then
					texturetoUse = self.texGreen
				elseif sound.typesound == "objects" then
					texturetoUse = self.texMeca1
				elseif sound.typesound == "vehicles" then
					texturetoUse = self.texVehi1
				elseif sound.typesound == "alerts" then
					texturetoUse = self.texAlert1
				elseif sound.typesound == "lambda" or sound.typesound == "player"  then
					texturetoUse = self.texLm1
				end
		
				if(self.distancetoPoint <= 1) then
					if sound.typesound == "zeds" then
						texturetoUse = self.texSameSquare
					elseif sound.typesound == "objects" then
						texturetoUse = self.texCenterSense
					elseif sound.typesound == "vehicles" then
						texturetoUse = self.texCenterSense
					elseif sound.typesound == "alerts" then
						texturetoUse = self.texSameSquare
					elseif sound.typesound == "lambda" or sound.typesound == "player"  then
						texturetoUse = self.texCenterSense
					end
					
				elseif(self.distancetoPoint <= 4) then
					if sound.typesound == "zeds" then
						texturetoUse = self.texRed
					elseif sound.typesound == "objects" then
						texturetoUse = self.texMeca2
					elseif sound.typesound == "vehicles" then
						texturetoUse = self.texVehi2
					elseif sound.typesound == "alerts" then
						texturetoUse = self.texAlert2
					elseif sound.typesound == "lambda" or sound.typesound == "player"  then
						texturetoUse = self.texLm2
					end
	
				elseif(self.distancetoPoint <= 6.5) then
					if sound.typesound == "zeds" then
						texturetoUse = self.texRedOrange
					elseif sound.typesound == "objects" then
						texturetoUse = self.texMeca3
					elseif sound.typesound == "vehicles" then
						texturetoUse = self.texVehi3
					elseif sound.typesound == "alerts" then
						texturetoUse = self.texAlert3
					elseif sound.typesound == "lambda" or sound.typesound == "player"  then
						texturetoUse = self.texLm3
					end
	
				elseif (self.distancetoPoint <= 9) then
					if sound.typesound == "zeds" then
						texturetoUse = self.texOrange
					elseif sound.typesound == "objects" then
						texturetoUse = self.texMeca4
					elseif sound.typesound == "vehicles" then
						texturetoUse = self.texVehi4
					elseif sound.typesound == "alerts" then
						texturetoUse = self.texAlert4
					elseif sound.typesound == "lambda" or sound.typesound == "player"  then
						texturetoUse = self.texLm4
					end
	
				elseif (self.distancetoPoint <= 11.5) then
					if sound.typesound == "zeds" then
						texturetoUse = self.texOrangeYellow
					elseif sound.typesound == "objects" then
						texturetoUse = self.texMeca5
					elseif sound.typesound == "vehicles" then
						texturetoUse = self.texVehi5
					elseif sound.typesound == "alerts" then
						texturetoUse = self.texAlert5
					elseif sound.typesound == "lambda" or sound.typesound == "player"  then
						texturetoUse = self.texLm5
					end
	
				elseif (self.distancetoPoint <= 14) then
					if sound.typesound == "zeds" then
						texturetoUse = self.texYellow
					elseif sound.typesound == "objects" then
						texturetoUse = self.texMeca6
					elseif sound.typesound == "vehicles" then
						texturetoUse = self.texVehi6
					elseif sound.typesound == "alerts" then
						texturetoUse = self.texAlert6
					elseif sound.typesound == "lambda" or sound.typesound == "player"  then
						texturetoUse = self.texLm6
					end
	
				elseif (self.distancetoPoint <= 20.0) then
					if sound.typesound == "zeds" then
						texturetoUse = self.texYellowGreen
					elseif sound.typesound == "objects" then
						texturetoUse = self.texMeca7
					elseif sound.typesound == "vehicles" then
						texturetoUse = self.texVehi7
					elseif sound.typesound == "alerts" then
						texturetoUse = self.texAlert7
					elseif sound.typesound == "lambda" or sound.typesound == "player"  then
						texturetoUse = self.texLm7
					end
				elseif (self.distancetoPoint > 20.0) then
					if sound.typesound == "alerts" then
						texturetoUse = self.texAlert7
					end
				end



			function isoIndicator(x, y, angle)
				local radianAngle = math.rad(angle)
				local isoX = x * math.cos(radianAngle) - y * math.sin(radianAngle)
				local isoY = x * math.sin(radianAngle) + y * math.cos(radianAngle)
				return isoX, isoY
			end
			-- get player vertical position
			local playerVertical = self:getPlayer():getZ()
			local playerX = self:getPlayer():getX()
			local playerY = self:getPlayer():getY()
			--update sound position while rendering

			local soundX
			local soundY

			-- if sound is zeds, enable update of last position every frame. Else, use position at emissionTime
			if sound.typesound == "zeds" or sound.typesound == "player" or sound.typesound == "vehicles" then
				soundX = sound.objsource:getX()
				soundY = sound.objsource:getY()
			else
				soundX = sound.x
				soundY = sound.y
			end

			local xOffset = playerX - soundX
			local yOffset = playerY - soundY

			local isoX, isoY = isoIndicator(xOffset, yOffset, 45)

			local PlayerZombieVerticalOffset = playerVertical - sound.z

			if PlayerZombieVerticalOffset == 0 then
				isUp = false
				isDown = false
			elseif PlayerZombieVerticalOffset > 0 then
				isUp = false
				isDown = true
			elseif PlayerZombieVerticalOffset < 0 then
				isUp = true
				isDown = false
			end


			local distance = math.sqrt(xOffset^2 + yOffset^2)
			local offsetMultiplier = 50 / math.sqrt(distance + 1)
			



			self:DrawTextureAngle(texturetoUse, (centerX + (-isoX * offsetMultiplier)), (centerY + (-isoY * offsetMultiplier)), self.angle);
			ISUIElement.render(self);


			--vertical offset to identify zombie up or down the player
			local downIndicator = self.texDown
			local upIndicator = self.texUp

			--Overlay texture to show UP or DOWN relative to the zombie.
			if isUp == true then
				self:DrawTextureAngle(upIndicator, (centerX + (-isoX * offsetMultiplier)), (centerY + (-isoY * offsetMultiplier)), 0);
                ISUIElement.render(self);
			elseif isDown == true then
				self:DrawTextureAngle(downIndicator, (centerX + (-isoX * offsetMultiplier)), (centerY + (-isoY * offsetMultiplier)), 0);
                ISUIElement.render(self);
			end

			--Overlay of the zombie behavior
			if sound.zombieState == "thump" then
				local thumpOverlay = self.texThump
				self:DrawTextureAngle(thumpOverlay, (centerX + (-isoX * offsetMultiplier)), (centerY + (-isoY * offsetMultiplier)),0);
                ISUIElement.render(self);
			end

			
			local TimeRendered = currentTime - sound.emissionTime
			if TimeRendered >= maxTimeOnScreen then
				table.remove(self.sounds, _)
			end

        end
    end
end


function SDI:setEnabled(value)
	self.enabled = value
end
function SDI:prerender()

end

function SDI:refresh()
	self.opacity = 0;
	self.opacityGain = 2;
end
function SDI:getPlayer()
	return self.playerObj;
end

function SDI:HandleWorldSound(x,y,z,radius,volume,objsource) 
	if(SDIGetOption("SDIEnabled") == 1) then
		local manager = ISSearchManager.getManager(getSpecificPlayer(0))
		local isSearching = manager.isSearchMode

		self.SoundSource = objsource
		local distancetoplayer = IsoUtils.DistanceTo(self:getPlayer():getX(),self:getPlayer():getY(),x,y);
		local soundString = tostring(objsource)


		local passenger

		if string.find(soundString, "vehicles%.BaseVehicle") ~= nil then
			if  objsource:getCharacter(1) == self.playerObj or
			objsource:getCharacter(2) == self.playerObj or
			objsource:getCharacter(3) == self.playerObj or
			objsource:getCharacter(4) == self.playerObj or
			objsource:getCharacter(5) == self.playerObj then
			passenger = true
			else
				passenger = false
			end
		end


		-- stuff to ignore
		if(objsource ~= self.playerObj) and ((SDIGetOption("CONCENTRATION") == 2 and isSearching == true) or (SDIGetOption("CONCENTRATION") == 1)) and (not ( instanceof(objsource,"BaseVehicle") and (objsource:getDriver() == self.playerObj) or passenger == true)) and (not (instanceof(objsource,"IsoGenerator") and (SDIGetOption("IGNOREGENS") == 1) )) then 
			--take traits into account
			if(self.playerObj:HasTrait("Deaf")) then radius = 0 
			elseif(self.playerObj:HasTrait("KeenHearing")) then radius = (radius * 1.2)
			elseif(self.playerObj:HasTrait("HardOfHearing")) then radius = (radius * 0.8) end			
			
			-- Check for duplicates before inserting
            local isDuplicate = false
            for _, sound in ipairs(self.sounds) do
                if sound.objsource == objsource then
                    isDuplicate = true
                    break
                end
            end

			if not isDuplicate and distancetoplayer < radius then	
				
				self:setDistance(distancetoplayer)
				self:setAngleFromPoint(x,y)
				self:setDuration(100) -- base duration of the visual indicator
				self:setVisible(true)

				local typesound
				local zombieState
				
				if string.find(soundString, "vehicles%.BaseVehicle") ~= nil then
					typesound = "vehicles"
				elseif string.find(soundString, "IsoRadio") ~= nil or string.find(soundString, "IsoTelevision") ~= nil then
					typesound = "objects"
				elseif string.find(soundString, "IsoPlayer") ~= nil then
					typesound = "player"
				elseif string.find(soundString, "characters%.IsoZombie") ~= nil then
					typesound = "zeds"
					zombieState = objsource:getActionStateName()
				elseif string.find(soundString, "iso%.Alarm") ~= nil then
					typesound = "alerts"
				else
					typesound = "lambda"
				end





				--Check toggle-able ooptions by type before inserting into render queue
				if (SDIGetOption("IGNOREZOMBIES") == 1 and typesound == "zeds") or
				(SDIGetOption("IGNOREPLAYERS") == 1 and typesound == "player") or
				(SDIGetOption("IGNOREOBJECTS") == 1 and typesound == "objects") or
				(SDIGetOption("IGNOREALARMS") == 1 and typesound == "alerts") or
				(SDIGetOption("IGNOREVEHICLES") == 1 and typesound == "vehicles") or
				(SDIGetOption("IGNORELAMBDA") == 1 and typesound == "lambda") then
				

					
					
						table.insert(self.sounds, {
							x = x,
							y = y,
							z = z,
							radius = radius,
							volume = volume,
							typesound = typesound,
							emissionTime = os.time(),
							objsource = objsource,
							zombieState = zombieState
						})

				end
			end
		end
	end
end




function SDI:new(player, x, y,width, height, title)
    local o = {}
    o = ISUIElement:new(x, y, 1, 1);
    setmetatable(o, self)
    self.__index = self
	o.playerObj = player;
	o.xoff = x;
	o.yoff = y;
	o.lastpx = 0;
	o.useOnMeTxtUntilExitBuilding = false -- if trigger house alarm, will use the on me texture until 

	-- Current sound and a list of sounds
	o.SoundSource = nil
	o.sounds = {}

	o.lastpy = 0;
	o.flashticks = 0
	o.flashingon = true
    o.width = width;
    o.height = height;
    o.angle = 0;
	o.opacity = 255;
	o.opacityGain = 2;
	o.duration = 0;
	o.enabled = true;
    o.visible = true;
    o.title = title;
	o.distancetoPoint = 999
	o.mouseOver = false;
    o.tooltip = nil;
    o.center = false;
    o.bConsumeMouseEvents = false;	
    o.joypadFocused = false;
    o.translation = nil;
    o.texGreen= getTexture("media/textures/Green.png");
	o.texYellowGreen= getTexture("media/textures/YellowGreen.png");
    o.texYellow = getTexture("media/textures/Yellow.png");
	o.texOrangeYellow = getTexture("media/textures/OrangeYellow.png");
    o.texOrange = getTexture("media/textures/Orange.png");
	o.texRedOrange = getTexture("media/textures/RedOrange.png");
    o.texRed = getTexture("media/textures/Red.png");

    o.texSameSquare = getTexture("media/textures/SameSquare.png");
	o.texCenterSense = getTexture("media/textures/SameSquare.png");


	-- o.texPlayer1 = getTexture("media/textures/player1.png");
	-- o.texPlayer2 = getTexture("media/textures/player2.png");
    -- o.texPlayer3 = getTexture("media/textures/player3.png");
	-- o.texPlayer4 = getTexture("media/textures/player4.png");
    -- o.texPlayer5 = getTexture("media/textures/player5.png");
	-- o.texPlayer6 = getTexture("media/textures/player6.png");
    -- o.texPlayer7 = getTexture("media/textures/player7.png");

	o.texMeca1 = getTexture("media/textures/meca1.png");
	o.texMeca2 = getTexture("media/textures/meca2.png");
    o.texMeca3 = getTexture("media/textures/meca3.png");
	o.texMeca4 = getTexture("media/textures/meca4.png");
    o.texMeca5 = getTexture("media/textures/meca5.png");
	o.texMeca6 = getTexture("media/textures/meca6.png");
    o.texMeca7 = getTexture("media/textures/meca7.png");

	o.texVehi1 = getTexture("media/textures/vehi1.png");
	o.texVehi2 = getTexture("media/textures/vehi2.png");
    o.texVehi3 = getTexture("media/textures/vehi3.png");
	o.texVehi4 = getTexture("media/textures/vehi4.png");
    o.texVehi5 = getTexture("media/textures/vehi5.png");
	o.texVehi6 = getTexture("media/textures/vehi6.png");
    o.texVehi7 = getTexture("media/textures/vehi7.png");

	o.texAlert1= getTexture("media/textures/alert1.png");
	o.texAlert2 = getTexture("media/textures/alert2.png");
    o.texAlert3 = getTexture("media/textures/alert3.png");
	o.texAlert4 = getTexture("media/textures/alert4.png");
    o.texAlert5 = getTexture("media/textures/alert5.png");
	o.texAlert6 = getTexture("media/textures/alert6.png");
    o.texAlert7 = getTexture("media/textures/alert7.png");
	
	o.texLm1 = getTexture("media/textures/lm1.png");
	o.texLm2 = getTexture("media/textures/lm2.png");
	o.texLm3 = getTexture("media/textures/lm3.png");
	o.texLm4 = getTexture("media/textures/lm4.png");
	o.texLm5 = getTexture("media/textures/lm5.png");
	o.texLm6 = getTexture("media/textures/lm6.png");
	o.texLm7 = getTexture("media/textures/lm7.png");

	o.texThump = getTexture("media/textures/thumpBehavior.png");

	o.texUp = getTexture("media/textures/upArrow.png");
	o.texDown = getTexture("media/textures/downArrow.png");
	
    return o;
end

-------------STATIC-FUNCS------------------


function SDI.Update(player)
	if(mySDI) then
		mySDI:render()
	end


end

function SDI.ZUpdate(zombie) ---------bc zombie vocals dont trigger worldsounds, emulate some random zombies worldsounds if nearby zombie is doing anything
	if(mySDI) then-------------------- the closer the zombies is the more likely to generate a sound
	local d = IsoUtils.DistanceTo(mySDI:getPlayer():getX(),mySDI:getPlayer():getY(),zombie:getX(),zombie:getY())
		--if(d < 8) and (ZombRand(35) == 1) and (zombie:getCurrentState() ~= nil and (not zombie:getCurrentState():equals(ZombieIdleState.instance()))) and (not zombie:isUseless()) then
		if(d < 15) and (ZombRand(25 + (d * 10)) == 1) and  (not zombie:isUseless()) then
			mySDI:HandleWorldSound(zombie:getX(),zombie:getY(),zombie:getZ(),15,7,zombie) 			
		end
	end
end

function SDI.OnWorldSound(x,y,z,radius,volume,objsource) 

	if(mySDI) then
			mySDI:HandleWorldSound(x,y,z,radius,volume,objsource)
	end
	
end



function SDI.GameStart()
	if(getPlayer() ~= nil) then
		
		local SY = (getCore():getScreenHeight()/2)
		local SX = (getCore():getScreenWidth()/2)
		mySDI = SDI:new(getPlayer(),SX, SY,1, 1, "")
		mySDI:initialise()
		print("Sound Direction Indicator initialised")
	else
		print("error could not initialise Sound Direction Indicator bc getPlayer() was nil")
	end
end


-- welp
Events.OnGameStart.Add(SDI.GameStart)
Events.EveryTenMinutes.Add(SDI.GameStart)
Events.OnPlayerUpdate.Add(SDI.Update)
Events.OnZombieUpdate.Add(SDI.ZUpdate)
Events.OnWorldSound.Add(SDI.OnWorldSound)
