*** Settings ***
Documentation    Error test case
Library    String
Library    OperatingSystem
Library    yaml
Resource   Browser_Mgmt.resource
Variables    pagLogin.py
Variables    pagPasswortReset.py

*** Keywords ***

*** Variables ***
${OldLogLevel}    TRACE
${ErrorCount}    0
@{ErrorElements}

*** Test Cases ***
testcase1 - empty email
    Set up browser
    
    Highlight Elements    ${lnkPasswortVergessen}    duration=2000ms    width=5px    style=dotted     color=\#FF0000
    Take Screenshot
    Click    ${lnkPasswortVergessen}

    Set Log Level    INFO

    Get Attribute Names    ${lnkZurueckZumLogin}

    Click    ${butPasswortReset}

    ${ErrorCount}=    Get Element Count    ${lisFehler}
    Log    ${ErrorCount}

    @{ErrorElements}=    Get Elements    ${lisFehler}

    FOR    ${ListEntry}    IN    @{ErrorElements}
        Get Text    ${ListEntry}
    END

    Set Log Level    ${OldLogLevel}

    Click    ${butAlertSchliessen}
    Take Screenshot

    Click    ${lnkZurueckZumLogin}

    Tear down browser