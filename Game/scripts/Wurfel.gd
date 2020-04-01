extends Control

onready var W1 = $Button/W1
onready var W2 = $Button/W2
onready var t = $Button/VScrollBar/RichTextLabel

func _ready():
	pass

remotesync func wurfel(a,b,id):
	W1.frame = a
	W2.frame = b
	t.text = id+" hat " + str(a+b+2) + " gewürfelt\n\n" + t.text 


func _on_Button_pressed():
	rpc("wurfel",randi()%6,randi()%6,Globals.local_name)
