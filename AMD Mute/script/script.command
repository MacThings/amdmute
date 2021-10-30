
#!/bin/bash
#
ScriptHome=$(echo $HOME)
MY_PATH="`dirname \"$0\"`"
cd "$MY_PATH"

function generate()
{
    dev_path=$( ioreg | grep PEG0 -A 2 | tail -n 1 | sed -e 's/.*+-o//g' -e 's/<.*//g' -e 's/@0//g' | xargs )
    cp SSDT-MUTE-GENERIC-RADEON.aml /private/tmp/.
    perl -pi -e "s/XXXX/$dev_path/g" /private/tmp/SSDT-MUTE-GENERIC-RADEON.aml
    cp /private/tmp/SSDT-MUTE-GENERIC-RADEON.aml ~/Desktop/.
    rm /private/tmp/SSDT-MUTE-GENERIC-RADEON.aml
}

$1
