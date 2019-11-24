tool
extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "tet"

export(int) var radius = 20

# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.

func _draw():
  draw_circle(Vector2(0, 0), radius, Color(1, 1, 1, 1));
  pass