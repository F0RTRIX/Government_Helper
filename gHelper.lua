script_name("Government Helper v1.0")
script_author("L.Salieri")
script_authors("L.Salieri, DonHomka")
script_version(1)

local dlstatus = require('moonloader').download_status
local EV = require 'lib.samp.events'
local memory = require 'memory'
local imgui = require 'imgui'
local encoding = require 'encoding'
local key = require 'vkeys'
local inicfg = require 'inicfg'
local bitex = require 'bitex'
local vkeys = require 'vkeys'
local GK = require 'game.keys'
local weapons = require 'game.weapons'
local inicfg = require 'inicfg'
local winmsg = require 'windows.message'
local encoding = require 'encoding'
require 'lib.samp.events'
require 'lib.moonloader'
require 'lib.sampfuncs'
require 'LIP'
encoding.default = 'CP1251'
u8 = encoding.UTF8
-- ����� ��� ����������
local show_cmd_menu = imgui.ImBool(false)
-- ����� ��� ������
local sex1 = imgui.ImBool(false)
local rpgun = imgui.ImBool(false)
local asc = imgui.ImBool(false)

local dir = "moonloader\\config\\Government Helper"
local yprav = dir .. "gYstavPrav.ini"

local mainIni = inicfg.load({
	Main_settings =
	{
		nickname = "",
		work = "",
		rang = "",
		numb = "",
		tag = ""
	},
	Check =
	{
		sex1 = false,
		rpgun = false,
		asc = false,
		rpsms = false,
		gnews = false
	},
	Keys =
	{
		CMD = "",
		spora = "",
		clock = "",
		rp = "",
		stop = "",
		badge = "",
		sfind = "",
		hreset = ""
	}
}, "Government Helper/Government_Helper")

local enickname = imgui.ImBuffer(tostring(mainIni.Main_settings.nickname), 256)
local ework = imgui.ImBuffer(tostring(mainIni.Main_settings.work), 256)
local erang = imgui.ImBuffer(tostring(mainIni.Main_settings.rang), 256)
local enumb = imgui.ImBuffer(tostring(mainIni.Main_settings.numb), 256)
local etag = imgui.ImBuffer(tostring(mainIni.Main_settings.tag), 256)
local cbsex1 = imgui.ImBool(mainIni.Check.sex1)
local cbrpgun = imgui.ImBool(mainIni.Check.rpgun)
local cbasc = imgui.ImBool(mainIni.Check.asc)
local cbrpsms = imgui.ImBool(mainIni.Check.rpsms)
local cbgnews = imgui.ImBool(mainIni.Check.gnews)
local hkCMD = imgui.ImBuffer(tostring(mainIni.Keys.CMD), 256)
local hkspora = imgui.ImBuffer(tostring(mainIni.Keys.spora), 256)
local hkclock = imgui.ImBuffer(tostring(mainIni.Keys.clock), 256)
local hkrp = imgui.ImBuffer(tostring(mainIni.Keys.rp), 256)
local hkstop = imgui.ImBuffer(tostring(mainIni.Keys.stop), 256)
local hkbadge = imgui.ImBuffer(tostring(mainIni.Keys.badge), 256)
local hksfind = imgui.ImBuffer(tostring(mainIni.Keys.sfind), 256)
local hkhreset = imgui.ImBuffer(tostring(mainIni.Keys.hreset), 256)
local logFilter = imgui.ImBuffer(256)
targeting = false

function main()
  if not isSampfuncsLoaded() or not isSampLoaded() then -- ���� SF ��� SA:MP �� ���������
    return -- ��������� ������ �������
  end
  while not isSampAvailable() do -- ��� ���� ������� isSampAvailable() ������ true
  wait(0) -- ������������� ����������� ��������, ��� �� ���� ���� �� �������
  -- �������� 0 ������� ��� �� ��� ��������� ���� (Frame)
  end
		-- sampAddChatMessage("{A8FF14}[gHelp]{4682B4} Government Helper ������� ������� by {800000}f0rtrix", 0x008080)
		-- sampAddChatMessage("{A8FF14}[gHelp]{4682B4} Government Helper ������� ������� by {800000}F0RTRIX", 0x008080)
		-- sampAddChatMessage("{A8FF14}[gHelp]{4682B4} Government Helper ������� ������� by {553982}f0rtrix", 0x008080)
		-- sampAddChatMessage("{A8FF14}[gHelp]{4682B4} Government Helper ������� ������� by {553982}F0RTRIX", 0x008080)
  	sampRegisterChatCommand("ghelp", main_gh_menu)
		sampRegisterChatCommand("show", main_spora_menu)
		sampRegisterChatCommand("exam", main_exam_menu)
		sampRegisterChatCommand("bl", blcheck)
		sampRegisterChatCommand("invite", ginvite)
		sampRegisterChatCommand("uninvite", guninvite)
		sampRegisterChatCommand("f", gftag)
		sampRegisterChatCommand("fn", gfnrac)
		sampRegisterChatCommand("rn", grnrac)
		sampRegisterChatCommand("rang", grang)
		sampRegisterChatCommand("sfind", gfind)
		sampRegisterChatCommand("lesson", glesson)
		sampRegisterChatCommand("changeskin", gskin)
		sampRegisterChatCommand("clock", gclock)
		sampRegisterChatCommand("story", gstory)
		sampRegisterChatCommand("sob", main_inter_menu)
		while true do
				wait(0)
				local result, ped = getCharPlayerIsTargeting()
				local result2, id = sampGetPlayerIdByCharHandle(ped)
					if result2 and isKeyDown(0x47) and not targeting then
						dopmenuNM1 = sampGetPlayerNickname(id)
						dopmenuID1 = id
						print(dopmenuNM1)
						show_main_dop_menu.v = not show_main_dop_menu.v
						imgui.Process = show_main_dop_menu.v
						targeting = true
					 elseif not result and targeting then -- ���� ������� �������� - ������ ������� ��� �� �� �������
						targeting = false
					end
					if isKeysDown(mainIni.Keys.spora) then
						show_main_spora_menu.v = not show_main_spora_menu.v
						imgui.Process = show_main_spora_menu.v
					end
					if isKeysDown(mainIni.Keys.CMD) then
						sampSendChat("/cmd")
					end
					if isKeysDown(mainIni.Keys.clock) then
						lua_thread.create(function()
							local clocker = os.date('%H:%M:%S.')
							local timer1 = 60-os.date('%M')
							local timer2 = 60-os.date('%S')
							sampSendChat("/me ������� �����, ����� ������ �������� ������ �������� �� ����")
							wait(1300)
							sampSendChat("/do ����� �� �����: "..clocker)
							wait(800)
							sampSendChat("/do �� �������� �������� �������� "..timer1.." �����.")
							wait(500)
							sampSendChat("/c 060")
							wait(1300)
							sampSendChat("/me ������ ��������� ����� ������� �����, ����� ��������� ������ �������")
						end)
					end
					if isKeysDown(mainIni.Keys.stop) then
						sampAddChatMessage("{A8FF14}[gHelp]{553982} RolePlay {4682B4}��������� �����������. ��������� ����������� {800000}:3", -1)
					end
					--local hkCMD = imgui.ImBuffer(tostring(mainIni.Keys.CMD), 256)
					--local hkrp = imgui.ImBuffer(tostring(mainIni.Keys.rp), 256)
					--local hkstop = imgui.ImBuffer(tostring(mainIni.Keys.stop), 256)
					--local hkbadge = imgui.ImBuffer(tostring(mainIni.Keys.badge), 256)
					--local hksfind = imgui.ImBuffer(tostring(mainIni.Keys.sfind), 256)
					--local hkhreset = imgui.ImBuffer(tostring(mainIni.Keys.hreset), 256)
		end
