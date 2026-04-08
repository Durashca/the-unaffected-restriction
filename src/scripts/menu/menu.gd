extends Control

func _ready():
	# Находим кнопки по их пути (если они прямые дети)
	var play_button = $BoxContainer/VBoxContainer/Play
	var quit_button = $BoxContainer/VBoxContainer/Exit

	# Подключаем сигналы к функциям
	play_button.pressed.connect(_on_play_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

func _on_play_pressed():
	# Замените "res://game_scene.tscn" на путь к вашей игровой сцене
	get_tree().change_scene_to_file("res://src/scenes/level/level.tscn")

func _on_quit_pressed():
	get_tree().quit()
