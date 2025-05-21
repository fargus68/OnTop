*** Settings ***
Library    BuiltIn
Library    OperatingSystem
Library    Process
Library    ScreenCapLibrary
Library    String
Library    ../../Libraries/ScrollIntoView_Direct.py
Library    ../../Libraries/WindowManagement.py
Library    ../../Resources/Utils/DriverSingletonAdapter.py    WITH NAME    SessionHelper
Resource    ../../Resources/Framework/fwVariables.resource

# Notes on Appium Logging:
# - Appium automatically captures Android logcat logs during test execution
# - The message "Stopping logcat capture" in the Appium logs indicates that Appium is stopping
#   the capture of Android system logs (logcat) when a session ends or is terminated
# - This is normal behavior and not an error condition
# - Logcat capture is a built-in feature of Appium for Android and helps with debugging

*** Variables ***
${BATCH_FILE_START_APPIUM_SERVER_NOBASEPATHARG_ALLOWDOWNLOADINSECURECHROMEDRIVER}    C:\\Users\\matth\\PycharmProjects\\OnTop\\Batch\\Start_Appium_Server_NoBasePathArg_AllowDwnload.bat
${BATCH_FILE_START_APPIUM_SERVER_BASEPATHARG_ALLOWDOWNLOADINSECURECHROMEDRIVER}    C:\\Users\\matth\\PycharmProjects\\OnTop\\Batch\\Start_Appium_Server_BasePathArg_AllowDwnload.bat
${BATCH_FILE_START_EMULATOR}    C:\\Users\\matth\\PycharmProjects\\OnTop\\Batch\\Start_Emulator.bat

*** Keywords ***
Set Up Pixel9Pro_API35
    Start Appium if necessary
    Start Emulator if necessary
    #Close All Appium Sessions
    #BuiltIn.Sleep    1s
    #open application tt planer on google pixel 9
    SessionHelper.wait until login screen is ready

Set Up Pixel9Pro_API35 NoWaitForLoginScreen
    Start Appium if necessary
    Start Emulator if necessary
    #Close All Appium Sessions
    #BuiltIn.Sleep    1s
    #open application tt planer on google pixel 9

Start Emulator if necessary
    ${EmulatorWinPixel9Pro_API35Exists}=    window_exists    Android Emulator - Pixel9Pro_API35:5554
    IF    ${EmulatorWinPixel9Pro_API35Exists}
        Log    Emulator-Window already exists!
    ELSE
        Emulator_Start    Pixel9Pro_API35
        Wait Until Keyword Succeeds    10x    5s    Emulator Is Ready
    END
    Setwindowtopos    -avd    1350    1120    1330    250
    Setwindowtopos    Android Emulator - Pixel9Pro_API35:5554    2730    130

Start Appium if necessary
    ${AppiumWinExists}=    window_exists    appium
    IF    ${AppiumWinExists}
        Log    Appium-Window already exists!
    ELSE
        Appium_Start_NoBasePathArg_AllowDownloadInsecureChromeDriver
        #Appium_Start_BasePathArg_AllowDownloadInsecureChromeDriver
        BuiltIn.Sleep    1s
    END
    Setwindowtopos    appium    10    1120    1330    250

Appium_Start_NoBasePathArg_AllowDownloadInsecureChromeDriver
    Run Process    ${BATCH_FILE_START_APPIUM_SERVER_NOBASEPATHARG_ALLOWDOWNLOADINSECURECHROMEDRIVER}    shell=True    stdout=stdout.txt    stderr=stderr.txt
    Log    Appium Server gestartet

Appium_Start_BasePathArg_AllowDownloadInsecureChromeDriver
    Run Process    ${BATCH_FILE_START_APPIUM_SERVER_BASEPATHARG_ALLOWDOWNLOADINSECURECHROMEDRIVER}    shell=True    stdout=stdout.txt    stderr=stderr.txt
    Log    Appium Server gestartet

Emulator_Start
    [Arguments]    ${EmulatorName}
    Run Process    ${BATCH_FILE_START_EMULATOR}    ${EmulatorName}    shell=True    stdout=stdout.txt    stderr=stderr.txt
    Log    Emulator gestartet

Emulator Is Ready
    ${output}=    Run Process    adb    shell    getprop    sys.boot_completed
    Should Be Equal As Strings    ${output.stdout.strip()}    1

Setup AUT Pixel9Pro_API35
    Set Up Pixel9Pro_API35
    InitializeVariableStorage
    SetVariableValue    AUT    Pixel9Pro_API35

Setup AUT Pixel9Pro_API35 NoWaitForLoginScreen
    Set Up Pixel9Pro_API35 NoWaitForLoginScreen
    InitializeVariableStorage
    SetVariableValue    AUT    Pixel9Pro_API35