end

function onScriptTerminate(script, quitGame)
	if script == thisScript() then
		if not doesDirectoryExist("Government Helper") then
			createDirectory("Government Helper")
		end
		inicfg.save(mainIni, "Government Helper\\Government_Helper", encoding.UTF8)
		local testerfiles = io.open("moonloader\\config\\Government Helper\\gBlackList.ini")
		if testerfiles == nil then
			io.open("moonloader\\config\\Government Helper\\gBlackList.ini", "w")
			io.open("moonloader\\config\\Government Helper\\gkn15.ini", "w")
			io.open("moonloader\\config\\Government Helper\\gkn69.ini", "w")
			io.open("moonloader\\config\\Government Helper\\gYstavMerii.ini", "w")
			io.open("moonloader\\config\\Government Helper\\gYstavPrav.ini", "w")
			io.open("moonloader\\config\\Government Helper\\gYK.ini", "w")
			io.open("moonloader\\config\\Government Helper\\gAK.ini", "w")
			io.open("moonloader\\config\\Government Helper\\gReform.ini", "w")
			file:close("moonloader\\config\\Government Helper\\gBlackList.ini")
			file:close("moonloader\\config\\Government Helper\\gkn15.ini")
			file:close("moonloader\\config\\Government Helper\\gkn69.ini")
			file:close("moonloader\\config\\Government Helper\\gYstavMerii.ini")
			file:close("moonloader\\config\\Government Helper\\gYstavPrav.ini")
			file:close("moonloader\\config\\Government Helper\\gYK.ini")
			file:close("moonloader\\config\\Government Helper\\gAK.ini")
			file:close("moonloader\\config\\Government Helper\\gReform.ini")
			file:close("moonloader\\config\\Government Helper\\gBlackList.ini")
		end
	end
end

function EV.onServerMessage(color, msg)
	if color == 865730559 and msg:find("����� ���������� �� Advance RolePlay!") then
			lua_thread.create(function()
			wait(1)
			sampAddChatMessage("{A8FF14}[gHelp]{4682B4} Government Helper ������� ������� by {800000}F0RTRIX", 0x008080)
		end)
	end
end

function gstory(ID)
	local test123id = ID
	if sampIsPlayerConnected(test123id) and type(test123id == "number") then
		local argID = test123id
		local storyNM = sampGetPlayerNickname(argID)
		sampSendChat("/history "..storyNM)
	else sampAddChatMessage("{A8FF14}[gHelp]{4682B4} ����������� ������� {FFFC18}/story {800000}[id]", -1) end
end

function gclock()
	lua_thread.create(function()
		local clocker = os.date('%H:%M:%S.')
		local timer1 = 60-os.date('%M')
		sampSendChat("/me ������� �����, ����� ������ �������� ������ �������� �� ����")
		wait(1300)
		sampSendChat("/do ����� �� �����: "..clocker)
		wait(800)
		sampSendChat("/do �� �������� �������� �������� "..timer1.." �����.")
		wait(500)
		sampSendChat("/c 060")
		wait(1300)
		sampSendChat("/me ������ ��������� ����� ������� �����, ����� ��������� ������ �������")
	end)
end

function gfind()
	lua_thread.create(function()
		sampSendChat("/me ������ ������� �� �������, ����� ������� ������� ������������� ���")
		wait(1300)
		sampSendChat("/me ����� � ��������� ''�������� �������������'', ����� ����� ''���������� �����������'' ")
		wait(1300)
		sampSendChat("/find")
		local text = sampGetDialogText()
		local sfint = text:match('�� ��� ������:%s+(%d+)')
		sampSendChat("/do �� ������ ������ ����������� � �����: "..sfint..".")
		wait(1300)
		sampSendChat("/me ����� �� ������ �� ��������, �������� ���")
		wait(1300)
		sampSendChat("/me ����� ������� ������� � ������")
	end)
end

