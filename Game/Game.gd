extends Panel


func Update_all_town_info():
	for i in range(25):
		$"Left/GridContainer".get_child(i).call("Update_info")

func Pick_town():
	$"Right/Notify".text = "It's your turn to choose the town"
	Storage.Town_status = "Pick_town"
	Start_count_time()

func Picked_town(town):
	if Storage.Towns[town].Master == null:
		Net.Picked_town(town)
		Storage.Town_status = null
	
func Pick_capital():
	$"Right/Notify".text = "It's your turn to choose the capital"
	Storage.Town_status = "Pick_capital"
	Start_count_time()

func Picked_capital(town):
	if Storage.Towns[town].Master == Storage.Id_in_match:
		Net.Picked_capital(town)
		Storage.Town_status = null
		
func Start_peace_time(data):
	$"Right/Notify".text = "The peace time"
	Storage.Town_status = "Peace_time"
	Start_count_time()

func Count_time():
	$Right/Time.text = str(Storage.Time)
	Storage.Time -=1
	if Storage.Time<0:
		End_count_time()
		return
	yield(get_tree().create_timer(1),"timeout")
	Count_time()


func Start_count_time():
	Storage.Time = 60
	Count_time()
	
func End_count_time():
	Storage.Town_status = null
	$Right/Time.text = ""


func _on_Ready_pressed():
	$"Right/Notify".text = "Ready"
	Storage.Town_status = null
	Net.Ready()
