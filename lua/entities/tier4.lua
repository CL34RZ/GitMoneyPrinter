AddCSLuaFile()
-- Config --
local PrintersIntv = 2 -- How often money will print in seconds
--
local PrinterMade = 45 -- How much this printer will make every interval (how many seconds you decided above)
--
local PrinterColor = Color(51,102,255) -- Color of this printer
--
local PrinterName = "Diamond Printer" -- Name of this printer
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
	self:NetworkVar("Int",0,"DiamondStored")
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
		self.cl_silenced = false
		self.intvl = CurTime()
		if self.PrinterMakesNoise then
			self:EmitSound("noise_Loop")
		end
	end

	function ENT:Think()
		if CurTime() > self.intvl + interval then
			self.intvl = CurTime()
			self:SetDiamondStored(self:GetDiamondStored()+PrinterMade)
		end
		if self:WaterLevel() >= 3 then
			self:Remove()
		end
	end

	function ENT:Use(act,ply)
		local money = self:GetDiamondStored()
		if IsValid(ply) && ply:IsPlayer() && money > 0 then
			self:SetDiamondStored(0)
			ply:addMoney(money)
			DarkRP.notify(ply,0,4,"You have picked up ".. GAMEMODE.Config.currency .. string.Comma(money) .."!")
		end
	end

	function ENT:OnTakeDamage(dmg)
		self:SetHealth(self:Health() - dmg:GetDamage())
		if self:Health() <= 0 then
			self:Remove()
		end
	end

	function ENT:Touch(ent)
		if ent.IsSilencer and self.PrinterMakesNoise then
			if not self.cl_silenced then
				ent:Remove()
				self:StopSound("noise_loop")
				self.cl_silenced = true
			end
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
		font = "quantify",
		size = 75,
		antialias = true
	})

	surface.CreateFont("SmallInfo", {
		font = "quantify",
		size = 45,
		antialias = true
	})
	function ENT:Draw()
		self:DrawModel()
		local Owner = self:Getowning_ent()
		if IsValid(Owner) and Owner:Nick() then 
			Owner = Owner:Nick()
			if string.len(Owner) > 11 then
				Owner = string.Left( Owner, 11 ).."..."
			end
		else 
			Owner = "Unknown" 
		end
		if self:GetPos():Distance( LocalPlayer():GetPos() ) > 1000 then return end

		local pos = self:GetPos()
		local ang = self:GetAngles()
		local MoneyText = string.Left(GAMEMODE.Config.currency..string.Comma(self:GetDiamondStored()),7)
		local NameText = Owner

		ang:RotateAroundAxis(ang:Up(),90)

		cam.Start3D2D(pos+ang:Up()*10.6,ang,0.1)
			draw.RoundedBox(0,-125,-140,260,85,Color(94,94,94,120))
			draw.SimpleTextOutlined(MoneyText,"BigInfo",-120,-100,Color(255,255,255),0,1,2,Color(0,0,0))
			draw.RoundedBox(0,-125,-25,260,85,Color(94,94,94,120))
			draw.SimpleTextOutlined(NameText,"SmallInfo",-120,15,Color(255,255,255),0,1,2,Color(0,0,0))
		cam.End3D2D()

		ang:RotateAroundAxis(ang:Forward(),90)

		cam.Start3D2D(pos+ang:Up()*17,ang,0.1)
			draw.RoundedBox(0,-150,-110,308,106,Color(94,94,94,120))
			draw.SimpleTextOutlined(string.Left(PrinterName,16),"SmallInfo",-145,-85,Color(255,255,255),0,0,2,Color(0,0,0))
		cam.End3D2D()
	end
end