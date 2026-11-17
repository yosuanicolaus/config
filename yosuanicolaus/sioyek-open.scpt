set isRunning to false
set isFront to false

tell application "System Events"
    if exists process "sioyek" then
        set isRunning to true
        set isFront to frontmost of process "sioyek"
    end if
end tell

if (not isRunning) or (not isFront) then
    tell application "sioyek" to activate
else
    tell application "System Events" to tell process "sioyek"
        if (count of windows) > 1 then
            perform action "AXRaise" of window -1
        end if
    end tell
end if
