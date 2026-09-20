extends Node

var time_passed := 0.0
var background_stage := 0
var instruction_time := 0.0

@onready var background: TextureRect = get_node("BackgroundLayer/Background")
@onready var countdown_label: Label = get_node("BackgroundLayer/Label")
@onready var game_over_label: Label = get_node("BackgroundLayer/GameOverLabel")
@onready var instruction_label: Label = get_node("BackgroundLayer/InstructionLabel")


func _process(delta):
	time_passed += delta
	instruction_time += delta

	# Hide instructions after 10 seconds
	if instruction_time >= 10:
		instruction_label.visible = false

	var seconds_left = 25 - int(time_passed)

	if background_stage == 0:
		countdown_label.text = str(seconds_left) + "s left before afternoon"

	elif background_stage == 1:
		countdown_label.text = str(seconds_left) + "s left before sunset"

	elif background_stage == 2:
		countdown_label.text = str(seconds_left) + "s left before dusk"

	elif background_stage == 3:
		countdown_label.text = str(seconds_left) + "s left before night"

	else:
		countdown_label.text = "Night has fallen!"

	if time_passed >= 25:
		change_background()


func change_background():
	background_stage += 1
	time_passed = 0

	if background_stage == 1:
		background.texture = preload("res://Backgrounds/haven game afternoon background2.jpg")

	elif background_stage == 2:
		background.texture = preload("res://Backgrounds/haven game sunset background.jpg")

	elif background_stage == 3:
		background.texture = preload("res://Backgrounds/haven game dusk background.jpg")

	elif background_stage == 4:
		background.texture = preload("res://Backgrounds/haven game night background.jpg")

		game_over_label.text = "NIGHT HAS FALLEN!\nYOU DIDN'T MAKE IT HOME."
		game_over_label.visible = true

		get_tree().paused = true


func _on_home_body_entered(body):
	if body.name == "CharacterBody2D":
		$BackgroundLayer/WinLabel.visible = true
		get_tree().paused = true
