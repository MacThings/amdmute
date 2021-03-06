
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

dev_path=$( ioreg -p IODeviceTree -n HDAU -r | grep "acpi-path" | sed -e 's/.*\:\///g' -e 's/_SB\///g' -e 's/HDAU.*"//g' -e 's/\/$//g' -e 's/@[0-9]*//g' -e 's/\//./g' -e 's/"//g' )

if [[ "$dev_path" = "" ]]; then
    _helpDefaultWrite "Qualified" "No"
else
    _helpDefaultWrite "Qualified" "Yes"
fi

function generate()
{
    if [[ "$dev_path" = "PCI0.PEG0.GFX0.EGP1" ]]; then
        file="$dev_path"
    elif [[ "$dev_path" = "PCI0.PEG0.PEGP" ]]; then
        file="$dev_path"
    fi
    
    #dev_path=$( echo "${dev_path%.*}" )
    
    cp "$file".aml ~/Desktop/SSDT-MUTE-GENERIC-RADEON.aml
    
    #cp "$file".aml /private/tmp/.
    #./iasl -d /private/tmp/"$file".aml
    #perl -pi -e "s/XXXX/$dev_path/g" /private/tmp/"$file".dsl
    #./iasl -oa /private/tmp/"$file".dsl
    #cp /private/tmp/"$file".aml ~/Desktop/SSDT-MUTE-GENERIC-RADEON.aml
    #rm /private/tmp/"$file"*
}

$1
