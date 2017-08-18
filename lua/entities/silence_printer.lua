AddCSLuaFile()
-- Don't touch this unless you know what you're doing --
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Printer Silencer"
ENT.Author = "CL34R"
ENT.Category = "SimplePrinters"
ENT.Spawnable = true

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/props_lab/reciever01a.mdl")
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetHealth(50)
		self.IsSilencer = true
	end

	function ENT:OnTakeDamage(dmg)
		self:SetHealth(self:Health() - dmg:GetDamage())
		if self:Health() <= 0 then
			self:Remove()
		end
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()

		local pos = self:GetPos()
		local ang = self:GetAngles()

		ang:RotateAroundAxis(ang:Up(),90)
		cam.Start3D2D(pos+ang:Up()*3.3,ang,0.1)
			draw.SimpleTextOutlined("Printer Silencer","SmallInfo",0,-10,Color(255,255,255),1,1,2,Color(0,0,0))
		cam.End3D2D()
	end
end