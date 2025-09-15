extends CharacterBody3D


# ███████                          ██         
#░██░░░░██                        ░██  ██   ██
#░██   ░██   █████   ██████       ░██ ░░██ ██ 
#░███████   ██░░░██ ░░░░░░██   ██████  ░░███  
#░██░░░██  ░███████  ███████  ██░░░██   ░██   
#░██  ░░██ ░██░░░░  ██░░░░██ ░██  ░██   ██    
#░██   ░░██░░██████░░████████░░██████  ██     
#░░     ░░  ░░░░░░  ░░░░░░░░  ░░░░░░  ░░      
@onready var anim_player : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	anim_player.play("idle")


# ██                            ██  
#░██          ██████           ░██  
#░██ ███████ ░██░░░██ ██   ██ ██████
#░██░░██░░░██░██  ░██░██  ░██░░░██░ 
#░██ ░██  ░██░██████ ░██  ░██  ░██  
#░██ ░██  ░██░██░░░  ░██  ░██  ░██  
#░██ ███  ░██░██     ░░██████  ░░██ 
#░░ ░░░   ░░ ░░       ░░░░░░    ░░  
func _input(_event: InputEvent) -> void:
	pass
	
	
# ███████  ██                       ██                   ███████                                                 
#░██░░░░██░██       ██   ██        ░░                   ░██░░░░██                                                
#░██   ░██░██      ░░██ ██   ██████ ██  █████   ██████  ░██   ░██ ██████  ██████   █████   █████   ██████  ██████
#░███████ ░██████   ░░███   ██░░░░ ░██ ██░░░██ ██░░░░   ░███████ ░░██░░█ ██░░░░██ ██░░░██ ██░░░██ ██░░░░  ██░░░░ 
#░██░░░░  ░██░░░██   ░██   ░░█████ ░██░██  ░░ ░░█████   ░██░░░░   ░██ ░ ░██   ░██░██  ░░ ░███████░░█████ ░░█████ 
#░██      ░██  ░██   ██     ░░░░░██░██░██   ██ ░░░░░██  ░██       ░██   ░██   ░██░██   ██░██░░░░  ░░░░░██ ░░░░░██
#░██      ░██  ░██  ██      ██████ ░██░░█████  ██████   ░██      ░███   ░░██████ ░░█████ ░░██████ ██████  ██████ 
#░░       ░░   ░░  ░░      ░░░░░░  ░░  ░░░░░  ░░░░░░    ░░       ░░░     ░░░░░░   ░░░░░   ░░░░░░ ░░░░░░  ░░░░░░  
func _physics_process(delta: float) -> void:
	mover(delta)
	shadow_sizer()
	sounder()
	
	
#  ████████ ██                     ██                        ████████ ██                      
# ██░░░░░░ ░██                    ░██                       ██░░░░░░ ░░                       
#░██       ░██       ██████       ░██  ██████  ███     ██  ░██        ██ ██████  █████  ██████
#░█████████░██████  ░░░░░░██   ██████ ██░░░░██░░██  █ ░██  ░█████████░██░░░░██  ██░░░██░░██░░█
#░░░░░░░░██░██░░░██  ███████  ██░░░██░██   ░██ ░██ ███░██  ░░░░░░░░██░██   ██  ░███████ ░██ ░ 
#       ░██░██  ░██ ██░░░░██ ░██  ░██░██   ░██ ░████░████         ░██░██  ██   ░██░░░░  ░██   
# ████████ ░██  ░██░░████████░░██████░░██████  ███░ ░░░██   ████████ ░██ ██████░░██████░███   
#░░░░░░░░  ░░   ░░  ░░░░░░░░  ░░░░░░  ░░░░░░  ░░░    ░░░   ░░░░░░░░  ░░ ░░░░░░  ░░░░░░ ░░░    
@onready var shadow_spring_arm := $Model/SpringArm3D
@onready var shadow := $Model/SpringArm3D/Shadow

func shadow_sizer():
	shadow.scale = Vector3(3.0 - shadow_spring_arm.get_hit_length(), 1.0, 3.0 - shadow_spring_arm.get_hit_length())


#  ████████                                ██               
# ██░░░░░░                                ░██               
#░██         ██████  ██   ██ ███████      ░██  █████  ██████
#░█████████ ██░░░░██░██  ░██░░██░░░██  ██████ ██░░░██░░██░░█
#░░░░░░░░██░██   ░██░██  ░██ ░██  ░██ ██░░░██░███████ ░██ ░ 
#       ░██░██   ░██░██  ░██ ░██  ░██░██  ░██░██░░░░  ░██   
# ████████ ░░██████ ░░██████ ███  ░██░░██████░░██████░███   
#░░░░░░░░   ░░░░░░   ░░░░░░ ░░░   ░░  ░░░░░░  ░░░░░░ ░░░    
@onready var walk_sound : AudioStreamPlayer = $Walk
@onready var run_sound := $Run

func sounder():
	if walking and not running and not walk_sound.playing:
		walk_sound.play()
	if walking and running and walk_sound.playing:
		walk_sound.stop()
	if not walking and walk_sound.playing:
		walk_sound.stop()
	if running and not run_sound.playing:
		run_sound.play()
	if not running and run_sound.playing:
		run_sound.stop()



# ████     ████                                 
#░██░██   ██░██                                 
#░██░░██ ██ ░██  ██████  ██    ██  █████  ██████
#░██ ░░███  ░██ ██░░░░██░██   ░██ ██░░░██░░██░░█
#░██  ░░█   ░██░██   ░██░░██ ░██ ░███████ ░██ ░ 
#░██   ░    ░██░██   ░██ ░░████  ░██░░░░  ░██   
#░██        ░██░░██████   ░░██   ░░██████░███   
#░░         ░░  ░░░░░░     ░░     ░░░░░░ ░░░    
@onready var player := $"."

const SPEED = 3.0
const ACC = 0.3
const DACC = 0.5 
const JUMP_VELOCITY = 6
var movement_velocity = Vector3.ZERO
var input_dir
var walking : bool
var running : bool

func mover(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("k") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	input_dir = Input.get_vector("dummy", "dummy", "w", "s")
	var current_velocity = Vector2(movement_velocity.x, movement_velocity.z)
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		walking = true
		if not running:
			current_velocity = lerp(current_velocity, Vector2(direction.x, direction.z) * SPEED, ACC)
		if running:
			current_velocity = lerp(current_velocity, Vector2(direction.x, direction.z) * SPEED * 2, ACC)
	else:
		walking = false
		current_velocity = current_velocity.move_toward(Vector2.ZERO, DACC)
	
	movement_velocity = Vector3(current_velocity.x, velocity.y, current_velocity.y)
	velocity = movement_velocity
	
	if Input.is_action_just_pressed("l"):
		if walking:
			running = true
	
	if Input.is_action_just_released("l"):
		running = false
	
	if Input.is_action_pressed("d"):
		player.rotation_degrees.y = lerp(player.rotation_degrees.y, player.rotation_degrees.y - SPEED, DACC)
		
	if Input.is_action_pressed("a"):
		player.rotation_degrees.y = lerp(player.rotation_degrees.y, player.rotation_degrees.y + SPEED, DACC)
		
	move_and_slide()
	
