ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Test Printer"
ENT.Category = "MaverickEntities"
ENT.Spawnable = true

function ENT:SetupDataTables()

	self:NetworkVar("Int",1,"MoneyStored")

end