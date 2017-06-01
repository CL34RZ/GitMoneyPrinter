AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("config.lua")

include("config.lua")
include("shared.lua")

local interval = moneyTimer

function ENT:Initialize()
	self:SetModel("models/props_lab/reciever01a.mdl")
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetColor(Color(192,137,10))

	self.timer = CurTime()
end

function ENT:Think()

	if CurTime() > self.timer + interval then
		self.timer = CurTime()

		self:SetMoneyStored(self:GetMoneyStored() + amountPrinted)
	end

end

function ENT:OnTakeDamage()
	self:Remove()
end

function ENT:OnDuplicated()
	self:Remove()
end

function ENT:Use(activator, caller)

	self:SetUseType(SIMPLE_USE)

	local money = self:GetMoneyStored()
	if caller:IsPlayer() and money > 0 then
		self:SetMoneyStored(0)
		caller:addMoney(money)
		DarkRP.notify(activator,0,5,"You have picked up ".. GAMEMODE.Config.currency .. money .."!")
	end

end