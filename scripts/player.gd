extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -250.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var slashanim: AnimatedSprite2D = $slashanim
@onready var animation_player: AnimationPlayer = $slashanim/AnimationPlayer

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var dash_timer: Timer = $DashTimer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var double_jump: bool = false

var can_dash

func _input(event: InputEvent):
	if event.is_action_pressed("atk1"):
		slash_atk()

func _physics_process(delta):
	if is_on_floor() and double_jump == true:
		double_jump = false
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump()
		elif double_jump == false:
			double_jump =true
			audio_stream_player_2d.play()
			jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else :
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func _on_coin_3_body_entered(body: Node2D) -> void:
	pass # Replace with function body.

func jump(multi: float = 1):
	velocity.y = JUMP_VELOCITY * multi

#func take_dmg(damage: int, hit_you:Vector2):
		var hit_direction: Vector2 = hit.pos.direction_to(global_position)
		boost_amount - hit_direction * 30
		current_health += damage
		animation_player.play("take_damage")
		if current_health <= 0:
			die()
			
#else:
		
		Engine.time_scale = 0.7 * damage
		var tween = get_tree().create_tween()
		tween.set_ignore_time_scale(true)
		tween.tween_property(Engine, "time_scale", 1.0, 0.3)
		
#func die():
	if !dting:
		dying = true
		Engine.time_scale = 0.3
		get_node("CollisionShape2D"),queue_free()
		await get_tree().create_timer(0.5).timeout
		Engine.time_scale = 1.0
		get_tree().reload_current_scene()

func slash_atk():
	animation_player.play("swing")
	slashanim.show()
	slashanim.play("swing")
	await slashanim.animation_finished
	slashanim.hide()
