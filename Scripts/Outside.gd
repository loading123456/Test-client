extends Tabs

func _on_CheckBox_toggled(button_pressed):
	for i in $SolidersInfo/VBoxContainer.get_child_count():
		$"SolidersInfo/VBoxContainer".get_child(i).get_node("HBoxContainer/CheckBox").pressed = button_pressed

func Option_town(town):
	$SelectTown.add_item("Town "+str(town),town)
	if town/5 > 0:
		$SelectTown.add_item("Town "+str(town-5),town-5)
	if town/5 < 4:
		$SelectTown.add_item("Town "+str(town+5),town+5)
	if town%5 < 4:
		$SelectTown.add_item("Town "+str(town+1),town+1)
	if town%5 > 0:
		$SelectTown.add_item("Town "+str(town-1),town-1)

	


func _on_MoveTroop_pressed():
	var soliders = []
	for i in $SolidersInfo/VBoxContainer.get_child_count():
		if $SolidersInfo/VBoxContainer.get_child(i).get_node("HBoxContainer/CheckBox").pressed:
			Storage.Soliders[int($SolidersInfo/VBoxContainer.get_child(i).get_node("Id").text)].Destination = int($SelectTown.get_selected_id())
			soliders.push_back(Storage.Soliders[int($SolidersInfo/VBoxContainer.get_child(i).get_node("Id").text)])
	for i in range(25):
		$"/root/Main/Game/Left/GridContainer".get_child(i).call("Update_info")
	get_parent().get_parent().call("_on_Exit_pressed")
	Net.Move_troop(soliders)
