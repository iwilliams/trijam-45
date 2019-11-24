extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var key_map = {
  44: ",",
  46: ".",
  32: " ",
  65: "A",
  66: "B",
  67: "C",
  68: "D",
  69: "E",
  70: "F",
  71: "G",
  72: "H",
  73: "I",
  74: "J",
  75: "K",
  76: "L",
  77: "M",
  78: "N",
  79: "O",
  80: "P",
  81: "Q",
  82: "R",
  83: "S",
  84: "T",
  85: "U",
  86: "V",
  87: "W",
  88: "X",
  89: "Y",
  90: "Z"
}

var rotating_towards = 0
var rotation_step = 100
var incorrect_count = 0

var passage = "One morning, when Gregor Samsa woke from troubled dreams, he found himself transformed in his bed into a horrible vermin. He lay on his armour like back, and if he lifted his head a little he could see his brown belly, slightly domed and divided by arches into stiff sections. The bedding was hardly able to cover it and seemed ready to slide off any moment. His many legs, pitifully thin compared with the size of the rest of him, waved about helplessly as he looked."
var passage_array = []

onready var legs = [
  $Circle/Leg1,
  $Circle/Leg2,
  $Circle/Leg3,
  $Circle/Leg4,
  $Circle/Leg5,
  $Circle/Leg6,
  $Circle/Leg7,
  $Circle/Leg8,
  $Circle/Leg9,
  $Circle/Leg10,
  $Circle/Leg11,
  $Circle/Leg12,
  $Circle/Leg13
]

# Called when the node enters the scene tree for the first time.
func _ready():
  get_parent().get_node("AnimationPlayer").play("Open")
  for c in passage:
    passage_array.append(c.to_upper())
  
  legs.invert()
  var i = 0
  for i in range(0, min(passage_array.size(), legs.size() - 1)):
    legs[i].get_node("Label").text = passage_array[i]
  
  legs[0].get_node("BlueC").visible = true
  pass # Replace with function body.

func _input(event):
  if event is InputEventKey:
    if event.pressed && !event.is_echo():
      if key_map.has(event.scancode):
        var letter = key_map[event.scancode]
        if passage_array.size() <= 0:
          return
        if letter == passage_array[0]:
          passage_array.pop_front()
          var leg = legs[0]
          leg.get_node("BlueC").visible = false
          leg.get_node("Label").text = ""
          legs.pop_front()
          legs.append(leg)
          if passage_array.size() > 0:
            legs[0].get_node("BlueC").visible = true  
          if passage_array.size() >= 12:
            legs[11].get_node("Label").text = passage_array[11]
          elif passage_array.size() > 0:
            legs[11].get_node("BlueC").visible = false
            legs[11].get_node("WhiteC").visible = false
            legs[11].get_node("Label").visible = false
          else:
            get_parent().get_node("AnimationPlayer").play("Win")
          rotating_towards += 27.69
          rotation_step = (rotating_towards - rotation_degrees)*10
        else:
          incorrect_count += 1
          get_parent().get_node("Label").text = "Mistakes: " + str(incorrect_count)

func _process(delta):
  if rotation_degrees < rotating_towards:
    rotation_degrees += rotation_step * delta
    get_parent().get_node("Cactus").texture_offset.x += rotation_step * delta
    