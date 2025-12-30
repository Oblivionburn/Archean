var $screen = screen(0,0)
var $screenPort = 0
var $pivotPort = 1
var $scannerPort = 2

var $buttonWidth = 10
var $buttonHeight = 11

var $visible = ".Si{1}.C{0}.Fe{0}.Cu{0}.Al{0}.Ni{0}.Ag{0}.Sn{0}.Cr{0}.Ti{0}.Au{0}.Pb{0}.W{0}.U{0}.F{0}"
storage var $visible_index : number
var $oreText = "Silicon"

var $cx = 0
var $cy = 0

var $degree = 0
var $rot = 0

function @resetVisible()
	$screen.draw_rect(0, 0, $screen.width, $screen.height, black, black)
	$oreText = ""
	$visible.Si = 0
	$visible.C = 0
	$visible.Fe = 0
	$visible.Cu = 0
	$visible.Al = 0
	$visible.Ni = 0
	$visible.Ag = 0
	$visible.Sn = 0
	$visible.Cr = 0
	$visible.Ti = 0
	$visible.Au = 0
	$visible.Pb = 0
	$visible.W = 0
	$visible.U = 0
	$visible.F = 0
	
function @updateVisible()
	@resetVisible()
	
	if $visible_index == 0
		$visible.Si = 1
		$oreText = "Silicon"
	elseif $visible_index == 1
		$visible.C = 1
		$oreText = "Carbon"
	elseif $visible_index == 2
		$visible.Fe = 1
		$oreText = "Iron"
	elseif $visible_index == 3
		$visible.Cu = 1
		$oreText = "Copper"
	elseif $visible_index == 4
		$visible.Al = 1
		$oreText = "Aluminum"
	elseif $visible_index == 5
		$visible.Ni = 1
		$oreText = "Nickel"
	elseif $visible_index == 6
		$visible.Ag = 1
		$oreText = "Silver"
	elseif $visible_index == 7
		$visible.Sn = 1
		$oreText = "Tin"
	elseif $visible_index == 8
		$visible.Cr = 1
		$oreText = "Chromium"
	elseif $visible_index == 9
		$visible.Ti = 1
		$oreText = "Titanium"
	elseif $visible_index == 10
		$visible.Au = 1
		$oreText = "Gold"
	elseif $visible_index == 11
		$visible.Pb = 1
		$oreText = "Lead"
	elseif $visible_index == 12
		$visible.W = 1
		$oreText = "Tungsten"
	elseif $visible_index == 13
		$visible.U = 1
		$oreText = "Uranium"
	elseif $visible_index == 14
		$visible.F = 1
		$oreText = "Fluorite"

init
	;set pivot rotation speed
	output_number($pivotPort, 1, 10)
	
	;reset pivot
	output_number($pivotPort, 0, 0)
	
	$cx = $screen.width / 2
	$cy = $screen.height / 2
	
	@updateVisible()

