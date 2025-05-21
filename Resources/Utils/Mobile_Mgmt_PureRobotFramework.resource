*** Settings ***
Library    BuiltIn
Library    AppiumLibrary
Library    OperatingSystem
Library    Process
Library    String
Library    ../Utils/DriverSingletonAdapter.py
Library    ../../Libraries/ScrollIntoView.py
Library    ../../Libraries/WindowManagement.py
Resource    ../../Resources/Framework/fwVariables.resource

*** Variables ***
${BATCH_FILE_START_APPIUM_SERVER_NOBASEPATHARG_ALLOWDOWNLOADINSECURECHROMEDRIVER}    C:\\Users\\matth\\PycharmProjects\\OnTop\\Batch\\Start_Appium_Server_NoBasePathArg_AllowDwnload.bat
${BATCH_FILE_START_APPIUM_SERVER_BASEPATHARG_ALLOWDOWNLOADINSECURECHROMEDRIVER}    C:\\Users\\matth\\PycharmProjects\\OnTop\\Batch\\Start_Appium_Server_BasePathArg_AllowDwnload.bat
${BATCH_FILE_START_EMULATOR}    C:\\Users\\matth\\PycharmProjects\\OnTop\\Batch\\Start_Emulator.bat

*** Keywords ***
Set Up Pixel9Pro_API35
    Start Appium if necessary
    Start Emulator if necessary

    #ToDo: can be further optimized
    #Get Appium SessionId
    #Page Should Contain Element    id=${ELEMENT_ID}

    initializeCurrentSession
    Close All Appium Sessions
    BuiltIn.Sleep    1s

    Open Application TT-Planer on Google Pixel 9
    Wait Until Login Screen Is Ready

Set Up Pixel9Pro_API35 NoWaitForLoginScreen
    Start Appium if necessary
    Start Emulator if necessary

    #ToDo: can be further optimized
    #Get Appium SessionId
    #Page Should Contain Element    id=${ELEMENT_ID}

    initializeCurrentSession
    Close All Appium Sessions
    BuiltIn.Sleep    1s

    Open Application TT-Planer on Google Pixel 9

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

Wait Until Login Screen Is Ready
    #Wait Until Element Is Visible    xpath=//android.widget.Button[@text="Einloggen"]    30s
    #Wait For Primary Element Or Click Secondary

    #waiting until any ttplaner window exists
    #Wait Until Element Is Visible    //android.webkit.WebView    120s

    Run Keyword And Ignore Error    Scroll To Top

    ${result} =    Run Keyword And Ignore Error    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text=""]
    Run Keyword If    '${result}[0]' == 'PASS'    Click Element    xpath=//android.widget.TextView[@text=""]
    ${result} =    Run Keyword And Ignore Error    Wait Until Element Is Visible    xpath=//android.widget.Button[@text="Einloggen"]    10s
    #Run Keyword If    '${result}[0]' == 'FAIL'    Click Element    xpath=//android.widget.TextView[@text=""]
    #Log    ${result}[0]
    Run Keyword If    '${result}[0]' == 'FAIL'    Restart Application
    #ToDo: könnte sein dass die Anwendung noch offen ist, dann sollte der Abmelden-Button gedrückt werden und dann nochmals auf den Einloggen-Button gewartet

Restart Application
    Close Application
    Open Application TT-Planer On Google Pixel 9
    Wait Until Element Is Visible    xpath=//android.widget.Button[@text="Einloggen"]    10s
    #ToDo    Restart code

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

Open Application TT-Planer on Google Pixel 9 with reset
    #Open Application    http://127.0.0.1:4723
    ${appID}=    Open Application    http://192.168.2.224:4723
    ...                 platformName=Android
    ...                 deviceName=emulator-5554
    ...                 appPackage=org.chromium.webapk.a62c68cebaf69977d_v2
    ...                 appActivity=org.chromium.webapk.shell_apk.h2o.H2OOpaqueMainActivity
    ...                 automationName=UIAutomator2
    ...                 noReset=false
    Log    ${appID}

Open Application TT-Planer on Google Pixel 9
    #Open Application    http://127.0.0.1:4723
    Open Application    http://192.168.2.224:4723
    ...                 platformName=Android
    ...                 deviceName=emulator-5554
    ...                 appPackage=org.chromium.webapk.a62c68cebaf69977d_v2
    ...                 appActivity=org.chromium.webapk.shell_apk.h2o.H2OOpaqueMainActivity
    ...                 automationName=UIAutomator2
    ...                 noReset=true

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
