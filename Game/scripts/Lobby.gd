extends Control
var gameStarted = false
var upnp = UPNP.new()
var Colors = ["Gelb","Blau","Gruen"]


func _ready():
	get_tree().connect("network_peer_connected",self,"player_connected")
	get_tree().connect("network_peer_disconnected",self,"player_disconnected")
	$Start.hide()
	$HostButton.disabled = true
	$JoinButton.disabled = true
	upnp.discover()
	#print(upnp.get_device_count())
	var gate : UPNPDevice = upnp.get_gateway()
	#print(gate)
	#print(gate.is_valid_gateway())
	if not gate.is_valid_gateway():
		var popupWindow = AcceptDialog.new()
		self.add_child(popupWindow)
		popupWindow.set_title("TEST")	
		popupWindow.show()
		popupWindow.dialog_text = "!!!WARNING ROUTER MAY NOT BE SUPPORTED!!!"
	
func _on_nameline_text_changed(s):
	#print("NameChanged",s)
	if $nameline.text.length()>1:
		$HostButton.disabled = false
		$JoinButton.disabled = false
	else:
		$HostButton.disabled = true
		$JoinButton.disabled = true
		
func player_connected(id):
	Globals.players.append(id)
	var i = Globals.players.find(id)
	rpc("addToLabel", "\nPlayer joined the game: " + str(id))
	if gameStarted:
		rpc_id(id,"setColor",Colors[i])
		rpc_id(id,"load_game")


func player_disconnected(id):
	var i = Globals.players.find(id)
	Globals.players.remove(i)

func _on_HostButton_pressed():
	var host = NetworkedMultiplayerENet.new()
	var ipaddr = $ipline.text
	var port = $portline.text
	var seedtmp = $seedline.text
	# Add port forwarding
	upnp.add_port_mapping(int(port))
	Globals.local_name = $nameline.text
	disabledAll()
	Globals.SEED = int(seedtmp)
	Globals.color = "Rot"
	var res = host.create_server(int(port),3)
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


func _on_Start_pressed():
	Colors = ["Gelb","Blau","Gruen"]
	for c in Globals.players:
		var i = Globals.players.find(c)
		rpc_id(c,"setColor",Colors[i])
		print("Giving Color",Colors)
	gameStarted = true
	rpc("load_game")

remotesync func load_game():
	var game = preload("res://Game/scenes/RunningGame.tscn").instance()
	get_tree().get_root().add_child(game)
	hide()

remotesync func addToLabel(s):
	$Label.text = $Label.text + s

func _on_queryip_pressed():
	var gate = upnp.get_gateway()
	if gate != null:
		var ofc = gate.query_external_address()
		if ofc != "":
			$ipline.text = ofc