function blcheck(plyID)
  if sampIsPlayerConnected(plyID) and tonumber(plyID) then
      blnick = sampGetPlayerNickname(plyID)
      sampAddChatMessage("{A8FF14}[gHelp]{4682B4} ��������� ��������{800000} " ..blnick.. " {4682B4}�� ���������� � �� �������������")
      FileName = io.open("moonloader/config/Government Helper/gBlackList.ini", 'r')
      if FileName:read('a*'):find(blnick) then
            sampAddChatMessage("{A8FF14}[gHelp]{4682B4} ������� ��� ������{800000} " ..blnick.. " {4682B4}��������� �� �������������")
          else
              sampAddChatMessage("{A8FF14}[gHelp]{4682B4} ������� ��� ������{800000} " ..blnick.. " {4682B4}�� ������ � �� �������������")
              sampAddChatMessage("{A8FF14}[gHelp]{4682B4} ���������� ����� �� ������� ����")
							sampSendChat('/history '..blnick) -- ����� � ��� ������� /history
							local dial = sampGetDialogText() -- �������� ����� �������.
							for lines in FileName:lines() do
								dial1 = dial
								if string.find(dial1, lines) or string.find(dial1, string.gsub(lines, '_', ' ')) then -- ���� � ������ ������� ���� ��� �� ������ lines, �� ������� � ���.
										 sampAddChatMessage('{A8FF14}[gHelp]{4682B4} ������� '..blnick..' ��������� � �� �������������', -1)
								else sampAddChatMessage("{A8FF14}[gHelp]{4682B4} "..blnick.." �� ��������� � �� �������������") end
							end
	        end
			end
    FileName:close()
end

function gskin(playerID)
	local name = sampGetPlayerNickname(playerID)
	local my_nick = mainIni.Main_settings.nickname
	local nm1, nm2 = string.match(name, "(%g+)_(%g+)")
	if sampIsPlayerConnected(playerID) and tonumber(playerID) or sampGetPlayerIdByCharHandle(PLAYER_PED) then
			lua_thread.create(function()
				sampSendChat("/do �� ����� "..my_nick.." ����� �����.")
				wait(1300)
				sampSendChat("/me ���� ����� � �����, ����� ������ �� � ������ �� ���")
				sampSendChat("/anim 14")
				sampSendChat("/anim 14")
				wait(1300)
				sampSendChat("/me ����� ����� ����� ����������� ������� ��� ".. nm1)
				wait(1300)
				sampSendChat("/changeskin "..playerID)
			end)
	else sampAddChatMessage("{A8FF14}[gHelp]{4682B4} ����������� ������� {FFFC18}/changeskin {800000}[id]", -1) end
end

function grang(arg)
	local telid, chg = string.match(arg,"(%d+)%s(.*)")
	if sampIsPlayerConnected(telid) and tonumber(telid) then
		local my_nick = mainIni.Main_settings.nickname
		local name = sampGetPlayerNickname(telid)
		local nm1, nm2 = string.match(name, "(%g+)_(%g+)")
		lua_thread.create(function()
			sampSendChat("/do �� ����� "..my_nick.." ����� �����.")
			wait(1300)
			sampSendChat("/me ���� ����� � �����, ����� ������ ��, ������ ����� ����� � �������")
			wait(1300)
			sampSendChat("/me ������� ����� ����� � ������� " .. nm1)
			sampSendChat("/rang "..telid.." "..chg)
		end)
	else sampAddChatMessage("{A8FF14}[gHelp]{4682B4} ����������� ������� {FFFC18}/rang {800000}[id] [+/-]", -1) end
end

function gfnrac(text)
	sampSendChat("/f (( ".. text .." ))")
end

function grnrac(text)
	sampSendChat("/r (( ".. text .." ))")
end

function gftag(text)
	sampSendChat("/f ".. mainIni.Main_settings.tag.. " | ".. text)
end

function guninvite(arg)
	local playeID, reason = string.match(arg,"(%d+)%s(.*)")
	if sampIsPlayerConnected(playeID) and tonumber(playeID) then
			local my_nick = mainIni.Main_settings.nickname
			local name = sampGetPlayerNickname(playeID)
			local ni, ck = string.match(name, "(%g+)_(%g+)")
			local RPname = ni.." "..ck
		lua_thread.create(function()
			sampSendChat("/do � ������� " .. my_nick .." ��������� �������.")
			wait(1300)
			sampSendChat("/me ����������� �����, ������ �������, ����� ������������� ���")
			wait(1300)
			sampSendChat("/me ������ ��������� �� ������� �����������, ����� ����� " .. RPname)
			wait(1300)
			sampSendChat("/me ��������� ������� �������� �� ������ �����������")
			wait(1300)
			sampSendChat("/f ".. mainIni.Main_settings.tag.. " | ��������� " ..RPname.. " ��� ������ �� �������: " ..reason)
			sampSendChat("/uninvite "..playeID.." ".. reason)
		end)
	else sampAddChatMessage("{A8FF14}[gHelp]{4682B4} ����������� ������� {FFFC18}/uninvite {800000}[id] [�������]", -1) end
end

