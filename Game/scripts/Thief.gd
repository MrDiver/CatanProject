extends Spatial
var mouseOver = false
var isBuilt = false
onready var transparent = $Transparent
onready var indicator = $Transparent2
onready var thief = $Thief
func _ready():
	$Area.connect("mouse_entered",self,"mouse_entered")
	$Area.connect("mouse_exited",self,"mouse_exited")
	hideAll()


func mouse_entered():
	mouseOver = true
func mouse_exited():
	mouseOver = false

remotesync func buildThief():
	isBuilt = true
	Globals.canBuildThief = false
	thief.show()

remotesync func destroy():
	isBuilt = false
	thief.hide()

remotesync func hideAll():
	transparent.hide()
	thief.hide()
	indicator.hide()
	isBuilt = false

func _process(_delta):
	if(Globals.canBuildThief):
		rpc("hideAll")
		indicator.show()
		if not isBuilt:
			if mouseOver:
				transparent.show()
				if Input.is_action_just_pressed("LeftMouseButton"):
					transparent.hide()
					isBuilt = true
					rpc("buildThief")
			else:
				transparent.hide()
	else:
		indicator.hide()