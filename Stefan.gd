extends KinematicBody

#najpierw nie wprowadzac, dopiero potem, gdy ruch myszki zbyt szybki
const MYSZ_CZULOSC = 0.2

onready var pomoc = $pomocniczy
var kamera
#potem
var kierunek_ruchu
#potem
var predkosc = Vector3()
const GRAWITACJA = -50
const MAX_V = 20
const SKOK_V = 20
const BIEGANIE_V = 20
var czy_biegnie = false
var czy_skradanie = false

func _ready():
	#kamera = $pomocniczy/Camera

	#najpierw bez trybu MOUSE_MODE_CAPTURED
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	#gdy jeszcze nie mamy MOUSE_MODE_CAPTURE
	if event is InputEventMouseMotion:
	#if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		#obrot lewo-prawo: os Y
		self.rotate_y(deg2rad(-event.relative.x * MYSZ_CZULOSC))

#		#obrot gora-dol: os X
		#na poczatek bez pomocy -- ale kaszana!
		#self.rotate_x(deg2rad(event.relative.y * MYSZ_CZULOSC))
		pomoc.rotate_x(deg2rad(event.relative.y * MYSZ_CZULOSC))
#		#gdy juz wlaczymy MOUSE_MODE_CPATURE, to problem: obracamy glowa jak chcemy
		var _kam = pomoc.rotation_degrees
		_kam.x = clamp(_kam.x, -70, 70)
		pomoc.rotation_degrees = _kam
		
		
	# Capturing/Freeing the cursor
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)			
			
func _physics_process(delta):
	odczytuj(delta)
	ruszaj_sie(delta)
	
func odczytuj(delta):
	kierunek_ruchu = Vector3()
	var cam_xform = $pomocniczy/Camera.get_global_transform()

	var ruch2d = Vector2()

	if Input.is_action_pressed("przod"):
		ruch2d.y += 1
	if Input.is_action_pressed("tyl"):
		ruch2d.y -= 1
	if Input.is_action_pressed("lewo"):
		ruch2d.x -= 1
	if Input.is_action_pressed("prawo"):
		ruch2d.x += 1
	ruch2d = ruch2d.normalized()

	# Basis vectors are already normalized.
	kierunek_ruchu += -cam_xform.basis.z * ruch2d.y
	kierunek_ruchu += cam_xform.basis.x * ruch2d.x
	# na koniec, jak juz wszystko zrobione
	# podskok
	if is_on_floor():
			if Input.is_action_just_pressed("podskocz"):
					predkosc.y = SKOK_V
	if Input.is_action_pressed("bieganie"):
			czy_biegnie = true
	else:
			czy_biegnie = false
	if Input.is_action_pressed("skradanie"):
			czy_skradanie = true
	else:
			czy_skradanie = false



func ruszaj_sie(delta):
#	kierunek_ruchu.y = 0
#	kierunek_ruchu = kierunek_ruchu.normalized()
#
	predkosc.y += delta * GRAWITACJA
#
	var _pom_v = predkosc
	_pom_v.y = 0
#
	#var cel = kierunek_ruchu * MAX_V
	#var cel = kierunek_ruchu * (MAX_V + int(czy_biegnie)*BIEGANIE_V)
	var cel = kierunek_ruchu * (MAX_V + int(czy_biegnie)*BIEGANIE_V)/(4*int(czy_skradanie)+1)

#	var accel
#	if dir.dot(hvel) > 0:
#		accel = ACCEL
#	else:
#		accel = DEACCEL
#
#	_pom_v = _pom_v.linear_interpolate(cel, accel * delta)
#	vel.x = hvel.x
#	vel.z = hvel.z
	_pom_v = cel
	predkosc.x = _pom_v.x
	predkosc.z = _pom_v.z
	
	predkosc = move_and_slide(predkosc, Vector3(0, 1, 0), false, 4, deg2rad(10))
	#predkosc = move_and_slide(predkosc, Vector3(0, 1, 0), 0.05, 4, deg2rad(MAX_SLOPE_ANGLE))