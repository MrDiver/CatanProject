extends Spatial

onready var red = $"Area/CollisionShape/StreetRed"
onready var green = $"Area/CollisionShape/StreetGreen"
onready var yellow = $"Area/CollisionShape/StreetYellow"
onready var blue = $"Area/CollisionShape/StreetBlue"
onready var transparent = $"Area/CollisionShape/Transparent"
var mouseOver : bool = false
var isBuilt : bool = false
var local_color = ""
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

remotesync func destroy():
	isBuilt = false
	red.hide()
	yellow.hide()
	blue.hide()
	green.hide()

func _process(_delta):
	if not isBuilt:
		if mouseOver:
			transparent.show()
			if Input.is_action_just_pressed("LeftMouseButton"):
				transparent.hide()
				rpc("buildWithColor",Globals.color)
		else:
			transparent.hide()
	else:
		if mouseOver:
			if local_color == Globals.color:
				if Input.is_action_just_pressed("LeftMouseButton"):
					rpc("destroy")