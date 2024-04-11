extends Panel

var time: float = 0.0
var minutes: int = 0
var seconds: int = 0
var msec: int = 0

# Declare variables to hold references to Label nodes
var minutes_label: Label
var seconds_label: Label
var msec_label: Label

func _ready():
	# Assign references to Label nodes
	minutes_label = $Label
	seconds_label = $Label2
	msec_label = $Label3

func _process(delta) -> void:
	time += delta
	msec = fmod(time, 1) * 100
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) / 60
	minutes_label.text = "%02d:" % minutes
	seconds_label.text = "%02d." % seconds
	msec_label.text = "%03d" % msec

func stop() -> void:
	set_process(false)

func get_time_formatted() -> String:
	return "%02d:%02d.%03d" % [minutes, seconds, msec]
