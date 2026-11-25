extends CanvasLayer

signal chosen(powerup: PowerUp)

@onready var buttons: Array[Button] = [$Row/Option1, $Row/Option2, $Row/Option3]
var _options: Array

@export var test_options: Array[PowerUp]

func _ready() -> void:
    process_mode = Node.PROCESS_MODE_WHEN_PAUSED # so it works while the game is paused
    hide()
    for i in buttons.size():
        buttons[i].pressed.connect(_on_pick.bind(i))

    # test
    chosen.connect(func(p: PowerUp) -> void: print("picked ", p.name))
    if test_options.size() > 0:
        show_choices(test_options)

func show_choices(options: Array) -> void:
    _options = options
    for i in buttons.size():
        buttons[i].visible = i < options.size()
        if buttons[i].visible:
            buttons[i].text = "%s\n%s" % [options[i].name, options[i].description]
    show()
    get_tree().paused = true
    buttons[0].grab_focus()

func _on_pick(i: int) -> void:
    get_tree().paused = false
    hide()
    chosen.emit(_options[i])


    