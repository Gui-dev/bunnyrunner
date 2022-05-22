extends KinematicBody2D

const GRAVITY = 1500
var speed_direction_x = 500
var velocity = Vector2(0, 0)
var jump = false

func _ready() -> void:
  set_process_input(true)

func _physics_process(delta: float) -> void:
  velocity.y += GRAVITY * delta
  velocity.x = speed_direction_x
  velocity = move_and_slide(velocity, Vector2(0, -1))
  
  if is_on_floor():
    $sprite.play('walk')
    if jump:
      velocity.y = -800
  else:
    $sprite.play('jump')
  
  jump = false

func _input(event):
  if event is InputEventScreenTouch:
    if event.pressed:
      jump = true
