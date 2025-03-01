::oo::class create dia {
	variable janela

	constructor {} \
	{
# 		configura janela
		set janela [toplevel ".dia[clock clicks]"]
		wm geometry $janela 100x100+0+600
		wm overrideredirect $janela 1
		wm resizable $janela 0 0

#       configura a data
		set d [clock format [clock seconds] -format {%d} ]
 		global sla
 		#configura o canvas
		set canvas [canvas $janela.canvas -width 100 -height 20 -bg "red"]
		set numero [canvas $janela.numero -width 100 -height 70 ]
		$numero create text 50 30 -text "$d" -fill "black"  -font "Arial 34 bold"
# 		set sla [calendario]

# 		empacota tudo
		pack $canvas
		pack $numero


	}

 destructor {
	destroy $janela
}
}
