extends Node

var Id_in_match = 1

var Town_status = null setget set_town_status

func set_town_status(value):
	Town_status = value
	match value:
		null:
			$"/root/Main/Game/Right/Notify".text = "Wait a minute"
		"Pick_town":
			$"/root/Main/Game/Right/Notify".text = "Pick town"
		"Pick_capital":
			$"/root/Main/Game/Right/Notify".text = "Pick capital"
		"Open_interface":
			Update_all_town_info()
			$"/root/Main/Game/Right/Notify".text = "The peace time is started"
			Time = 60
			Count_time()
			
var Towns = {0:{"Master":null}}
var Time = 60 


#{Property, master}

var History = {0:{}}

#[]
#{1:[ year[after [Def][attack] ][before]], []}

#{ 0: {2:{before:{}, after:{}, permission:{}, town_master:{} }}

var Soldiers = {}

# {Property, Level, hp, dame, address, destination, is_king, master, country}

func Get_soldiers_in_town(town):
	var t = []
	for i in Soldiers.values():
		if i.Destination == town:
			t.push_back(i)
	return t

func Get_soldiers_of_town(town):
	var t = []
	for i in Soldiers.values():
		if i.Country == town:
			t.push_back(i)
	return t

func Get_soldiers(town):
	var t = []
	for i in Soldiers.values():
		if i.Address == town:
			t.push_back(i)
	return t

func Get_king():
	for i in Soldiers.values():
		if i.Five_elements == 5:
			return i
	
func Update_all_town_info():
	for i in 25:
		$"/root/Main/Game/Left/GridContainer".get_child(i).Update_info()

func Count_time():
	$"/root/Main/Game/Right/Time".text = str(Time)
	if Time > 0 :
		Time -= 1
	else:
		Net.rpc("Ready")
		Town_status = null
		return
	yield(get_tree().create_timer(1),"timeout")
	Count_time()
