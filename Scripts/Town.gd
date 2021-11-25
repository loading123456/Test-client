extends TextureButton

func _ready():
	$"TownName".text = str(get_index())


func _on_Town0_pressed():
	match Storage.Town_status:
		"Pick_town":
			if Storage.Towns[get_index()].Master == null:
				Net.rpc("After_pick_town",get_index())
				Storage.Town_status = null
				$"/root/Main/Game/Right/Notify".text = "Wait a minute"
			else:
				$"/root/Main/Game/Right/Notify".text = "Pick town again"
		"Pick_capital":
			if Storage.Towns[get_index()].Master == Storage.Id_in_match:
				Net.rpc("After_pick_capital",get_index())
				Storage.Town_status = null
				$"/root/Main/Game/Right/Notify".text = "Wait a minute"
			else:
				$"/root/Main/Game/Right/Notify".text = "Pick capital again"
		"Open_interface":
			$"/root/Main/Interface".call("Open_town",get_index())


func Update_info():
	$SoldiersInTown.text = str(Storage.Get_soldiers_in_town(get_index()).size())
	$Flag.texture = load("res://Assets/Flags/Flag"+str(Storage.Towns[get_index()].Master)+".png")
	
	var king = Storage.Get_king()
	if king != null && get_index() == king.Destination:
		$"King".visible = true
	else:
		$"King".visible = false