update
	;reset ore text
	$screen.draw_rect($buttonWidth, 0, $screen.width - $buttonWidth, $buttonHeight, black, black)
	
	;trailing fade to black
	$screen.draw(0,0,color(0,0,0,0.5),$screen.width,$screen.height)
	
	;convert degrees to rotation
	$rot = $degree / 360
	
	;rotate scanner
	output_number($pivotPort, 0, $rot)
	
	$degree++
	if $degree >= 360
		$degree = 0
	
	;convert degrees to radians
	var $radian = $degree * (pi / 180)
	
	;get scan data
	repeat 100($i)
		var $distance = $i
		var $channel = $i

		var $x = $cx + (sin($radian) * $i)
		var $y = $cy + (cos($radian) * $i)
		
		;scan in increments of 5m to 500m
		output_number($scannerPort, $channel, $distance * 5)
		var $scan = input_text($scannerPort, $channel)

		var $silicon = $scan.Si:number
		var $carbon = $scan.C:number
		var $iron = $scan.Fe:number
		var $copper = $scan.Cu:number
		var $aluminum = $scan.Al:number
		var $nickel = $scan.Ni:number
		var $silver = $scan.Ag:number
		var $tin = $scan.Sn:number
		var $chromium = $scan.Cr:number
		var $titanium = $scan.Ti:number
		var $gold = $scan.Au:number
		var $lead = $scan.Pb:number
		var $tungsten = $scan.W:number
		var $uranium = $scan.U:number
		var $fluorite = $scan.F:number
		
		var $alpha = 255
		var $r = 0
		var $g = 0
		var $b = 0
		
		;--silicon--
		if $silicon > 0 && $visible.Si > 0
			$alpha = 255 * $silicon
			$r = 128
			$g = 112
			$b = 89
			$screen.draw_point($x, $y, color($r,$g,$b,$alpha))
		
		;--carbon--
		if $carbon > 0 && $visible.C > 0
			$alpha = 255 * $carbon
			$r = 64
			$g = 64
			$b = 64
			$screen.draw_point($x, $y, color($r,$g,$b,$alpha))
		
		;--iron--
		if $iron > 0 && $visible.Fe > 0
			$alpha = 255 * $iron
			$r = 255
			$g = 0
			$b = 0
			$screen.draw_point($x, $y, color($r,$g,$b,$alpha))
		
		;--copper--
		if $copper > 0 && $visible.Cu > 0
			$alpha = 255 * $copper
			$r = 255
			$g = 155
			$b = 0
			$screen.draw_point($x, $y, color($r,$g,$b,$alpha))
		
		;--aluminum--
		if $aluminum > 0 && $visible.Al > 0
			$alpha = 255 * $aluminum
			$r = 200
			$g = 220
			$b = 220
			$screen.draw_point($x, $y, color($r,$g,$b,$alpha))
			
		;--nickel--
		if $nickel > 0 && $visible.Ni > 0
			$alpha = 255 * $nickel
			$r = 160
			$g = 160
			$b = 255
			$screen.draw_point($x, $y, color($r,$g,$b,$alpha))
			
		;--silver--
		if $silver > 0 && $visible.Ag > 0
			$alpha = 255 * $silver
			$r = 230
			$g = 240
			$b = 250
			$screen.draw_point($x, $y, color($r,$g,$b,$alpha))
			
		;--tin--
		if $tin > 0 && $visible.Sn > 0
			$alpha = 255 * $tin
			$r = 200
			$g = 250
			$b = 250
			$screen.draw_point($x, $y, color($r,$g,$b,$alpha))
			
		;--chromium--
		if $chromium > 0 && $visible.Cr > 0
			$alpha = 255 * $chromium
			$r = 250
			$g = 240
			$b = 230
			$screen.draw_point($x, $y, color($r,$g,$b,$alpha))
			
		;--titanium--
		if $titanium > 0 && $visible.Ti > 0
			$alpha = 255 * $titanium
			$r = 130
			$g = 140
			$b = 150
			$screen.draw_point($x, $y, color($r,$g,$b,$alpha))
			
		;--gold--
		if $gold > 0 && $visible.Au > 0
			$alpha = 255 * $gold
			$r = 255
			$g = 255
			$b = 0
			$screen.draw_point($x, $y, color($r,$g,$b,$alpha))
			
		;--lead--
		if $lead > 0 && $visible.Pb > 0
			$alpha = 255 * $lead
			$r = 128
			$g = 128
			$b = 128
			$screen.draw_point($x, $y, color($r,$g,$b,$alpha))
	
		;--tungsten--
		if $tungsten > 0 && $visible.W > 0
			$alpha = 255 * $tungsten
			$r = 150
			$g = 100
			$b = 170
			$screen.draw_point($x, $y, color($r,$g,$b,$alpha))
		
		;--uranium--
		if $uranium > 0 && $visible.U > 0
			$alpha = 255 * $uranium
			$r = 0
			$g = 255
			$b = 0
			$screen.draw_point($x, $y, color($r,$g,$b,$alpha))
			
		;--fluorite--
		if $fluorite > 0 && $visible.F > 0
			$alpha = 255 * $fluorite
			$r = 230
			$g = 160
			$b = 230
			$screen.draw_point($x, $y, color($r,$g,$b,$alpha))
		
	;draw center point
	$screen.draw_point($screen.width/2, $screen.height/2, black)

	;==== buttons ====			
	;draw left button
	$screen.draw_rect(0, 0, $buttonWidth, $buttonHeight, white, white)
	$screen.write(3, 2, black, "<")
	
	;draw right button
	$screen.draw_rect($screen.width - $buttonWidth, 0, $screen.width, $buttonHeight, white, white)
	$screen.write($screen.width - $buttonWidth + 3, 2, black, ">")
	
	;check for button clicks
	if $screen.clicked && $screen.click_y <= $buttonHeight
		if $screen.click_x <= $buttonWidth
			$visible_index--
			if $visible_index < 0
				$visible_index = 0
			@updateVisible()
		elseif $screen.click_x >= $screen.width - $buttonWidth
			$visible_index++
			if $visible_index > 14
				$visible_index = 14
			@updateVisible()
	
	;draw center text
	$screen.draw_rect($buttonWidth, 0, $screen.width - $buttonWidth, $buttonHeight, white)
	$screen.write(($screen.width/2) - (size($oreText) * 3), 2, white, $oreText)