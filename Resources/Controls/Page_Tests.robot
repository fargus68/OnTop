*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Utils/Mobile_Mgmt.resource
Resource    ../../Resources/Framework/fwDialog.resource
Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Controls/Page.resource
Library    Browser    auto_closing_level=keep

*** Test Cases ***
Chromium_Set_SelectPageBenachrichtigungen
    Setup AUT Chromium
    DialogExecution    dlgLogin    001_Login_001_Successful
    DialogExecution    dlgMain    Menueauswahl Mein Profil
    Take Screenshot
    #PageProcessing    <SET>    pagBenachrichtigungen    xpath=//*/li[@class = 'nav-item']/a[text()=" Benachrichtigungen"]    <SELECT>
    DialogExecution    dlgProfil    Check defaults
    DialogExecution    dlgProfil    Auswahl Page Benachrichtigungen
    Take Screenshot

Pixel9Pro_API35_Set_SelectPageBenachrichtigungen
    Setup AUT Pixel9Pro_API35
    DialogExecution    dlgLogin    001_Login_001_Successful
    DialogExecution    dlgMain    Menueauswahl Mein Profil
    Capture Page Screenshot
    #PageProcessing    <SET>    pagBenachrichtigungen    xpath=//*/li[@class = 'nav-item']/a[text()=" Benachrichtigungen"]    <SELECT>
    DialogExecution    dlgProfil    Check defaults
    DialogExecution    dlgProfil    Auswahl Page Benachrichtigungen
    Capture Page Screenshot

Chromium_UseExistingBrowser
    RETURN
    #browser=e2f94a34-be03-4568-9982-37397fe83711
    ${catalog}=    Get Browser Catalog
    Log    ${catalog}
    ${ExistingSessionId}=    Get Session ID
    #Connect To Browser    ws://127.0.0.1:9222/devtools/browser/${ExistingSessionId}
    Connect To Browser    http://localhost:9222/devtools/browser/${ExistingSessionId}
    PageProcessing    <SET>    pagBenachrichtigungen    xpath=//*/li[@class = 'nav-item']/a[text()=" Benachrichtigungen"]    <SELECT>
