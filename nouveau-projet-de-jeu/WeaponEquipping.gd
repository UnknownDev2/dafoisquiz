extends Node3D

@export var cooldown = .7 
@export var Damage = 5
var Debounce = false

var time = 0

func _process(delta):
	if Input.is_action_just_pressed("Click") and Debounce == false:
		Debounce = true
		
		time += 1
		print(time)
		
		print("Swing")
		print(Damage)
		
		get_tree().create_timer(cooldown)
		
		Debounce = false
