extends Spatial

var ISSTADT : bool
var mouseOver
var isBuilt
var local_color
onready var red = $"Siedlung/SiedlungRed"
onready var blue = $"Siedlung/SiedlungBlue"
onready var yellow = $"Siedlung/SiedlungYellow"
onready var green = $"Siedlung/SiedlungGreen"
onready var transparent = $"Transparent"

onready var redS = $"Staedte/StadtRed"
onready var blueS = $"Staedte/StadtBlue"
onready var yellowS = $"Staedte/StadtYellow"
onready var greenS = $"Staedte/StadtGreen"

func setStadt(b:bool):
	ISSTADT = b

func _ready():
	$Area.connect("mouse_entered",self,"mouse_entered")
	$Area.connect("mouse_exited",self,"mouse_exited")

func mouse_entered():
	mouseOver = true
func mouse_exited():
	mouseOver = false

remotesync func buildWithColor(s):
	isBuilt = true
	local_color = s
	if s == "Rot":
		red.show()
	elif s == "Gelb":
		yellow.show()
	elif s == "Blau":
		blue.show()
	elif s == "Gruen":
		green.show()

remotesync func buildWithColorStadt(s):
	isBuilt = true
	local_color = s
	if s == "Rot":
		redS.show()
	elif s == "Gelb":
		yellowS.show()
	elif s == "Blau":
		blueS.show()
	elif s == "Gruen":
		greenS.show()

remotesync func destroy():
	isBuilt = false
	red.hide()
	yellow.hide()
	blue.hide()
	green.hide()

	redS.hide()
	yellowS.hide()
	blueS.hide()
	greenS.hide()

func _input(event):
	if not isBuilt:
		if mouseOver:
			transparent.show()
			if Input.is_action_just_pressed("LeftMouseButton"):
				transparent.hide()
				rpc("buildWithColor",Globals.color)
			if Input.is_action_just_pressed("RightMouseButton"):
				transparent.hide()
				rpc("buildWithColorStadt",Globals.color)
		else:
			transparent.hide()
	else:
		if mouseOver:
			if local_color == Globals.color:
				if Input.is_action_just_pressed("LeftMouseButton"):
					rpc("destroy")
