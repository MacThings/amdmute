
#!/bin/bash
#

function _helpDefaultWrite()
{
    VAL=$1
    local VAL1=$2

    if [ ! -z "$VAL" ] || [ ! -z "$VAL1" ]; then
        defaults write "${ScriptHome}/Library/Preferences/amdmute.slsoft.de.plist" "$VAL" "$VAL1"
    fi
}

ScriptHome=$(echo $HOME)
MY_PATH="`dirname \"$0\"`"
cd "$MY_PATH"

function generate()
{
    dev_path=$( ioreg -p IODeviceTree -n HDAU -r | grep "acpi-path" | sed -e 's/.*\:\///g' -e 's/_SB\///g' -e 's/HDAU.*"//g' -e 's/\/$//g' -e 's/@[0-9][0-9][0-9][0-9][0-9]//g' -e 's/@[0-9][0-9][0-9][0-9]//g' -e 's/@[0-9][0-9][0-9]//g' -e 's/@[0-9][0-9]//g' -e 's/@[0-9]//g' -e 's/\//./g'  )
    
    #check=$( echo "$dev_path" | sed 's/.*\.//g')
    
    if [[ "$dev_path" = "PCI0.PEG0.GFX0.EGP1" ]]; then
        _helpDefaultWrite "Supported" "Yes"
    else
        _helpDefaultWrite "Supported" "No"
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
