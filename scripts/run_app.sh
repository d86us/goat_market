#!/bin/bash

# Navigate to the project root
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR/.."

# Start or focus scrcpy
if pgrep -x "scrcpy" > /dev/null; then
    echo "scrcpy is already open, bringing to front..."
    osascript -e 'tell application "System Events" to set frontmost of every process whose name is "scrcpy" to true'
else
    echo "Launching scrcpy in the background..."
    # Running scrcpy in the background so it doesn't block
    nohup scrcpy > /dev/null 2>&1 &
fi

echo "Running the Flutter app on Android..."
# We use flutter run and background it so it doesn't block the terminal.
# Input is redirected from /dev/null so it doesn't suspend waiting for terminal input.
nohup flutter run -d R7STB008NFJ < /dev/null > /tmp/flutter_run.log 2>&1 &

echo "App and mirroring launched! You can continue using this terminal."
