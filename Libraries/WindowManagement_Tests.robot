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