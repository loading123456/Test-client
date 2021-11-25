extends TextureButton


func _ready():
	$TownName.text = str(get_index())
	

func _on_Town0_pressed():
	match Storage.Town_status:
		"Pick_town":
			$"/root/Main/Game".call("Picked_town",get_index())
			Storage.Town_status = null
		"Pick_capital":
			$"/root/Main/Game".call("Picked_capital",get_index())
			Storage.Town_status = null
		"Peace_time":
			$"/root/Main/Game/UI".call("Open_town_manage",get_index())


func Update_info():
	$"SolidersInTown".text = Storage.Get_soliders_in_town(get_index())
	if Storage.Towns[get_index()].Master == null:
		$"Flag".texture = null
	else:
		$"Flag".texture = load(Storage.Town_properties[Storage.Towns[get_index()].Property])

	if get_index() == Storage.Get_king().Destination:
		$"King".visible = true
	else:
		$"King".visible = false
