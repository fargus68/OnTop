*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Framework/fwDialog.resource
Resource    ../../Resources/Controls/Menu.resource

*** Test Cases ***
Set_ClickMenuMeinProfil
    Set Up Browser
    DialogExecution    dlgLogin    001_Login_001_Successful
    #funktioniert: MenuProcessing    <SET>    menMeinProfil    xpath=//*[@class='menu-link']//div[contains(text(), 'Mein Profil')]    X
    MenuProcessing    <SET>    menMeinProfil    xpath=//*[@class='menu-item ']/a/div[contains(text(), 'Mein Profil')]    X
    #nicht eindeutig: MenuProcessing    <SET>    menMeinProfil    xpath=//div[contains(text(),'Mein Profil')]    X
    #funktioniert:    MenuProcessing    <SET>    menMeinProfil    xpath=//*[@id="layout-menu"]/ul/li[2]/a/div    X