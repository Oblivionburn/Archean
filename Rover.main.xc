var $seatPort = 0
var $wheelPort_FrontLeft = 1
var $wheelPort_FrontRight = 2
var $wheelPort_BackLeft = 3
var $wheelPort_BackRight = 4
var $throttlePort = 5
var $speedSensorPort = 6
var $lightPort_Left = 7
var $lightPort_Right = 8
var $spedometer = screen(9, 0)
var $batteryPort = 10
var $batteryScreen = screen(11, 0)

var $acceleration = 0
var $steering = 0
var $darkCyan = color(0, 150, 150, 255)

update
	var $speed = input_number($speedSensorPort, 0)
	var $speedText = text("{000.000} m/s", $speed:text)
	$spedometer.blank(black)
	$spedometer.write(10, 22, white, $speedText)
	
	var $charge = input_number($batteryPort, 2)
	var $chargePercent = $batteryScreen.height - ((($charge * 100) * $batteryScreen.height) / 100)
	
	var $bx = 0
	var $chargeText = ""
	if $charge < 1
		$bx = 7
		$chargeText = text("{00}%", $charge * 100)
	else
		$bx = 5
		$chargeText = text("{000}%", $charge * 100)
	
	$batteryScreen.blank(black)
	
	$batteryScreen.draw_rect(0, $batteryScreen.height, $batteryScreen.width, $chargePercent, $darkCyan, $darkCyan)
	$batteryScreen.write($bx, 25, white, $chargeText)
	
	var $forward_backward = input_number($seatPort, 1)
	var $left_right = input_number($seatPort, 2)
	var $down_up = input_number($seatPort, 3)
	
	if $forward_backward > 0
		$acceleration += 0.01
		if $acceleration > 1
			$acceleration = 1
	elseif $forward_backward < 0
		$acceleration -= 0.01
		if $acceleration < -1
			$acceleration = -1
	else
		$acceleration = 0
		
	if $left_right > 0
		$steering += 0.1
		if $steering > 1
			$steering = 1
	elseif $left_right < 0
		$steering -= 0.1
		if $steering < -1
			$steering = -1
	else
		$steering = 0
	
	;lights
	output_number($lightPort_Left, 0, 1)
	output_number($lightPort_Right, 0, 1)
	
	;acceleration
	;output_number($wheelPort_FrontLeft, 0, $forward_backward)
	;output_number($wheelPort_FrontRight, 0, -$forward_backward)
	output_number($wheelPort_BackLeft, 0, $acceleration)
	output_number($wheelPort_BackRight, 0, $acceleration)

	;breaks
	output_number($wheelPort_FrontLeft, 3, $down_up)
	output_number($wheelPort_FrontRight, 3, $down_up)
	output_number($wheelPort_BackLeft, 3, $down_up)
	output_number($wheelPort_BackRight, 3, $down_up)
	
	;steering
	output_number($wheelPort_FrontLeft, 1, $steering)
	output_number($wheelPort_FrontRight, 1, $steering)
	;output_number($wheelPort_BackLeft, 1, -$left_right)
	;output_number($wheelPort_BackRight, 1, -$left_right)