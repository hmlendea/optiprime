#!/bin/sh

APP_PATH="$1"
APP_ARGS="${@:2}"

GPU_VENDORS=$(lspci | grep "VGA compatible controller" | awk '{print tolower($5)}')
GPU_VENDOR="intel"

if [ -d "/sys/class/power_supply/BAT0" ]; then
    BATT_STATE=$(cat "/sys/class/power_supply/BAT0/status")

    echo "Battery state is '$BATT_STATE'"

    if [ "$BATT_STATE" == "Charging" ] || [ "$BATT_STATE" == "Full" ]; then
        GPU_VENDOR="nvidia"
    fi
fi

echo "Launching the application through the $GPU_VENDOR GPU..."
echo "Application path: $APP_PATH"
echo "Application args: $APP_ARGS"

if [ "$GPU_VENDOR" == "intel" ]; then
    "$APP_PATH" $APP_ARGS

    exit
elif [ "$GPU_VENDOR" == "nvidia" ]; then
    COMPRESSION_METHOD="jpeg" # yuv has similar results

    export vblank_mode=0
    export VGL_READBACK=pbo

    echo "Framelimit (vblank_mode): $vblank_mode"
    echo "VGL_READBACK: $VGL_READBACK"
    echo "Compression method: $COMPRESSION_METHOD"

    optirun -c "$COMPRESSION_METHOD" -b primus "$APP_PATH" $APP_ARGS
fi
