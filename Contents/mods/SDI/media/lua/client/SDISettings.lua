require "OptionScreens"

function SDIGetOption(option)
	if(SDIOptions[option] ~= nil) then return tonumber(SDIOptions[option])
	else return 1 end
end

 function SDISetOption(option,ToValue)
	SDIOptions[option] = ToValue
	SaveSDIOptions()
end

 function SaveSDIOptions()
	local destFile = "SDIOptions.lua"
	local writeFile = getModFileWriter("SoundDirectionIndicator", destFile, true, false)
	for index,value in pairs(SDIOptions) do
		writeFile:write(tostring(index) .. " " .. tostring(value) .. "\r\n");
	end
	writeFile:close();
end

local function LoadSDIOptions( )
	if(doesSDIOptionsFileExist() == false) then 
		print("could not load options file")
		return nil 
	end
	local fileTable = {}
	local readFile = getModFileReader("SoundDirectionIndicator","SDIOptions.lua", true)
	local scanLine = readFile:readLine()
	while scanLine do
	
		local values = {}
		for input in scanLine:gmatch("%S+") do table.insert(values,input) end
		--print("loading line: "..values[1] .. " " .. values[2])
		if(fileTable[values[1]] == nil) then fileTable[values[1]] = {} end
			fileTable[values[1]]=tonumber(values[2])
		scanLine = readFile:readLine()
		if not scanLine then break end
	end
	readFile:close()
	print("Loaded options file")
	return fileTable
end



function doesSDIOptionsFileExist(  )
	local fileTable = {}
	local readFile = getModFileReader("SoundDirectionIndicator","SDIOptions.lua", false)
	
	if(readFile) then return true
	else return false end
end


SDIOptions = LoadSDIOptions()


local GameOption = ISBaseObject:derive("GameOption")

function GameOption:new(name, control, arg1, arg2)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.name = name
	o.control = control
	o.arg1 = arg1
	o.arg2 = arg2
	if control.isCombobox then
		control.onChange = self.onChangeComboBox
		control.target = o
	end
	if control.isTickBox then
		control.changeOptionMethod = self.onChangeTickBox
		control.changeOptionTarget = o
	end
	if control.isSlider then
		control.targetFunc = self.onChangeVolumeControl
		control.target = o
	end
	return o
end


function GameOption:toUI()
	print('ERROR: option "'..self.name..'" missing toUI()')
end


function GameOption:apply()
	print('ERROR: option "'..self.name..'" missing apply()')
end

function GameOption:onChangeComboBox(box)
	self.gameOptions:onChange(self)
	if self.onChange then
		self:onChange(box)
	end
end


function GameOption:onChangeTickBox(index, selected)
	self.gameOptions:onChange(self)
	if self.onChange then
		self:onChange(index, selected)
	end
end


function GameOption:onChangeVolumeControl(control, volume)
	self.gameOptions:onChange(self)
	if self.onChange then
		self:onChange(control, volume)
	end
