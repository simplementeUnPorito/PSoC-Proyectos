#/usr/bin/tcl

set file_name [file join $path  sdc1.7 sdcparsercore.tcl]
set sdcparser [file exists $file_name]

if {$sdcparser == 0} {
    set error -1
    return -1
}

source $file_name

sdc::register_callback sdc::sdcCommandCallback

sdc::set_version 1.7

proc sdc::sdcCommandCallback { command_name data_structure } {
	
	upvar $data_structure DataStruct
	global TclDataArray
	
	foreach el [lsort [array names DataStruct]] {
		set TclDataArray($el) $DataStruct($el)
	}
	
	set name [ CommandInterface  $command_name ] 
	return $name
}

sdc::parse_file $sdc_file
if {$sdc::errorstotal} {
    set error -2
}
    
