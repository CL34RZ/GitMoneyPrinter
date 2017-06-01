include("shared.lua")

surface.CreateFont( "MoneyFont", {
	font = "Arial",
	extended = false,
	size = 65,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont("outline", {
	font = "Arial",
	size = 70
	})

surface.CreateFont("PrinterFont", {
	font = "Arial",
	size = 40,
} )

function ENT:Draw()

	self:DrawModel()

	local pos = self:GetPos()
	local ang = self:GetAngles()

	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 90)

	cam.Start3D2D(pos+ang:Up()*7.5, ang, 0.1)
	draw.SimpleTextOutlined(GAMEMODE.Config.currency ..self:GetMoneyStored(),"MoneyFont",0,0,Color(255,255,255),1,1,2,Color(0,0,0))
	cam.End3D2D()

	ang:RotateAroundAxis(ang:Forward(),-90)
	cam.Start3D2D(pos+ang:Up()*3.5, ang, 0.1)
	draw.SimpleTextOutlined("Test Printer","PrinterFont",0,0,Color(255,255,255),1,1,2,Color(0,0,0))
	cam.End3D2D()

end