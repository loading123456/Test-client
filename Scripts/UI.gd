extends Panel


func Open_town_manage(town):
	visible = true
	$"TownManage/Inside/TownInfo/TownName/Value".text = str(town)
	$"TownManage/Inside/TownInfo/SolidersInTown/Value".text = Storage.Get_soliders_in_town(town)
	$"TownManage/Inside/TownInfo/SolidersOfTown/Value".text = Storage.Get_soliders_of_town(town)
	
	$"TownManage/Outside".call("Option_town",town)
	
	var t=0
	for i in Storage.Soliders:
		if i.Destination == town:
			var solider = load(Storage.Solider_path).instance()
			solider.get_node("HBoxContainer/Flag").texture = load(Storage.Flags[i.Master])
#			
			solider.get_node("HBoxContainer/Level/Value").text = str(i.Level)
			solider.get_node("HBoxContainer/Hp/Value").text = str(i.Hp)
			solider.get_node("HBoxContainer/Dame/Value").text = str(i.Dame)
			solider.get_node("HBoxContainer/Address/Value").text = str(i.Address)
			solider.get_node("HBoxContainer/Destination/Value").text = str(i.Destination)
			solider.get_node("HBoxContainer/Country/Value").text = str(i.Country)
			solider.get_node("Id").text = str(t)
			if i.Property == null:
				solider.get_node("HBoxContainer/Property").texture = load("res://Assets/Bots/Properties/King.png")
			else:
				solider.get_node("HBoxContainer/Property").texture = load(Storage.Solider_properties[i.Property])
			$"TownManage/Inside/SolidersInfo/VBoxContainer".add_child(solider)
		if i.Address == town:
			var solider = load(Storage.Solider_path).instance()
			solider.get_node("HBoxContainer/Flag").texture = load(Storage.Flags[i.Master])
			solider.get_node("HBoxContainer/Level/Value").text = str(i.Level)
			solider.get_node("HBoxContainer/Hp/Value").text = str(i.Hp)
			solider.get_node("HBoxContainer/Dame/Value").text = str(i.Dame)
			solider.get_node("HBoxContainer/Address/Value").text = str(i.Address)
			solider.get_node("HBoxContainer/Destination/Value").text = str(i.Destination)
			solider.get_node("HBoxContainer/Country/Value").text = str(i.Country)
			solider.get_node("Id").text = str(t)
			if i.Property == null:
				solider.get_node("HBoxContainer/Property").texture = load("res://Assets/Bots/Properties/King.png")
			else:
				solider.get_node("HBoxContainer/Property").texture = load(Storage.Solider_properties[i.Property])
			$"TownManage/Outside/SolidersInfo/VBoxContainer".add_child(solider)
		t+=1
	$TownManage/History.call("Option_history",town)
		
func _on_Exit_pressed():
	visible = false
	
	for i in $"TownManage/Inside/SolidersInfo/VBoxContainer".get_child_count():
		$"TownManage/Inside/SolidersInfo/VBoxContainer".get_child(i).queue_free()
	for i in $"TownManage/Outside/SolidersInfo/VBoxContainer".get_child_count():
		$"TownManage/Outside/SolidersInfo/VBoxContainer".get_child(i).queue_free()
	
	$"TownManage/Outside/SelectTown".clear()
	$TownManage/History.call("Clear_option")
	$TownManage/History.call("Clear_soliders")
