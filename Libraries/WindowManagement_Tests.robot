*** Settings ***
Library    WindowManagement.py

*** Test Cases ***
Move cmd appium with success
    #${cmdAppium}=    C:\Windows\system32\cmd.exe  - "node"   "C:\Users\matth\AppData\Roaming\npm\\node_modules\appium\index.js" --allow-cors --allow-insecure chromedriver_autodownload
    ${rc}=    Setwindowtopos    appium    300    300    400    300
    IF    ${rc}
        Log    Success
    ELSE
        Fatal Error    Move console window has failed!
    END

Move cmd emulator with success
    ${rc}=    Setwindowtopos    -avd    100    100    400    300
    IF    ${rc}
        Log    Success
    ELSE
        Fatal Error    Move console window has failed!
    END

Move emulator with success
    ${rc}=    Setwindowtopos    Android Emulator - Pixel9Pro_API35:5554    800    100    #-1    -1
    IF    ${rc}
        Log    Success
    ELSE
        Fatal Error    Move console window has failed!
    END

Move cmd emulator with error
    ${rc}=    Setwindowtopos    IPhone15    100    100    400    300
    IF    ${rc}
        Log    Success
    ELSE
        Fatal Error    Move console window has failed!
    END

Check for appium window
    ${rc}=    window_exists    appium
    IF    ${rc}
        Log    Appium-Window exists!
    ELSE
        Log    Appium-Window doesn't exist!
    END

Check for appium window
    ${rc}=    window_exists    appium
    IF    ${rc}
        Log    Appium-Window exists!
    ELSE
        Log    Appium-Window doesn't exist!
    END

Check for cmd emulator window
    ${rc}=    window_exists    -avd
    IF    ${rc}
        Log    Emulator-Command-Window exists!
    ELSE
        Log    Emulator-Command-Window doesn't exist!
    END

Check for emulator window
    ${rc}=    window_exists    Android Emulator - Pixel9Pro_API35:5554
    IF    ${rc}
        Log    Emulator-Window exists!
    ELSE
        Log    Emulator-Window doesn't exist!
    END

Check for not existing holladiewaldfee window
    ${rc}=    window_exists    holladiewaldfee
    IF    ${rc}
        Log    holladiewaldfee-Window exists!
    ELSE
        Log    holladiewaldfee-Window doesn't exist!
    END
