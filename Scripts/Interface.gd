extends Panel

func _on_Exit_pressed():
	visible = false
	for i in $Town/TabContainer/Inside/SoldiersInfo/ScrollContainer/VBoxContainer.get_child_count():
		$Town/TabContainer/Inside/SoldiersInfo/ScrollContainer/VBoxContainer.get_child(i).queue_free()
	for i in $Town/TabContainer/Outside/SoldiersInfo/ScrollContainer/VBoxContainer.get_child_count():
		$Town/TabContainer/Outside/SoldiersInfo/ScrollContainer/VBoxContainer.get_child(i).queue_free()
	for i in $Town/TabContainer/History/SoldiersInfo/ScrollContainer/VBoxContainer.get_child_count():
		$Town/TabContainer/History/SoldiersInfo/ScrollContainer/VBoxContainer.get_child(i).queue_free()
	$Interface/Town/TabContainer/Outside/Destinations

func _on_CheckBoxInside_toggled(button_pressed):
	for i in $Town/TabContainer/Inside/SoldiersInfo/ScrollContainer/VBoxContainer.get_child_count():
		$Town/TabContainer/Inside/SoldiersInfo/ScrollContainer/VBoxContainer.get_child(i).get_node("HBoxContainer/CheckBox").pressed = button_pressed


func _on_CheckBoxOutside_toggled(button_pressed):
	for i in $Town/TabContainer/Outside/SoldiersInfo/ScrollContainer/VBoxContainer.get_child_count():
		$Town/TabContainer/Outside/SoldiersInfo/ScrollContainer/VBoxContainer.get_child(i).get_node("HBoxContainer/CheckBox").pressed = button_pressed

func Open_town(town):
	$Town/TabContainer/Inside/TownInfo/HBoxContainer/TownName/Value.text = str(town)
	$Town/TabContainer/Inside/TownInfo/HBoxContainer/SoldiersInTown/Value.text = str(Storage.Get_soldiers_in_town(town).size())
	$Town/TabContainer/Inside/TownInfo/HBoxContainer/SoldiersOfTown/Value.text = str(Storage.Get_soldiers_of_town(town).size())

	for i in Storage.Get_soldiers_in_town(town):
		var soldier = load("res://Scene/Soldier.tscn").instance()
		soldier.get_node("HBoxContainer/Level/Value").text = str(i.Level)
		soldier.get_node("HBoxContainer/Hp/Value").text = str(i.Hp)
		soldier.get_node("HBoxContainer/Dame/Value").text = str(i.Dame)
		soldier.get_node("HBoxContainer/Address/Value").text = str(i.Address)
		soldier.get_node("HBoxContainer/Destination/Value").text = str(i.Destination)
		soldier.get_node("HBoxContainer/Country/Value").text = str(i.Country)
		soldier.get_node("HBoxContainer/FiveElements").texture = load("res://Assets/Soldiers/Five_elements/"+str(i.Five_elements) + ".png")
		soldier.get_node("Id").text = str(i.Id)
		$Town/TabContainer/Inside/SoldiersInfo/ScrollContainer/VBoxContainer.add_child(soldier)
	
	for i in Storage.Get_soldiers(town):
		var soldier = load("res://Scene/Soldier.tscn").instance()
		soldier.get_node("HBoxContainer/Level/Value").text = str(i.Level)
		soldier.get_node("HBoxContainer/Hp/Value").text = str(i.Hp)
		soldier.get_node("HBoxContainer/Dame/Value").text = str(i.Dame)
		soldier.get_node("HBoxContainer/Address/Value").text = str(i.Address)
		soldier.get_node("HBoxContainer/Destination/Value").text = str(i.Destination)
		soldier.get_node("HBoxContainer/Country/Value").text = str(i.Country)
		soldier.get_node("HBoxContainer/FiveElements").texture = load("res://Assets/Soldiers/Five_elements/"+str(i.Five_elements) + ".png")
		soldier.get_node("Id").text = str(i.Id)
		$Town/TabContainer/Outside/SoldiersInfo/ScrollContainer/VBoxContainer.add_child(soldier)
	
	$Town/TabContainer/Outside/Destinations.clear()
	
	$Town/TabContainer/Outside/Destinations.add_item("Center - Self "+str(town), town)
	if town/5 > 0:
		$Town/TabContainer/Outside/Destinations.add_item("Top - Town "+str(town-5), town-5)
	if town/5 < 4:
		$Town/TabContainer/Outside/Destinations.add_item("Down - Town "+str(town+5), town+5)
	if town%5 >0:
		$Town/TabContainer/Outside/Destinations.add_item("Left - Town "+str(town-1), town-1)
	if town%5<4:
		$Town/TabContainer/Outside/Destinations.add_item("Right - Town "+str(town+1), town+1)
	
	
	$Town/TabContainer/History/HBoxContainer/Years.clear()
	for i in Storage.History[town]:
		$Town/TabContainer/History/HBoxContainer/Years.add_item("Year : "+str(i),i)

	if Storage.History[town].size()>0:
		show_permission(town, Storage.History[town][0])
		$Town/TabContainer/History/HBoxContainer/State.clear()
		$Town/TabContainer/History/HBoxContainer/State.add_item("Before",0)
		$Town/TabContainer/History/HBoxContainer/State.add_item("After",1)

	visible = true
	
	