function glesson(arg)
	toparg = tonumber(arg)
	if toparg ~= nil then
		lua_thread.create(function()
			if toparg == 1 then
				sampSendChat("/r ��������� ���������� ����� �.���-��������, ��������� ��������!")
				wait(1300)
				sampSendChat("/r ������ ������� � 18:00 � ��� �������� ��������!")
				wait(1300)
				sampSendChat("/r ����� ��������� �� ������� �������� �����.")
			end
			if toparg == 2 then
				sampSendChat("/r ��������� ���������� ����� �.���-��������, ��������� ��������!")
				wait(1300)
				sampSendChat("/r ���������� � ����������� ����� ������������� �� ���������!")
				wait(1300)
				sampSendChat("/r �� ��������� ������������ �� ������ ������� ��� ��������.")
			end
			if toparg == 3 then
				sampSendChat("/r ��������� ���������� ����� �.���-��������, ��������� ��������!")
				wait(1300)
				sampSendChat("/r ������ � �������� ���� ��������� ������������� � ��������� �����.")
				wait(1300)
				sampSendChat("/r ���������� ���������� � ������ � ������� ����� ����� �������.")
			end
			if toparg == 4 then
				sampSendChat("/r �� ������� ���������� ����� �.���-�������� ��������� ��������!")
				wait(1300)
				sampSendChat("/r ���������, ���� �� ��������� ���������� ��� ������ �����...")
				wait(1300)
				sampSendChat("/r �� ������ ������� � �������� � ��!")
			end
			if toparg == 5 then
				sampSendChat("/r ��������� ���������� ����� � ���-�������� ��������� ��������!")
				wait(1300)
				sampSendChat("/r ���� ��������� ���, ��� ��������� ���������� ���������� � ��������� 3-� �����.")
				wait(1300)
				sampSendChat("/r ��������� ������� ������� ����� ����� �� ����� ���������� � ���������� � ��!")
			end
			if toparg == 6 then
				sampSendChat("/r ��������� ���������� ����� � ���-�������� ��������� ��������!")
				wait(1300)
				sampSendChat("/r ���� ��������� ���, ��� ��������� ���������� ���������� � ��������� 3-� �����.")
				wait(1300)
				sampSendChat("/r ��������� ������� ������� ����� ����� �� ����� ���������� � ���������� � ��!")
			end
			if toparg == 7 then
				sampSendChat("/r ��������� ����������, ��������� ��������!")
				wait(1300)
				sampSendChat("/r ������� ���� ����� ����������� ������������ � �������� �����.")
				wait(1300)
				sampSendChat("/r ��� �� ������ ����� ����������� � �������� ��� ���� ���-�� �����.")
			end
			if toparg == 8 then
				sampSendChat("/r ��������� ������ � ���������� ������!")
				wait(1300)
				sampSendChat("/r ����� ����� �������� ��� � �� ����� ����� �����:")
				wait(1300)
				sampSendChat("/r ������, ���������� � ���. ������� �� ��������!")
			end
			if toparg == 9 then
				sampSendChat("/r ��������� ����������,��������� ��������.")
				wait(1300)
				sampSendChat("/r ������� ��������� ����� ����� ������ � ���������� �������.")
				wait(1300)
				sampSendChat("/r ��� ������ ��� ���������� - ����� ������.")
			end
			if toparg == 10 then
				sampSendChat("/r ��������� ����������, ��������� ��������.")
				wait(1300)
				sampSendChat("/r �� ����� ��������������� �� �� ��� ��������� � �������.")
				wait(1300)
				sampSendChat("/r ��������: ���������/�� ����� �����, �� ��� ��� ����� ����� �������!")
			end
			if toparg == 11 then
				sampSendChat("/r ��������� ����������, ��������� ��������!")
				wait(1300)
				sampSendChat("/r ���������� ���, ��� ����� ������� � ����� ����.")
				wait(1300)
				sampSendChat("/r �� ��������� ������� �� ������ ������� ��� �������� �������!")
			end
			if toparg == 12 then
				sampSendChat("/r ��������� ����������, ��������� ��������!")
				wait(1300)
				sampSendChat("/r ������ ������� �������...")
				wait(1300)
				sampSendChat("/r ����������� � ����������� �� ''��''")
			end
		end)
	else sampAddChatMessage("{A8FF14}[gHelp]{4682B4} ����������� ������� {FFFC18}/lesson {800000}[1-12]", -1) end
end

function ginvite(playID)
	if sampIsPlayerConnected(playID) and tonumber(playID) then
			local my_nick = mainIni.Main_settings.nickname
			local name = sampGetPlayerNickname(playID)
			local ni, ck = string.match(name, "(%g+)_(%g+)")
			local RPname = ni.." "..ck
		lua_thread.create(function()
			  sampSendChat("����������, �� ��� ���������!")
				wait(1300)
			  sampSendChat("/do �� ����� " .. my_nick .. " ����� �����")
				wait(1300)
				sampSendChat("/me ���� ����� � ����� ��������� ��, ����� ������ ����� � �������")
				wait(1300)
				sampSendChat("/me ������� ����� " .. RPname)
				wait(1300)
				sampSendChat("/invite " .. playID)
			end)
	else sampAddChatMessage("{A8FF14}[gHelp]{4682B4} ����������� ������� {FFFC18}/invite {800000}[id]", -1) end
end

function main_inter_menu()
	show_main_inter_menu.v = not show_main_inter_menu.v
	imgui.Process = show_main_inter_menu.v
end

function main_gh_menu()
  show_main_window.v = not show_main_window.v
  imgui.Process = show_main_window.v
end

function main_spora_menu()
	show_main_spora_menu.v = not show_main_spora_menu.v
	imgui.Process = show_main_spora_menu.v
end

function main_exam_menu()
	show_main_exam_menu.v = not show_main_exam_menu.v
	imgui.Process = show_main_exam_menu.v
end

function apply_custom_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 2.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 13.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0
    colors[clr.Text]            = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]        = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]            = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]        = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]            = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]            = colors[clr.PopupBg]
    colors[clr.Border]            = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]        = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg]            = ImVec4(0.16, 0.29, 0.48, 0.54)
    colors[clr.FrameBgHovered]        = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.FrameBgActive]        = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.TitleBg]            = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive]        = ImVec4(0.16, 0.29, 0.48, 1.00)
    colors[clr.TitleBgCollapsed]        = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.MenuBarBg]            = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]        = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]        = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]    = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CheckMark]            = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.SliderGrab]            = ImVec4(0.24, 0.52, 0.88, 1.00)
    colors[clr.SliderGrabActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Button]            = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.ButtonHovered]        = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ButtonActive]        = ImVec4(0.06, 0.53, 0.98, 1.00)
    colors[clr.Header]            = ImVec4(0.26, 0.59, 0.98, 0.31)
    colors[clr.HeaderHovered]        = ImVec4(0.26, 0.59, 0.98, 0.80)
    colors[clr.HeaderActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Separator]            = colors[clr.Border]
    colors[clr.SeparatorHovered]        = ImVec4(0.26, 0.59, 0.98, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ResizeGrip]            = ImVec4(0.26, 0.59, 0.98, 0.25)
    colors[clr.ResizeGripHovered]    = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.ResizeGripActive]        = ImVec4(0.26, 0.59, 0.98, 0.95)
    colors[clr.CloseButton]        = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]    = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]        = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]            = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]        = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]    = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.TextSelectedBg]        = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.ModalWindowDarkening]    = ImVec4(0.80, 0.80, 0.80, 0.35)
