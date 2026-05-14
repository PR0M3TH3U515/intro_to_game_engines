extends Node2D

const SPEED = 60

var direction = 1
@onready var ray_cast_r: RayCast2D = $RayCastR
@onready var ray_cast_l: RayCast2D = $RayCastL
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta):
	
	if ray_cast_r.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_l.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
		
	position.x += direction * SPEED * delta
