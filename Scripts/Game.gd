extends Panel





func _on_Ready_pressed():
	Storage.Time = 0
	get_node("Right/HBoxContainer/Flag"+str(Storage.Id_in_match)).self_modulate = Color(255, 255, 255, 255)
