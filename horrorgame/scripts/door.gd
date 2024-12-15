extends Node3D

@export var open = false
@export var key_needed = false
@export var key_group = ""
@export var door_text = ""
@export var open_inwards = false
@onready var PlayerInArea = false
@onready var timer = $AnimationPlayer/Timer
@onready var anim = $AnimationPlayer
var highlight_mat = preload("res://Scenes/highlight.tres")

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	if open == true && open_inwards:
		anim.play("closed_in")
	elif open:
		anim.play("open")
	
	timer.start()

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("interact") && PlayerInArea && open == true:
		if open_inwards:
			anim.play("open_in")
		else:
			anim.play_backwards("open")
		timer.start()
		open = false
	elif Input.is_action_just_pressed("interact") && PlayerInArea && open == false:
		if open_inwards:
			anim.play_backwards("open_in")
		else:
			anim.play("open")
		timer.start()
		open = true

func _on_timer_timeout() -> void:
	if open == true:
		if open_inwards:
			anim.play("RESET")
		else:
			anim.play("closed")
	elif open == false:
		if open_inwards:
			anim.play("closed_in")
		else:
			anim.play("RESET")



func _on_area_3d_has_been_hit() -> void:
	$test_door.material_overlay = highlight_mat
	$"../../player".text = door_text
	$"../../player".displayText()
	PlayerInArea = true
	

func _on_area_3d_not_hit() -> void:
	$test_door.material_overlay = null
	PlayerInArea = false