end

apply_custom_style()

show_main_spora_menu = imgui.ImBool(false)
show_main_exam_menu = imgui.ImBool(false)
show_main_window = imgui.ImBool(false)
show_main_dop_menu = imgui.ImBool(false)
show_main_inter_menu = imgui.ImBool(false)
local show_imgui_owner = imgui.ImBool(false)
local show_imgui_command_list = imgui.ImBool(false)
local show_imgui_authors = imgui.ImBool(false)
local show_imgui_spora_yprav = imgui.ImBool(false)
local show_imgui_spora_ymeria = imgui.ImBool(false)
local show_imgui_spora_kn15 = imgui.ImBool(false)
local show_imgui_spora_kn69 = imgui.ImBool(false)
local show_imgui_yk = imgui.ImBool(false)
local show_imgui_ak = imgui.ImBool(false)
local show_imgui_reform = imgui.ImBool(false)
local show_imgui_cmd = imgui.ImBool(false)
local show_imgui_main_bind = imgui.ImBool(false)
local show_imgui_main_binder = imgui.ImBool(false)
function imgui.OnDrawFrame() -- Main Window
	if show_main_inter_menu.v then
		imgui.ShowCursor = true
		local sw, sh = getScreenResolution() -- center
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(300, 100), imgui.Cond.FirstUseEver)
		imgui.Begin(u8'���� �������������', show_main_inter_menu)
		imgui.Button(u8'�����������')
		imgui.Button(u8'�������� ���������')
		imgui.Button(u8'�������� �� ������� �����')
		imgui.Button(u8'������ ���������� IC')
		imgui.Button(u8'�������� �������')
		imgui.Button(u8'��������')
		imgui.Button(u8'�� ��������')
		if not show_main_inter_menu.v then
			imgui.ShowCursor = false
		end
		imgui.End()
	end

	if show_main_dop_menu.v then
		imgui.ShowCursor = true
		local sw, sh = getScreenResolution() -- center
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(300, 100), imgui.Cond.FirstUseEver)
		local ni, ck = string.match(dopmenuNM1, "(%g+)_(%g+)")
		local dopmenuNM2 = ni.." "..ck
		imgui.Begin(u8'���� �������������� � '..dopmenuNM2..'('..dopmenuID1..')', show_main_dop_menu)
		imgui.Text(u8'Cooming soon')
		if not show_main_dop_menu.v then
			imgui.ShowCursor = false
		end
		imgui.End()
	end
	if show_main_exam_menu.v then
		imgui.ShowCursor = true
		local sw, sh = getScreenResolution() -- center
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(300, 100), imgui.Cond.FirstUseEver)
		local btn_size = imgui.ImVec2(-0.1, 0)
		imgui.Begin(u8'������� ���� ��������', show_main_exam_menu)
		if imgui.Button(u8'�������� ���������', btn_size) then
			lua_thread.create(function()
				sampSendChat("/me ����������� ����� � ����� �������, ����� ������ ''����''")
				wait(1500)
				sampSendChat("/do ��������� �������.")
				wait(1500)
				sampSendChat("/me ���� � ���� �����, ������� �� �� ������, ����� ������ ��� ����� � ������ ��������� � �����������")
				wait(1500)
				sampSendChat("/me ����� ������, � ���������, ������")
			end)
		end
		if imgui.Button(u8'������ ������ �� ������ �����', btn_size) then
			local vopros = io.open("moonloader/config/Government Helper/gYstavPrav.ini")
			local rand = math.random(1, 50)
			for line in vopros:lines(rand) do
				text = '1.1 example text'
				numbstr = text:match('(%d+%.%d+)')
				print(numbstr)
			end
			print(nomer)
			vopros:close()
		end
		if not show_main_exam_menu.v then
			imgui.ShowCursor = false
		end
		imgui.End()
	end

	if show_main_spora_menu.v then
		imgui.ShowCursor = true
		local sw, sh = getScreenResolution() -- center
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(300, 240), imgui.Cond.FirstUseEver)
		local btn_size = imgui.ImVec2(-0.1, 0)
		imgui.Begin(u8'��������� ��� ����������� �������������', show_main_spora_menu)
		if imgui.Button(u8'����� �������������', btn_size) then
			show_imgui_spora_yprav.v = not show_imgui_spora_yprav.v
		end
		if imgui.Button(u8'����� �����', btn_size) then
			show_imgui_spora_ymeria.v = not show_imgui_spora_ymeria.v
		end
		if imgui.Button(u8'����� ���������(1-5)', btn_size) then
			show_imgui_spora_kn15.v = not show_imgui_spora_kn15.v
		end
		if imgui.Button(u8'����� ���������(6-9)', btn_size) then
			show_imgui_spora_kn69.v = not show_imgui_spora_kn69.v
		end
		if imgui.CollapsingHeader(u8'��������������') then
			if imgui.Button(u8'��������� ������', btn_size) then
				show_imgui_yk.v = not show_imgui_yk.v
			end
			if imgui.Button(u8'���������������� ������', btn_size) then
				show_imgui_ak.v = not show_imgui_ak.v
			end
			if imgui.Button(u8'�������', btn_size) then
				show_imgui_reform.v = not show_imgui_reform.v
			end
		end

		if show_imgui_spora_yprav.v then
			imgui.Begin(u8'����� �������������', show_imgui_spora_yprav)
			local yprav1 = io.open("moonloader/config/Government Helper/gYstavPrav.ini")
			for line in yprav1:lines() do
				imgui.Text(u8(line))
			end
			yprav1:close()
			imgui.End()
		end
		if show_imgui_spora_ymeria.v then
			imgui.Begin(u8'����� �����', show_imgui_spora_ymeria)
			local yprav2 = io.open("moonloader/config/Government Helper/gYstavMerii.ini")
			for line in yprav2:lines() do
				imgui.Text(u8(line))
			end
			yprav2:close()
			imgui.End()
		end
		if show_imgui_spora_kn15.v then
			imgui.Begin(u8'����� ��������� (1-5)', show_imgui_spora_kn15)
			local yprav3 = io.open("moonloader/config/Government Helper/gkn15.ini")
			for line in yprav3:lines() do
				imgui.Text(u8(line))
			end
			yprav3:close()
			imgui.End()
		end
		if show_imgui_yk.v then
			imgui.Begin(u8'��������� ������', show_imgui_yk)
			local yprav5 = io.open("moonloader/config/Government Helper/gYK.ini")
			for line in yprav5:lines() do
				imgui.Text(u8(line))
			end
			yprav5:close()
			imgui.End()
		end
		if show_imgui_ak.v then
			imgui.Begin(u8'���������������� ������', show_imgui_ak)
			local yprav6 = io.open("moonloader/config/Government Helper/gAK.ini")
			for line in yprav6:lines() do
				imgui.Text(u8(line))
			end
			yprav6:close()
			imgui.End()
		end
		if show_imgui_reform.v then
			imgui.Begin(u8'�������', show_imgui_reform)
			local yprav7 = io.open("moonloader/config/Government Helper/gReform.ini")
			for line in yprav7:lines() do
				imgui.Text(u8(line))
			end
			yprav7:close()
			imgui.End()
		end
		if show_imgui_spora_kn69.v then
			imgui.Begin(u8'����� ��������� (6-9)', show_imgui_spora_kn69)
			local yprav4 = io.open("moonloader/config/Government Helper/gkn69.ini")
			for line in yprav4:lines() do
				imgui.Text(u8(line))
			end
			yprav4:close()
			imgui.End()
		end
		imgui.End()
		if not show_main_spora_menu.v then
			imgui.ShowCursor = false
		end
	end

	if show_main_window.v then
		imgui.LockPlayer = true
		imgui.ShowCursor = true
		local sw, sh = getScreenResolution() -- center
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(300, 200), imgui.Cond.FirstUseEver)
		imgui.Begin(u8'������� ���� Government Helper', show_main_window)
		local btn_size = imgui.ImVec2(-0.1, 0)
		if imgui.Button(u8'�������� ���������', btn_size) then
			show_imgui_owner.v = not show_imgui_owner.v
		end
		if imgui.Button(u8'�������', btn_size) then
			show_imgui_cmd.v = not show_imgui_cmd.v
		end
		if imgui.Button(u8'������', btn_size) then
			show_imgui_main_bind.v = not show_imgui_main_bind.v
		end
		if imgui.Button(u8'������ �� �������', btn_size) then
			show_imgui_main_binder.v = not show_imgui_main_binder.v
		end
		if imgui.CollapsingHeader('F.A.Q') then
			if imgui.Button(u8'������ ������', btn_size) then
				show_imgui_command_list.v = not show_imgui_command_list.v
			end
			if imgui.Button(u8'�����', btn_size) then
				show_imgui_authors.v = not show_imgui_authors.v
			end
		end
		imgui.End()
		if not show_main_window.v then
			imgui.ShowCursor = false
		end
	end

	if show_imgui_owner.v then
		local x, y = getScreenResolution()
		imgui.LockPlayer = true
		imgui.SetNextWindowPos(imgui.ImVec2(x/2, y/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(480, 275), imgui.Cond.FirstUseEver)
		imgui.Begin(u8'�������� ���������', show_imgui_owner)
			imgui.Text(u8'��� ����� ��������� �������� ���������', btn_size)
			imgui.Text(u8'��� Nick Name')
			imgui.SameLine(0, 5)
			imgui.ShowHelpMarker(u8'������� ���� ������� ��� ��� "_"')
			imgui.SameLine(250)
			imgui.Text(u8'�������������� ���������')
			imgui.PushItemWidth(130)
			if imgui.InputText(u8"##enickname", enickname) then
				mainIni.Main_settings.nickname = enickname.v
			end
			imgui.SameLine(250)
			if imgui.Checkbox(u8"������� ���������", cbsex1) then
				mainIni.Check.sex1 = cbsex1.v
			end
			imgui.Text(u8'���� �������')
			imgui.SameLine(0, 5)
			imgui.ShowHelpMarker(u8'������� ���� ������� "LV" "SF" "LS" "AP"')
			imgui.SameLine(250)
			if imgui.Checkbox(u8"RP ��������� ������", cbrpgun) then
				mainIni.Check.rpgun = cbrpgun.v
			end
			imgui.PushItemWidth(131)
			if imgui.InputText(u8"##ework", ework) then
				mainIni.Main_settings.work = ework.v
			end
			imgui.SameLine(250)
			if imgui.Checkbox(u8"����� � ����� �� ���������", cbasc) then
				mainIni.Check.asc = cbasc.v
			end
			imgui.Text(u8'���� ���������')
			imgui.SameLine(0, 5)
			imgui.ShowHelpMarker(u8'������� ����� ����� ��������� �� 1-11')
			imgui.SameLine(250)
			if imgui.Checkbox(u8"RP ��������� ��� ��������� SMS", cbrpsms) then
				mainIni.Check.rpsms = cbrpsms.v
			end
			imgui.PushItemWidth(132)
			if imgui.InputText(u8"##erang", erang) then
				mainIni.Main_settings.rang = erang.v
			end
			imgui.SameLine(250)
			if imgui.Checkbox(u8"����� ���� gNews", cbgnews) then
				mainIni.Check.gnews = cbgnews.v
			end
			imgui.Text(u8'��� ����� ��������')
			imgui.SameLine(0, 5)
			imgui.ShowHelpMarker(u8'������� ��� ����������� ����� ��������')
			imgui.PushItemWidth(133)
			if imgui.InputText(u8"##enumb", enumb) then
				mainIni.Main_settings.numb = enumb.v
			end
			imgui.Text(u8'��� ��� � /f')
			imgui.SameLine(0, 5)
			imgui.ShowHelpMarker(u8'������� ��� ���, ������� ����� ����������� /f(��� [])')
			imgui.PushItemWidth(134)
			if imgui.InputText(u8"##etag", etag) then
				mainIni.Main_settings.tag = etag.v
			end
		imgui.End()
	end

	if show_imgui_main_bind.v then
		local x, y = getScreenResolution()
		imgui.LockPlayer = true
		imgui.SetNextWindowPos(imgui.ImVec2(x/2, y/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(900, 500), imgui.Cond.FirstUseEver)
		imgui.Begin(u8'������', show_imgui_main_bind)
		imgui.Text(u8'cooming soon')
		imgui.End()
	end

	if show_imgui_cmd.v then
		local x, y = getScreenResolution()
		imgui.LockPlayer = true
		imgui.SetNextWindowPos(imgui.ImVec2(x/2, y/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(570, 210), imgui.Cond.FirstUseEver)
		imgui.Begin(u8'�������', show_imgui_cmd)
		imgui.Text(u8'��� �������� ��������� ������� ������� �� ������� ������� ������� � ������ �������')
		if imgui.Hotkey(u8"/cmd", hkCMD, 80) then
			if isKeysBinded(hkCMD.v) then
				nextLockKey = hkCMD.v
				hkCMD.v = mainIni.Keys.CMD
			else
				nextLockKey = hkCMD.v
				mainIni.Keys.CMD = hkCMD.v
			end
		end
		imgui.SameLine(350)
		if imgui.Hotkey(u8"/sfind", hksfind, 80) then
			if isKeysBinded(hksfind.v) then
				nextLockKey = hksfind.v
				hksfind.v = mainIni.Keys.sfind
			else
				nextLockKey = hksfind.v
				mainIni.Keys.sfind = hksfind.v
			end
		end
		if imgui.Hotkey(u8"/spora", hkspora, 80) then
			if isKeysBinded(hkspora.v) then
				nextLockKey = hkspora.v
				hkspora.v = mainIni.Keys.spora
			else
				nextLockKey = hkspora.v
				mainIni.Keys.spora = hkspora.v
			end
		end
		if imgui.Hotkey(u8"/clock", hkclock, 80) then
			if isKeysBinded(hkclock.v) then
				nextLockKey = hkclock.v
				hkclock.v = mainIni.Keys.clock
			else
				nextLockKey = hkclock.v
				mainIni.Keys.clock = hkclock.v
			end
		end
		if imgui.Hotkey(u8"/rp", hkrp, 80) then
			if isKeysBinded(hkrp.v) then
				nextLockKey = hkrp.v
				hkrp.v = mainIni.Keys.rp
			else
				nextLockKey = hkrp.v
				mainIni.Keys.rp = hkrp.v
			end
		end
		if imgui.Hotkey(u8"/stop", hkstop, 80) then
			if isKeysBinded(hkstop.v) then
				nextLockKey = hkstop.v
				hkstop.v = mainIni.Keys.stop
			else
				nextLockKey = hkstop.v
				mainIni.Keys.stop = hkstop.v
			end
		end
		if imgui.Hotkey(u8"/badge", hkbadge, 80) then
			if isKeysBinded(hkbadge.v) then
				nextLockKey = hkbadge.v
				hkbadge.v = mainIni.Keys.badge
			else
				nextLockKey = hkbadge.v
				mainIni.Keys.badge = hkbadge.v
			end
		end
		imgui.SameLine(350)
		if imgui.Hotkey(u8"/alldrop", hkhreset, 80) then
			if isKeysBinded(hkhreset.v) then
				nextLockKey = hkhreset.v
				hkhreset.v = mainIni.Keys.hreset
			else
				nextLockKey = hkhreset.v
				mainIni.Keys.hreset = hkhreset.v
			end
		end
		imgui.Text(u8'������� ����� �����������/���������')
		imgui.End()
	end

	if show_imgui_main_binder.v then
		local x, y = getScreenResolution()
		imgui.LockPlayer = true
		imgui.SetNextWindowPos(imgui.ImVec2(x/2, y/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(900, 500), imgui.Cond.FirstUseEver)
		imgui.Begin(u8'������ �� �������', show_imgui_main_binder)
		imgui.Text(u8'cooming soon')
		imgui.End()
	end
					if show_imgui_command_list.v then
					imgui.Begin(u8'������ ������', show_imgui_command_list)
					imgui.Text(u8'��� �������� ��� ������� �������:')
					imgui.Text(u8'�������:')
					imgui.Text(u8'/cmd - ������� � ��������� �� ����������� ��� ����� ���������')
					imgui.Text(u8'/show - ������� ��� ��������� ��, ��, ������ �������������/�����, ����� ���������')
					imgui.Text(u8'/clock - ������� ��� �� ��������� �����')
					imgui.Text(u8'/rp - Role Play �������')
					imgui.Text(u8'/invite [id] - �� ��������� ����������� �� �������')
					imgui.Text(u8'/uninvite [id] [reason] - �� ��������� �����������')
					imgui.Text(u8'/rang [id] +/- - �� ��������� ���������/��������� ����������')
					imgui.Text(u8'/vig [id] [reason] - ������ ������� ���������� � �� ����������')
					imgui.Text(u8'/bl [id] - �������� ���������� �� ���������� � ������ ������ �������������')
					imgui.Text(u8'/stop - ���������� �� ���������')
					imgui.Text(u8'/badge - �������� ������� � �� �����������')
					imgui.Text(u8'/rn | /fn - ����� ����� � ������ �����')
					imgui.Text(u8'/story [id] - ���������� ������� ����� ���� �� ID')
					imgui.Text(u8'/sfind - �� ��������� ������� /find � ��������� ���������� �����������')
					imgui.Text(u8'/okay [id] - ������� ������ �� ���������')
					imgui.Text(u8'/exam - �������� ������� ��� �����������')
					imgui.Text(u8'/hreset - /reset | /drop | /armoff')
					imgui.Text(u8'/autopost - �������������� ������� � ����� (1-2 ����)')
					imgui.End()
				end
				if show_imgui_authors.v then
					imgui.Begin(u8'����� �������', show_imgui_authors)
					imgui.Text(u8'����� ������� ������� �������� - Lucio Salieri')
					imgui.Text(u8'�������� ���� �� ������ � ������ �������� *������*')
					imgui.Text(u8'������ ������ ������������ ��� ���� ����������� �������������')
					imgui.Text(u8'� ��� ���� �������� Advance RP')
					imgui.End()
				end
	end

function isKeysBinded(str)
	local bool = false
	for k, v in pairs(mainIni.Keys) do
		if tostring(str) == tostring(v) and tostring(v):len() > 0 then
			bool = true
			break
		end
	end
	return bool
end

function imgui.Hotkey(name, keyBuf, width)
	local name = tostring(name)
	local keys, endkey = getDownKeys()
	local keysName = ""
	local ImVec2 = imgui.ImVec2
	local bool = false
	if editHotkey == name then
		if keys == VK_BACK then
			keyBuf.v = ''
			editHotkey = nil
			nextLockKey = keys
			editKeys = 0
			bool = true
		else
			local tNames = string.split(keys, " ")
			local keylist = ""
			for _, v in ipairs(tNames) do
				local key = tostring(vkeys.id_to_name(tonumber(v)))
				if tostring(keylist):len() == 0 then
					keylist = key
				else
					keylist = keylist .. " + " .. key
				end
			end
			keysName = keylist
			if endkey then
				bool = true
				keyBuf.v = keys
				editHotkey = nil
				nextLockKey = keys
				editKeys = 0
			end
		end
	else
		local tNames = string.split(keyBuf.v, " ")
		for _, v in ipairs(tNames) do
			local key = tostring(vkeys.id_to_name(tonumber(v)))
			if tostring(keysName):len() == 0 then
				keysName = key
			else
				keysName = keysName .. " + " .. key
			end
		end
	end
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	imgui.PushStyleColor(imgui.Col.Button, colors[clr.FrameBg])
	imgui.PushStyleColor(imgui.Col.ButtonActive, colors[clr.FrameBg])
	imgui.PushStyleColor(imgui.Col.ButtonHovered, colors[clr.FrameBg])
	imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign, ImVec2(0.04, 0.5))
	imgui.AlignTextToFramePadding()
	imgui.Button(u8((tostring(keysName):len() > 0 or editHotkey == name) and keysName or "���"), ImVec2(width, 20))
	imgui.PopStyleVar()
	imgui.PopStyleColor(3)
	if imgui.IsItemHovered() and imgui.IsItemClicked() and editHotkey == nil then
		editHotkey = name
		editKeys = 100
	end
	if name:len() > 0 then
		imgui.SameLine()
		imgui.Text(name)
	end
	return bool
end

function string.split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

function isKeysDown(keylist, pressed)
	local tKeys = string.split(keylist, " ")
	if pressed == nil then
		pressed = false
	end
	if tKeys[1] == nil then
		return false
	end
	local bool = false
	local key = #tKeys < 2 and tonumber(tKeys[1]) or tonumber(tKeys[2])
	local modified = tonumber(tKeys[1])
	if #tKeys < 2 then
		if not isKeyDown(VK_RMENU) and not isKeyDown(VK_LMENU) and not isKeyDown(VK_LSHIFT) and not isKeyDown(VK_RSHIFT) and not isKeyDown(VK_LCONTROL) and not isKeyDown(VK_RCONTROL) then
			if wasKeyPressed(key) and not pressed then
				bool = true
			elseif isKeyDown(key) and pressed then
				bool = true
			end
		end
	else
		if isKeyDown(modified) and not wasKeyReleased(modified) then
			if wasKeyPressed(key) and not pressed then
				bool = true
			elseif isKeyDown(key) and pressed then
				bool = true
			end
		end
	end
	if tostring(nextLockKey) == tostring(keylist) then
		if pressed and not wasKeyReleased(key) then
			bool = false
--			nextLockKey = ""
		else
			bool = false
			nextLockKey = ""
		end
	end
	return bool
end

function getDownKeys()
	local curkeys = ""
	local bool = false
	for k, v in pairs(vkeys) do
		if isKeyDown(v) and (v == VK_MENU or v == VK_CONTROL or v == VK_SHIFT or v == VK_LMENU or v == VK_RMENU or v == VK_RCONTROL or v == VK_LCONTROL or v == VK_LSHIFT or v == VK_RSHIFT) then
			if v ~= VK_MENU and v ~= VK_CONTROL and v ~= VK_SHIFT then
				curkeys = v
			end
		end
	end
	for k, v in pairs(vkeys) do
		if isKeyDown(v) and (v ~= VK_MENU and v ~= VK_CONTROL and v ~= VK_SHIFT and v ~= VK_LMENU and v ~= VK_RMENU and v ~= VK_RCONTROL and v ~= VK_LCONTROL and v ~= VK_LSHIFT and v ~= VK_RSHIFT) then
			if tostring(curkeys):len() == 0 then
				curkeys = v
			else
				curkeys = curkeys .. " " .. v
			end
			bool = true
		end
	end
	return curkeys, bool
end

function imgui.ShowHelpMarker(param)
    imgui.TextDisabled('(?)')
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.PushTextWrapPos(imgui.GetFontSize() * 35.0)
        imgui.TextUnformatted(param)
        imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end