func show_permission(town, year):
	$Town/TabContainer/History/HBoxContainer/Side.clear()
	for i in Storage.History[town][year]["Permission"]:
		$Town/TabContainer/History/HBoxContainer/Side.add_item("Master : "+str(i), i)


func _on_Years_item_selected(index):
	$Town/TabContainer/History/HBoxContainer/Side.clear()
	var town = int($Town/TabContainer/Inside/TownInfo/HBoxContainer/TownName/Value.text)
	for i in Storage.History[town][index]["Permission"]:
		$Town/TabContainer/History/HBoxContainer/Side.add_item("Master : "+str(i), i)
	
	show_history()


func _on_State_item_selected(index):
	show_history()


func _on_Side_item_selected(index):
	show_history()
	
func show_history():
	var year= $Town/TabContainer/History/HBoxContainer/Years.get_selected_id()
	var state = ["Before","After"][$Town/TabContainer/History/HBoxContainer/State.get_selected_id()]
	var side = $Town/TabContainer/History/HBoxContainer/Side.get_selected_id()
	var town = int($Town/TabContainer/Inside/TownInfo/HBoxContainer/TownName/Value.text)
	
	for i in $Town/TabContainer/History/SoldiersInfo/ScrollContainer/VBoxContainer.get_child_count():
		$Town/TabContainer/History/SoldiersInfo/ScrollContainer/VBoxContainer.get_child(i).queue_free()

	$Town/TabContainer/History/TownMaster/Value.text = str(Storage.History[town][year]["Town_master"])
	
	for i in Storage.History[town][year][state].values():
		if i.Master == side:
			var soldier = load("res://Scene/Soldier.tscn").instance()
			soldier.get_node("HBoxContainer/Level/Value").text = str(i.Level)
			soldier.get_node("HBoxContainer/Hp/Value").text = str(i.Hp)
			soldier.get_node("HBoxContainer/Dame/Value").text = str(i.Dame)
			soldier.get_node("HBoxContainer/Address/Value").text = str(i.Address)
			soldier.get_node("HBoxContainer/Destination/Value").text = str(i.Destination)
			soldier.get_node("HBoxContainer/Country/Value").text = str(i.Country)
			soldier.get_node("HBoxContainer/FiveElements").texture = load("res://Assets/Soldiers/Five_elements/"+str(i.Five_elements) + ".png")
			soldier.get_node("Id").text = str(i.Id)
			$Town/TabContainer/History/SoldiersInfo/ScrollContainer/VBoxContainer.add_child(soldier)
		


func _on_ComeBack_pressed():
	var data = []
	for i in $Town/TabContainer/Inside/SoldiersInfo/ScrollContainer/VBoxContainer.get_child_count():
		if $Town/TabContainer/Inside/SoldiersInfo/ScrollContainer/VBoxContainer.get_child(i).get_node("HBoxContainer/CheckBox").pressed:
			var id = int($Town/TabContainer/Inside/SoldiersInfo/ScrollContainer/VBoxContainer.get_child(i).get_node("Id").text)
			data.push_back(id)
			Storage.Soldiers[id].Destination = Storage.Soldiers[id].Address

	Net.rpc("Come_back",data)
	Storage.Update_all_town_info()
	_on_Exit_pressed()
	

func _on_MoveTroop_pressed():
	var data = []
	var destination = $Town/TabContainer/Outside/Destinations.get_selected_id()
	for i in $Town/TabContainer/Outside/SoldiersInfo/ScrollContainer/VBoxContainer.get_child_count():
		if $Town/TabContainer/Outside/SoldiersInfo/ScrollContainer/VBoxContainer.get_child(i).get_node("HBoxContainer/CheckBox").pressed:
			var id = int($Town/TabContainer/Outside/SoldiersInfo/ScrollContainer/VBoxContainer.get_child(i).get_node("Id").text)
			data.push_back(id)
			Storage.Soldiers[id].Destination = destination

	Net.rpc("Come_back", data, destination)
	Storage.Update_all_town_info()
	_on_Exit_pressed()

