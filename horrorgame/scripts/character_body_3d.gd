extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var neck := $Neck
@onready var camera := $Neck/Camera3D
@onready var cast = $Neck/Camera3D/RayCast3D
@onready var screenText = $objText
var sprint_multiplyer = 1
var key = 0
var batteryAmount = 1
var text = ""
var inv_state = false


signal cast_hit
signal hit_stop

var cutscene = false


func _unhandled_input(event: InputEvent) -> void:
	if !cutscene:
		if event is InputEventMouseButton:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		elif event.is_action_pressed("ui_cancel"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			
			if event is InputEventMouseMotion:
				neck.rotate_y(-event.relative.x * 0.01)
				camera.rotate_x(-event.relative.y * 0.01)
				camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))
		
			
			#https://www.youtube.com/watch?v=v4IEPi1c0eE 

func _physics_process(delta: float) -> void:
	
	$batAmmount.text = str(batteryAmount)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	
	#light
	if Input.is_action_just_pressed("light"):
		if !$Neck/Camera3D/SpotLight3D/LightTimer.is_stopped():
			if $Neck/Camera3D/SpotLight3D.visible == true:
				$Neck/Camera3D/SpotLight3D.visible = false
				$Neck/Camera3D/SpotLight3D/LightTimer.paused = true
			else:
				$Neck/Camera3D/SpotLight3D/LightTimer.paused = false
				$Neck/Camera3D/SpotLight3D.visible = true
		else:
			if $Neck/Camera3D/SpotLight3D.visible == true:
				$Neck/Camera3D/SpotLight3D.visible = false
				$Neck/Camera3D/SpotLight3D/LightTimer.paused = true
			else:
				$Neck/Camera3D/SpotLight3D/LightTimer.start()
				$Neck/Camera3D/SpotLight3D.visible = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * (SPEED * sprint_multiplyer)
		velocity.z = direction.z * (SPEED * sprint_multiplyer)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if Input.is_action_pressed("sprint"):
		sprint_multiplyer = 1.4
	else:
		sprint_multiplyer = 1
		
	
	if cast.is_colliding():
		var target = cast.get_collider()
		target.hit()
	else:
		hideText()
		
	if text == "Batteries" && Input.is_action_just_pressed("interact"):
		$Label2.show()
		$Label2/batTimer.start()
		batteryAmount = batteryAmount + 1
		text = ""


	move_and_slide()

func _on_area_3d_body_entered(body: Node3D) -> void:
	#if text == "batteries" && Input.is_action_just_pressed("interact"):
		#$Label2.show()
		#$Label2/batTimer.start()
		#body.hide()
		#batteryAmount = batteryAmount + 1
		
	if body.is_in_group("dialogue_area"):
		cutscene = true

func _on_bat_timer_timeout() -> void:
	$Label2.hide()

func _on_key_timer_timeout() -> void:
	$"../Area3D/Label".hide()


func _on_light_timer_2_timeout() -> void:
	if batteryAmount <= 0:
		$Neck/Camera3D/SpotLight3D.light_energy = randf_range(0.5, 10)
		$Neck/Camera3D/SpotLight3D/LightTimer2.start()
	

func _on_light_timer_timeout() -> void:
	$Neck/Camera3D/SpotLight3D.light_energy = 10.0
	if batteryAmount > 0 :
		batteryAmount = batteryAmount - 1
	if batteryAmount == 0:
		$Neck/Camera3D/SpotLight3D/LightTimer2.start()

func displayText() -> void:
	print_debug(text)
	screenText.text = text
	screenText.show()


func hideText() -> void:
	print_debug("2")
	screenText.hide()
	#screenText.text = ""

#TODO:
#	fog
#	Shaders
#	Probably add decals for design
#	research lighting more
#	enemies or animations?
#	UI, multiple choice click to select things
#	PSX shaders?
#	Key items for puzzle solving 
#	Lightswitches
#	Inventory Sytem 
