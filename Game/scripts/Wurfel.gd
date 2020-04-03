extends Control

onready var W1 = $Button/W1
onready var W2 = $Button/W2
onready var t = $Button/VScrollBar/RichTextLabel
var rng 
func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()

remotesync func wurfel(a,b,id):
	W1.frame = a
	W2.frame = b
	t.text = id+" hat " + str(a+b+2) + " gewürfelt\n\n" + t.text 

func _on_Button_pressed():
	
	var a = rng.randi()%6
	var b = rng.randi()%6
	if(a+b+2 == 7):
		Globals.canBuildThief = true
	else:
		Globals.canBuildThief = false
	rpc("wurfel",a,b,Globals.local_name)
