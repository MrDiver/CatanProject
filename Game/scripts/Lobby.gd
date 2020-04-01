extends Control

func _ready():
	get_tree().connect("network_peer_connected",self,"player_connected")
	$Start.hide()
	$HostButton.disabled = true
	$JoinButton.disabled = true

	
	
func _on_nameline_text_changed(s):
	print("NameChanged",s)
	if $nameline.text.length()>1:
		$HostButton.disabled = false
		$JoinButton.disabled = false
	else:
		$HostButton.disabled = true
		$JoinButton.disabled = true

func player_connected(id):
	Globals.players.append(id)
	rpc("addToLabel", "\nPlayer joined the game: " + str(id))



func _on_HostButton_pressed():
	var host = NetworkedMultiplayerENet.new()
	var ipaddr = $ipline.text
	var port = $portline.text
	var seedtmp = $seedline.text
	Globals.local_name = $nameline.text
	disabledAll()
	Globals.SEED = int(seedtmp)
	Globals.color = "Rot"
	var res = host.create_server(int(port),4)
	if res != OK:
		print("Error Lobby.gd: Failed Creating the Server")
		return
	
	$JoinButton.hide()
	$HostButton.disabled = true
	$Start.show()
	get_tree().set_network_peer(host)
	$Label.text = $Label.text + "\n Sucessfully created Server\n IP: "+str(ipaddr)+"\nPort: "+port

func disabledAll():
	$nameline.editable = false
	$seedline.editable = false
	$portline.editable = false
	$ipline.editable = false

func _on_JoinButton_pressed():
	Globals.local_name = $nameline.text
	disabledAll()
	var client = NetworkedMultiplayerENet.new()
	var ipaddr = $ipline.text
	var port = $portline.text
	client.create_client(ipaddr,int(port))
	get_tree().set_network_peer(client)
	$HostButton.hide()
	$JoinButton.disabled = true
	$Start.hide()

remote func setColor(s):
	Globals.color = s

var Colors = ["Gelb","Blau","Gruen"]
func _on_Start_pressed():
	for c in Globals.players:
		rpc_id(c,"setColor",Colors[0])
		Colors.remove(0)
		print("Giving Color",Colors)
	rpc("load_game")

remotesync func load_game():
	var game = preload("res://Game/scenes/RunningGame.tscn").instance()
	get_tree().get_root().add_child(game)
	hide()

remotesync func addToLabel(s):
	$Label.text = $Label.text + s
