extends KinematicBody2D

const GRAVITY = 1500
var speed_direction_x = 500
var velocity = Vector2(0, 0)
var jump = false
var jump_release = false
var controled_jump = false
var was_on_floor = false

func _ready() -> void:
  set_process_input(true)

func _physics_process(delta: float) -> void:
  velocity.y += GRAVITY * delta
  velocity.x = speed_direction_x
  velocity = move_and_slide(velocity, Vector2(0, -1))
  
  if is_on_floor():
    if not was_on_floor:
      $animation_landed.play('boing')
      $dust/animation_dust.play('dust')
    $sprite.play('walk')
    if jump:
      _jump(1000, true)
      $jump.play()
  else:
    $sprite.play('jump')
    if jump_release and velocity.y < 0 and controled_jump:
      velocity.y *= 0.3
  
  was_on_floor = is_on_floor()
  jump = false
  jump_release = false

func _input(event):
  if event is InputEventScreenTouch:
    if event.pressed:
      jump = true
    else:
      jump_release = true

func _jump(force: int, controled: bool) -> void:
  velocity.y = -force
  controled_jump = controled