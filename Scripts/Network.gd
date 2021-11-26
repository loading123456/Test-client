extends Node


var Network = NetworkedMultiplayerENet.new()
var Port = 1090
var Ip = "192.168.0.100"
var PossitionMain 
var MyId 

func _ready():
	#Test pull
	startClient()

	
func startClient():
	Network.create_client(Ip,Port)
	get_tree().set_network_peer(Network)
	MyId = get_tree().get_network_unique_id()



remote func Init_match(data,player_id):
	if MyId == player_id:
		Storage.Id_in_match = 0
		$"/root/Main/Game/Right/Flag".texture = load("res://Assets/Flags/Flag0.png")
	Storage.Towns = data
	for i in range(25):
		$"/root/Main/Game/Left/GridContainer".get_child(i).texture_normal = load("res://Assets/Towns/"+str(data[i].Five_elements)+".png")
	Storage.Update_all_town_info()
	
	
remote func Before_pick_town(town):
	if town != null:
		Storage.Towns[town].Master = (Storage.Id_in_match+1)%2
		$"/root/Main/Game/Left/GridContainer".get_child(town).get_node("Flag").texture = load("res://Assets/Flags/Flag"+str((Storage.Id_in_match+1)%2) +".png")
	Storage.Town_status = "Pick_town"

remote func Before_pick_capital():
	Storage.Town_status = "Pick_capital"

remote func Start_peace_time(towns, soldiers, history):
	print("Start peace time ")
	Storage.Town_status = "Open_interface"
	Storage.Towns = towns
	Storage.Soldiers = soldiers
	Storage.History = history
	
	$"/root/Main/Game/Right/HBoxContainer/Flag0".self_modulate = "#7f7f7f"
	$"/root/Main/Game/Right/HBoxContainer/Flag1".self_modulate = "#7f7f7f"

remote func Another_player_ready():
	get_node("Right/HBoxContainer/Flag"+str(Storage.Id_in_match+1)%2).self_modulate = Color(1, 1, 1, 1)

