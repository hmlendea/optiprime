#!/bin/sh

APP_PATH="${1}"
APP_ARGS="${@:2}"

GPU_VENDOR="Intel"

if [ -d "/sys/class/power_supply/BAT0" ]; then
    BATT_STATE=$(cat "/sys/class/power_supply/BAT0/status")

    echo "Battery state is '${BATT_STATE}'"

    if [ "${BATT_STATE}" = "Charging" ] || [ "${BATT_STATE}" = "Full" ] || [ "${BATT_STATE}" = "Unknown" ]; then
        GPU_VENDOR="Nvidia"
    fi
fi

echo "Launching the application through the ${GPU_VENDOR} GPU..."
echo "Application path: ${APP_PATH}"
echo "Application args: ${APP_ARGS}"

if [ "${GPU_VENDOR}" = "Intel" ]; then
    "${APP_PATH}" ${APP_ARGS}
elif [ "$GPU_VENDOR" = "Nvidia" ]; then
    COMPRESSION_METHOD="jpeg" # yuv has similar results

    export vblank_mode=0
    export VGL_READBACK=pbo

    echo "Framelimit (vblank_mode): ${vblank_mode}"
    echo "VGL_READBACK: ${VGL_READBACK}"
    echo "Compression method: ${COMPRESSION_METHOD}"

    optirun -c "${COMPRESSION_METHOD}" -b primus "${APP_PATH}" ${APP_ARGS}
fi
