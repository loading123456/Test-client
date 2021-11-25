extends Tabs

var _town 

func Option_history(town):
	if Storage.History.has(str(town)):
		_town = town
		var y = 1
		for i in Storage.History[str(town)]:
			$Year.add_item(str(y)+" year ago",y-1)
			y+=1
		$State.add_item("After",0)
		$State.add_item("Before",1)
		$Side.add_item("Defence",0)
		$Side.add_item("Attack",1)
		
		Add_soliders(town,0,0,0)
			
			
func Clear_option():
	$Year.clear()
	$State.clear()
	$Side.clear()
	
func Clear_soliders():
	for i in $SolidersInfo/VBoxContainer.get_child_count():
		$SolidersInfo/VBoxContainer.get_child(i).queue_free()
		


func _on_Year_item_selected(index):
	Clear_soliders()
	Add_soliders(_town,$Year.get_selected_id(),$State.get_selected_id(),$Side.get_selected_id())


func _on_State_item_selected(index):
	Clear_soliders()
	Add_soliders(_town,$Year.get_selected_id(),$State.get_selected_id(),$Side.get_selected_id())


func _on_Side_item_selected(index):
	Clear_soliders()
	Add_soliders(_town,$Year.get_selected_id(),$State.get_selected_id(),$Side.get_selected_id())


func Add_soliders(town,year,state, side):
	for i in Storage.History[str(town)][year][state][side]:
		var solider = load(Storage.Solider_path).instance()
		solider.get_node("HBoxContainer/Flag").texture = load(Storage.Flags[i.Master])
		solider.get_node("HBoxContainer/Level/Value").text = str(i.Level)
		solider.get_node("HBoxContainer/Hp/Value").text = str(i.Hp)
		solider.get_node("HBoxContainer/Dame/Value").text = str(i.Dame)
		solider.get_node("HBoxContainer/Address/Value").text = str(i.Address)
		solider.get_node("HBoxContainer/Destination/Value").text = str(i.Destination)
		solider.get_node("HBoxContainer/Country/Value").text = str(i.Country)
		solider.get_node("HBoxContainer/CheckBox").visible = false
		solider.get_node("Id").text = ""
		if i.Property == null:
			solider.get_node("HBoxContainer/Property").texture = load("res://Assets/Bots/Properties/King.png")
		else:
			solider.get_node("HBoxContainer/Property").texture = load(Storage.Solider_properties[i.Property])
		$"SolidersInfo/VBoxContainer".add_child(solider)
