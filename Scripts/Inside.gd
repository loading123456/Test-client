extends Tabs



func _on_CheckBox_toggled(button_pressed):
	for i in $SolidersInfo/VBoxContainer.get_child_count():
		$"SolidersInfo/VBoxContainer".get_child(i).get_node("HBoxContainer/CheckBox").pressed = button_pressed


func _on_ComeBack_pressed():
	var soliders = []
	for i in $SolidersInfo/VBoxContainer.get_child_count():
		if $SolidersInfo/VBoxContainer.get_child(i).get_node("HBoxContainer/CheckBox").pressed:
			Storage.Soliders[int($SolidersInfo/VBoxContainer.get_child(i).get_node("Id").text)].Destination = int($SolidersInfo/VBoxContainer.get_child(i).get_node("HBoxContainer/Address/Value").text)
			soliders.push_back(Storage.Soliders[int($SolidersInfo/VBoxContainer.get_child(i).get_node("Id").text)])
	Net.Come_back(soliders)
	for i in range(25):
		$"/root/Main/Game/Left/GridContainer".get_child(i).call("Update_info")
	get_parent().get_parent().call("_on_Exit_pressed")
