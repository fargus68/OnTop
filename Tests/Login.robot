*** Settings ***
Documentation    This is a test
Library    String
Library    OperatingSystem
#Library    yaml
Library    Browser
Resource   Browser_Mgmt.resource
Variables    pagLogin.py

*** Keywords ***
log list elements
    [Arguments]    ${ListElement}


*** Variables ***
${OldLogLevel}    TRACE
${ErrorCount}    0
@{ErrorElements}

*** Test Cases ***
testcase1 - empty email and password
    Set up browser

    #Log    Hello World!
    ${email}=    Get Text    ${txtEmailAdresse}
    ${pwd}=    Get Text    ${pwdPasswort}

    Click    ${butEinloggen}

    Log Many       email = ${email}    pwd = ${pwd}
    Log    pwd = ${pwd}

    Set Log Level    INFO
    Get Attribute Names    ${altFehler}
    #Get Attribute    ${altFehler}    "role"
    Log Many    Get Text    ${lisFehler}
    ${ErrorCount}=    Get Element Count    ${lisFehler}
    Log    ${ErrorCount}

    @{ErrorElements}=    Get Elements    ${lisFehler}

    FOR    ${ListEntry}    IN    @{ErrorElements}
        Get Text    ${ListEntry}
    END

    Set Log Level    ${OldLogLevel}

    Click    ${butAlertSchliessen}
    Take Screenshot

    Click    ${lnkRegistrieren}
    Take Screenshot

    Tear down browser