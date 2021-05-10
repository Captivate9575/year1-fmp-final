extends KinematicBody2D


const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 70
const JUMP_HEIGHT = -300
var motion = Vector2()
var is_facing_right
var set_monitoring = true
var anim_played = false
var can_interact = false 

func _physics_process(_delta):
	motion.y += GRAVITY
	
	if Input.is_action_pressed("right"):
		motion.x = SPEED
		$Sprite.flip_h = false
#		$Sprite2.flip_h = false
		$Sprite2.scale.x = 2
#		scale.x = 0.5
	elif Input.is_action_pressed("left"):
		motion.x = -SPEED
		$Sprite.flip_h = true
#		$Sprite2.flip_h = true
		$Sprite2.scale.x = -2
#		scale.x = -0.5
	else:
		motion.x = 0

	if is_on_floor():
		if Input.is_action_just_pressed("up"):
			motion.y = JUMP_HEIGHT
			
	motion = move_and_slide(motion, UP)
	pass
	
	if Input.is_action_just_pressed("interact") and can_interact == true:
		print("MAN INTERACTED WITH")

func _on_StaticBody2D_body_entered(_body):
	get_tree().change_scene("res://first-scene.tscn")
	print("COLLISION")

func _on_Owl_body_entered(_body):
	print("OWL")
	if anim_played == false:
		print("PLAYING")
		get_node("../AnimatedSprite").playing = true
		get_node("../AnimatedSprite/AnimationPlayer").play("Move")
	elif anim_played == true:
		print("nah cant do that")
#	get_node("../AnimatedSprite").playing = true
#	get_node("../AnimatedSprite/AnimationPlayer").play("Move")
	
func _on_AnimatedSprite_animation_finished():
	anim_played = true
	print("DONE")
	get_node("../AnimatedSprite").queue_free()

func _on_ManInteract_body_entered(_body):
	print("HELLOS")
	can_interact =  true
func _on_ManInteract_body_exited(_body):
	can_interact = false
