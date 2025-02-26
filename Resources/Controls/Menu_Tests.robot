*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Utils/Mobile_Mgmt.resource
Resource    ../../Resources/Framework/fwDialog.resource
#Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Controls/Menu.resource

*** Test Cases ***
Chromium_Set_ClickMenuMeinProfil
    Setup AUT Chromium
    DialogExecution    dlgLogin    001_Login_001_Successful
    #funktioniert: MenuProcessing    <SET>    menMeinProfil    xpath=//*[@class='menu-link']//div[contains(text(), 'Mein Profil')]    X
    MenuProcessing    dlgMain    <SET>    menMeinProfil    xpath=//*[@class='menu-item ']/a/div[contains(text(), 'Mein Profil')]    X
    #nicht eindeutig: MenuProcessing    <SET>    menMeinProfil    xpath=//div[contains(text(),'Mein Profil')]    X
    #funktioniert:    MenuProcessing    <SET>    menMeinProfil    xpath=//*[@id="layout-menu"]/ul/li[2]/a/div    X

Pixel9Pro_API35_Set_ClickMenuMeinProfil
    Setup AUT Pixel9Pro_API35
    DialogExecution    dlgLogin    001_Login_001_Successful
    MenuProcessing    dlgMain    <SET>    menMeinProfil    xpath=//android.view.View[@content-desc=" Mein Profil"]    X

