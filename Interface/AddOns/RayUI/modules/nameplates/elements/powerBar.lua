local R, L, P = unpack(select(2, ...)) --Import: Engine, Locales, ProfileDB, local
local mod = R:GetModule('NamePlates')
local LSM = LibStub("LibSharedMedia-3.0")


function mod:UpdateElement_MaxPower(frame)
	local maxValue = UnitPowerMax(frame.displayedUnit, frame.PowerToken);
	frame.PowerBar:SetMinMaxValues(0, maxValue);
end

local temp = {1, 1, 1}
function mod:UpdateElement_Power(frame)
	self:UpdateElement_MaxPower(frame)
	
	local curValue = UnitPower(frame.displayedUnit, frame.PowerToken);
	frame.PowerBar:SetValue(curValue);	

	local color = RayUF.colors.power[frame.PowerToken] or temp

	if(color) then
		frame.PowerBar:SetStatusBarColor(unpack(color))
	end	
end 

function mod:ConfigureElement_PowerBar(frame)
	local powerBar = frame.PowerBar
	powerBar:SetPoint("TOPLEFT", frame.HealthBar, "BOTTOMLEFT", 0, -3)
	powerBar:SetPoint("TOPRIGHT", frame.HealthBar, "BOTTOMRIGHT", 0, -3)
	powerBar:SetHeight(self.db.pbHeight)
	powerBar:SetStatusBarTexture(LSM:Fetch("statusbar", R.global.media.normal))
end


function mod:ConstructElement_PowerBar(parent)
	local frame = CreateFrame("StatusBar", "$parentPowerBar", parent)
	self:StyleFrame(frame)
	frame:Hide()

	return frame
end