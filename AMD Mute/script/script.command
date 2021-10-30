
#!/bin/bash
#
MY_PATH="`dirname \"$0\"`"
cd "$MY_PATH"

function generate()
{
    dev_path=$( ioreg -p IODeviceTree -n HDAU -r | grep "acpi-path" | sed -e 's/.*\:\///g' -e 's/_SB\///g' -e 's/HDAU.*"//g' -e 's/\/$//g' -e 's/@[0-9][0-9][0-9][0-9][0-9]//g' -e 's/@[0-9][0-9][0-9][0-9]//g' -e 's/@[0-9][0-9][0-9]//g' -e 's/@[0-9][0-9]//g' -e 's/@[0-9]//g' -e 's/\//./g'  )
    
    check=$( echo "$dev_path" | sed 's/.*\.//g')
    
    if [[ "$check" = "EGP1" ]]; then
        type="$check"
    fi
    
    dev_path=$( echo "${dev_path%.*}" )
    
    cp SSDT-MUTE-GENERIC-RADEON.aml /private/tmp/.
    ./iasl -d /private/tmp/SSDT-MUTE-GENERIC-RADEON.aml
    perl -pi -e "s/XXXX/$dev_path/g" /private/tmp/SSDT-MUTE-GENERIC-RADEON.dsl
    ./iasl -oa /private/tmp/SSDT-MUTE-GENERIC-RADEON.dsl
    cp /private/tmp/SSDT-MUTE-GENERIC-RADEON.aml ~/Desktop/.
    rm /private/tmp/SSDT-MUTE-GENERIC-RADEON.aml
}

$1
