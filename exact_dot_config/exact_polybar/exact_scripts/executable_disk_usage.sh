#!/bin/bash
COLOR_FREE="#50fa7b"    # Green
COLOR_WARN="#ffb86c"    # Orange
COLOR_CRIT="#ff5555"    # Red

DISK="/dev/nvme0n1p4"

# Gets free space and total (in GB)
FREE=$(df -B1 --output=avail "$DISK" | tail -1)
TOTAL=$(df -B1 --output=size "$DISK" | tail -1)

# Converts bytes to GB with precision 2
FREE_GB=$(awk "BEGIN {printf \"%.2f\", $FREE/1073741824}")
TOTAL_GB=$(awk "BEGIN {printf \"%.2f\", $TOTAL/1073741824}")

USED=$(awk "BEGIN {printf \"%.2f\", $TOTAL_GB - $FREE_GB}")

# Computes the free space
PERCENT_FREE=$(awk "BEGIN {printf \"%d\", ($FREE_GB / $TOTAL_GB) * 100}")

# Determines the color and icon according to your remaining space
if [ $PERCENT_FREE -lt 10 ]; then
    COLOR="$COLOR_CRIT"
    ICON=""
elif [ $PERCENT_FREE -lt 30 ]; then
    COLOR="$COLOR_WARN"
    ICON=""
else
    COLOR="$COLOR_FREE"
    ICON=""
fi

echo "%{F$COLOR}$ICON%{F-} %{F$COLOR}${FREE_GB} GB libres (${PERCENT_FREE}%)%{F-}"
