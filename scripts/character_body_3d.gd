extends CharacterBody3D

@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var player := $"."
@onready var walk_sound : AudioStreamPlayer = $Walk

const SPEED = 3.0
const ACC = 0.3
const DACC = 0.5 
const JUMP_VELOCITY = 4.5
var movement_velocity = Vector3.ZERO
var input_dir

var walking : bool

func _ready() -> void:
	anim_player.play("idle")

func _input(_event: InputEvent) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	input_dir = Input.get_vector("dummy", "dummy", "w", "s")
	var current_velocity = Vector2(movement_velocity.x, movement_velocity.z)
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		walking = true
		current_velocity = lerp(current_velocity, Vector2(direction.x, direction.z) * SPEED, ACC)
	else:
		walking = false
		current_velocity = current_velocity.move_toward(Vector2.ZERO, DACC)
	
	movement_velocity = Vector3(current_velocity.x, velocity.y, current_velocity.y)
	velocity = movement_velocity
	
	move_and_slide()
	
	if Input.is_action_pressed("d"):
		player.rotation_degrees.y = lerp(player.rotation_degrees.y, player.rotation_degrees.y - SPEED, DACC)
		
	if Input.is_action_pressed("a"):
		player.rotation_degrees.y = lerp(player.rotation_degrees.y, player.rotation_degrees.y + SPEED, DACC)
	
	if walking == true && not walk_sound.playing:
		walk_sound.play()
	
	if not walking && walk_sound:
		walk_sound.stop()
