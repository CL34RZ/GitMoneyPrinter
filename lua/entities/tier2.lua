AddCSLuaFile()
-- Config --
local PrintersIntv = 2 -- How often money will print in seconds
--
local PrinterMade = 25 -- How much this printer will make every interval (how many seconds you decided above)
--
local PrinterColor = Color(192,192,192) -- Color of this printer
--
local PrinterName = "Silver Printer" -- Name of this printer
--
ENT.PrinterMakesNoise = true -- Wether or not the printer should make a noise
-- End --


-- Do not edit anything below unless you know what you're doing --

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = PrinterName
ENT.Author = "CL34R"
ENT.Category = "SimplePrinters"
ENT.Spawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Int",0,"SilverStored")
	self:NetworkVar("Entity",0,"owning_ent")
end

if SERVER then
	local interval = PrintersIntv

	function ENT:Initialize()
		self:SetModel("models/props_c17/consolebox01a.mdl")
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetColor(PrinterColor)
		self:SetUseType(SIMPLE_USE)
		self:SetHealth(150)
		self.intvl = CurTime()
		if self.PrinterMakesNoise then
			self:EmitSound("noise_Loop")
		end
	end

	function ENT:Think()
		if CurTime() > self.intvl + interval then
			self.intvl = CurTime()
			self:SetSilverStored(self:GetSilverStored()+PrinterMade)
		end
	end

	function ENT:Use(act,ply)
		local money = self:GetSilverStored()
		if IsValid(ply) && ply:IsPlayer() && money > 0 then
			self:SetSilverStored(0)
			ply:addMoney(money)
			DarkRP.notify(ply,0,4,"You have picked up ".. GAMEMODE.Config.currency .. money .."!")
		end
	end

	function ENT:OnTakeDamage(dmg)
		self:SetHealth(self:Health() - dmg:GetDamage())
		if self:Health() <= 0 then
			self:Remove()
		end
	end

	function ENT:Touch(ent)
		if ent.IsSilencer && self.PrinterMakesNoise then
			ent:Remove()
			self:StopSound("noise_loop")
		end
	end

	function ENT:OnRemove()
		self:StopSound("noise_Loop")
	end

	sound.Add( {
		name = "noise_Loop",
		channel = CHAN_STATIC,
		volume = 0.5,
		soundlevel = 60,
		sound = "ambient/levels/labs/equipment_printer_loop1.wav"
	})
end

if CLIENT then
	surface.CreateFont("BigInfo", {
		font = "Impact",
		size = 75,
		antialias = true
	})

	surface.CreateFont("SmallInfo", {
		font = "Impact",
		size = 55,
		antialias = true
	})

	function ENT:Draw()
		self:DrawModel()
		local Owner = self:Getowning_ent()
		if IsValid(Owner) and Owner:Nick() then 
			Owner = Owner:Nick()
			if string.len(Owner) > 7 then
				Owner = string.Left( Owner, 7 ).."..."
			end
		else 
			Owner = "Unknown" 
		end
		if self:GetPos():Distance( LocalPlayer():GetPos() ) > 1000 then return end

		local pos = self:GetPos()
		local ang = self:GetAngles()
		local MoneyText = GAMEMODE.Config.currency..self:GetSilverStored()
		local MoneyBoxSize = select(1,surface.GetTextSize(MoneyText))
		local NameText = Owner

		ang:RotateAroundAxis(ang:Up(),90)

		cam.Start3D2D(pos+ang:Up()*10.6,ang,0.1)
			surface.SetDrawColor(Color(120,120,120,120))
			surface.DrawRect(-85,-140,MoneyBoxSize+10,75)
			
			surface.SetFont("BigInfo")
			-- Bottom left of outline
			surface.SetTextColor(Color(0,0,0))
			surface.SetTextPos(-80,-142)
			surface.DrawText(MoneyText)
			-- Top right of outline
			surface.SetTextPos(-84,-146)
			surface.SetTextColor(0,0,0)
			surface.DrawText(MoneyText)
			-- Main white text
			surface.SetTextPos(-82,-144)
			surface.SetTextColor(255,255,255)
			surface.DrawText(MoneyText)

			-- Drawing rectangle for name to sit in
			surface.DrawRect(-105,0,select(1,surface.GetTextSize(NameText)),select(2,surface.GetTextSize(NameText)))
			-- Drawing player's name
			surface.SetFont("SmallInfo")
			surface.SetTextPos(-100,0)
			surface.DrawText(NameText)
		cam.End3D2D()

		ang:RotateAroundAxis(ang:Forward(),90)

		cam.Start3D2D(pos+ang:Up()*17,ang,0.1)
			surface.DrawRect(-150,-100,select(1,surface.GetTextSize(PrinterName),select(2,surface.GetTextSize(PrinterName))))
			surface.SetTextPos(-150,-100)
			surface.DrawText(PrinterName)
		cam.End3D2D()

	end
end