end


    -- store the original MainOptions:create() method in a variable
    local oldCreate = MainOptions.create

    -- overwrite it
    function MainOptions:create()
        oldCreate(self)
        
		
		
		----- options in Game Options -----
		local spacing = 10
		--self:lol()
		self:addPage("VISUAL SOUNDS OPTIONS")
		self.addY = 0
		
		local label
		local y = 5
		local comboWidth = 300
		local splitpoint = self:getWidth() / 3;
	
		
		local options = {"ON","OFF"}
		local myCombo = self:addCombo(splitpoint, y, comboWidth, 20,"Activates visual indicators for World Sounds", options, 1)
		myCombo:setToolTipMap({defaultTooltip = "Gives you Visual Indications of the direction of world sounds"});
		
		gameOption = GameOption:new('SDIEnabled', myCombo)
		
		function gameOption.toUI(self)
			local box = self.control
			box.selected = SDIGetOption("SDIEnabled")
		end

		function gameOption.apply(self)
			local box = self.control
			if box.options[box.selected] then
				SDISetOption("SDIEnabled",box.selected)
				print("setting SDIEnabled option")
			else
				print("error could not set SDIEnabled option")
			end
		end
		function gameOption:onChange(box)
			print("SDIEnabled option changed to ".. tostring(box.selected))
		end

		self.gameOptions:add(gameOption)
		y = y + 10




		options = {"YES","NO"}
		myCombo = self:addCombo(splitpoint, y, comboWidth, 20,"Ignore Generators sounds", options, 1)
		myCombo:setToolTipMap({defaultTooltip = "Set to YES to have Visual indicators Ignore Generators"});
		gameOption = GameOption:new('IGNOREGENS', myCombo)
		function gameOption.toUI(self)
			local box = self.control
			box.selected = SDIGetOption("IGNOREGENS")
		end
		function gameOption.apply(self)
			local box = self.control
			if box.options[box.selected] then
				SDISetOption("IGNOREGENS",box.selected)
				print("setting IGNOREGENS option")
			else
				print("error could not set IGNOREGENS option")
			end
		end
		function gameOption:onChange(box)
			print("IGNOREGENS option changed to ".. tostring(box.selected))
		end
		self.gameOptions:add(gameOption)
		y = y + 20

		-- Zombies TOGGLE
		options = {"NO","YES"}
		myCombo = self:addCombo(splitpoint, y, comboWidth, 20,"Ignore ZOMBIES sounds", options, 1)
		myCombo:setToolTipMap({defaultTooltip = "Set to YES to have Visual indicators Ignore ZOMBIES"});
		gameOption = GameOption:new('IGNOREZOMBIES', myCombo)
		function gameOption.toUI(self)
			local box = self.control
			box.selected = SDIGetOption("IGNOREZOMBIES")
		end
		function gameOption.apply(self)
			local box = self.control
			if box.options[box.selected] then
				SDISetOption("IGNOREZOMBIES",box.selected)
				print("setting IGNOREZOMBIES option")
			else
				print("error could not set IGNOREZOMBIES option")
			end
		end
		function gameOption:onChange(box)
			print("IGNOREZOMBIES option changed to ".. tostring(box.selected))
		end
		self.gameOptions:add(gameOption)
		y = y + 10
		
		-- players TOGGLE
		options = {"NO","YES"}
		myCombo = self:addCombo(splitpoint, y, comboWidth, 20,"Ignore PLAYERS sounds", options, 1)
		myCombo:setToolTipMap({defaultTooltip = "Set to YES to have Visual indicators Ignore PLAYERS"});
		gameOption = GameOption:new('IGNOREZOMBIES', myCombo)
		function gameOption.toUI(self)
			local box = self.control
			box.selected = SDIGetOption("IGNOREPLAYERS")
		end
		function gameOption.apply(self)
			local box = self.control
			if box.options[box.selected] then
				SDISetOption("IGNOREPLAYERS",box.selected)
				print("setting IGNOREPLAYERS option")
			else
				print("error could not set IGNOREPLAYERS option")
			end
		end
		function gameOption:onChange(box)
			print("IGNOREPLAYERS option changed to ".. tostring(box.selected))
		end
		self.gameOptions:add(gameOption)		
		y = y + 10

			-- objects TOGGLE
			options = {"NO","YES"}
			myCombo = self:addCombo(splitpoint, y, comboWidth, 20,"Ignore Electric/electronic devices sounds", options, 1)
			myCombo:setToolTipMap({defaultTooltip = "Set to YES to have Visual indicators Ignore Electronic devices"});
			gameOption = GameOption:new('IGNOREOBJECTS', myCombo)
			function gameOption.toUI(self)
				local box = self.control
				box.selected = SDIGetOption("IGNOREOBJECTS")
			end
			function gameOption.apply(self)
				local box = self.control
				if box.options[box.selected] then
					SDISetOption("IGNOREOBJECTS",box.selected)
					print("setting IGNOREOBJECTS option")
				else
					print("error could not set IGNOREOBJECTS option")
				end
			end
			function gameOption:onChange(box)
				print("IGNOREOBJECTS option changed to ".. tostring(box.selected))
			end
			self.gameOptions:add(gameOption)		
			y = y + 10

			-- alerts TOGGLE
			options = {"NO","YES"}
			myCombo = self:addCombo(splitpoint, y, comboWidth, 20,"Ignore ALARMS sounds", options, 1)
			myCombo:setToolTipMap({defaultTooltip = "Set to YES to have Visual indicators Ignore alarms"});
			gameOption = GameOption:new('IGNOREALARMS', myCombo)
			function gameOption.toUI(self)
				local box = self.control
				box.selected = SDIGetOption("IGNOREALARMS")
			end
			function gameOption.apply(self)
				local box = self.control
				if box.options[box.selected] then
					SDISetOption("IGNOREALARMS",box.selected)
					print("setting IGNOREALARMS option")
				else
					print("error could not set IGNOREALARMS option")
				end
			end
			function gameOption:onChange(box)
				print("IGNOREALARMS option changed to ".. tostring(box.selected))
			end
			self.gameOptions:add(gameOption)		
			y = y + 10

			-- vehicles TOGGLE
			options = {"NO","YES"}
			myCombo = self:addCombo(splitpoint, y, comboWidth, 20,"Ignore VEHICLES sounds", options, 1)
			myCombo:setToolTipMap({defaultTooltip = "Set to YES to have Visual indicators Ignore vehicles"});
			gameOption = GameOption:new('IGNOREVEHICLES', myCombo)
			function gameOption.toUI(self)
				local box = self.control
				box.selected = SDIGetOption("IGNOREVEHICLES")
			end
			function gameOption.apply(self)
				local box = self.control
				if box.options[box.selected] then
					SDISetOption("IGNOREVEHICLES",box.selected)
					print("setting IGNOREVEHICLES option")
				else
					print("error could not set IGNOREVEHICLES option")
				end
			end
			function gameOption:onChange(box)
				print("IGNOREVEHICLES option changed to ".. tostring(box.selected))
			end
			self.gameOptions:add(gameOption)	
			y = y + 10
			
			-- lambda TOGGLE
			options = {"NO","YES"}
			myCombo = self:addCombo(splitpoint, y, comboWidth, 20,"Ignore uncategorized sounds", options, 1)
			myCombo:setToolTipMap({defaultTooltip = "Set to YES to have Visual indicators Ignore uncategorized sounds, like chopping wood, car crashes, rolling over mailboxes, ect..."});
			gameOption = GameOption:new('IGNORELAMBDA', myCombo)
			function gameOption.toUI(self)
				local box = self.control
				box.selected = SDIGetOption("IGNORELAMBDA")
			end
			function gameOption.apply(self)
				local box = self.control
				if box.options[box.selected] then
					SDISetOption("IGNORELAMBDA",box.selected)
					print("setting IGNORELAMBDA option")
				else
					print("error could not set IGNORELAMBDA option")
				end
			end
			function gameOption:onChange(box)
				print("IGNORELAMBDA option changed to ".. tostring(box.selected))
			end
			self.gameOptions:add(gameOption)	
			y = y + 40

			-- Foraging gameplay option : 
			options = {"NO","YES"}
			myCombo = self:addCombo(splitpoint, y, comboWidth, 20,"HUNTER MODE: Indicators in search-mode only.", options, 1)
			myCombo:setToolTipMap({defaultTooltip = "If set to YES, changes the gameplay and will display the indicators while in search mode ONLY."});
			gameOption = GameOption:new('CONCENTRATION', myCombo)
			function gameOption.toUI(self)
				local box = self.control
				box.selected = SDIGetOption("CONCENTRATION")
			end
			function gameOption.apply(self)
				local box = self.control
				if box.options[box.selected] then
					SDISetOption("CONCENTRATION",box.selected)
					print("setting CONCENTRATION option")
				else
					print("error could not set CONCENTRATION option")
				end
			end
			function gameOption:onChange(box)
				print("CONCENTRATION option changed to ".. tostring(box.selected))
			end
			self.gameOptions:add(gameOption)	

		
		 self.addY = self.addY + MainOptions.translatorPane:getHeight()+22;

		self.mainPanel:setScrollHeight(y + self.addY + 20)
		
		
    end


