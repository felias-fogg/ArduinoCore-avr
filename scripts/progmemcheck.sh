#!/bin/bash
progmem_end=`$1 -t d $2 | grep __ctors_start | cut -d ' ' -f 1`
if [ "x$progmem_end" != "x" ] && [ $progmem_end -gt 65535 ]; then
    warning="| Severe Warning: PROGMEM section too large by $(expr $progmem_end - 65535) bytes.            "
    echo "_______________________________________________________________"
    echo "${warning:0:62}|"
    echo "| Your program will most probably be unstable! Use the macro  |"
    echo "| PROGMEM_FAR from the \"progmem_far\" library (available from  |" 
    echo "| Arduino Library Manager), and use pgm_get_far_address and   |"
    echo "| pgm_read_xxxx_far from Arduino's \"pgmspace\" library to      |"
    echo "| access the PROGMEM_FAR data.                                |"
    echo "|_____________________________________________________________|"
fi
