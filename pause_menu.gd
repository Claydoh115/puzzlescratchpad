extends CanvasLayer

func pause():
	get_tree().paused = true
	show()
	
func resume():
	get_tree().paused = false
	hide()	

func pauseByKeyboard():
	if Input.is_action_just_pressed("toggle_pause") and get_tree().paused == true:
		resume()
		
	elif Input.is_action_just_pressed("toggle_pause") and get_tree().paused == false:
		pause()
		
func _process(delta: float) -> void:
	pauseByKeyboard()

func _on_resume_button_pressed() -> void:
	resume()

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_options_button_pressed() -> void:
	pass
