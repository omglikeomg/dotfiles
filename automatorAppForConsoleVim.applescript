on run {input, parameters}
    set vimCommand to "mvim -v "
    tell application "iTerm"
        activate

        if (count of windows) = 0 then
            set w to (create window with default profile)
        else
            set w to current window

            try 
                # raises error when all windows are minimized
                tell w
                    # look for tab with open vim session
                    repeat with t in tabs
                        tell t
                            if name of current session contains "vim" then

                                # open files in current vim session
                                set esc to character id 27
                                tell current session
                                    write text (esc & esc & ":silent! tablast")
                                    repeat with filename in input
                                        set filePath to quoted form of POSIX path of filename
                                        write text (":execute 'tabedit '.fnameescape(" & filePath & ")")
                                    end repeat
                                    select
                                end tell
                                select
                                return
                            end if
                        end tell
                    end repeat

                    # no existing session
                    create tab with default profile
                end tell

            on error msg
                set w to (create window with default profile)
            end try
        end if

        # open in new tab or window
        tell w
            tell current session
                set launchPaths to ""
                repeat with filename in input
                    set filePath to quoted form of POSIX path of filename
                    set launchPaths to launchPaths & " " & filePath
                end repeat
                write text (vimCommand & launchPaths)
            end tell
        end tell
    end tell
end run
