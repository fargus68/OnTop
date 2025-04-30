*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Utils/Mobile_Mgmt.resource
Resource    ../../Resources/Controls/UnorderedList.resource
Resource    ../../Resources/Controls/Button.resource

*** Test Cases ***
Browser_Get_UnorderedList_KeywordX
    Setup AUT Chromium
    Click    text=Einloggen
    UnorderedListProcessing    dlgLogin    <GET>    uliFehler    xpath=//*[@class='alert alert-danger border-left-danger alert-dismissible fade show']/ul/li    X

Browser_Chk_UnorderedList_TwoErrorEntries
    Setup AUT Chromium
    Click    text=Einloggen
    UnorderedListProcessing    dlgLogin    <CHK>    uliFehler    xpath=//*[@class='alert alert-danger border-left-danger alert-dismissible fade show']/ul/li    E-Mail-Adresse muss ausgefüllt werden.<||>Passwort muss ausgefüllt werden.

#ToDo: doesn't work if alert already on screen
Pixel9Pro_API35_Get_UnorderedList_KeywordX
    Setup AUT Pixel9Pro_API35
    #Click Element    xpath=//android.widget.Button[@text="Einloggen"]
    ButtonProcessing    dlgLogin    <SET>    butEinloggen    xpath=//android.widget.Button[@text="Einloggen"]    X
    UnorderedListProcessing    dlgLogin    <GET>    uliFehler    xpath=//android.widget.ListView    X

Pixel9Pro_API35_Chk_UnorderedList_TwoErrorEntries
    Setup AUT Pixel9Pro_API35
    #Click Element    xpath=//android.widget.Button[@text="Einloggen"]
    ButtonProcessing    dlgLogin    <SET>    butEinloggen    xpath=//android.widget.Button[@text="Einloggen"]    X
    UnorderedListProcessing    dlgLogin    <CHK>    uliFehler    xpath=//android.widget.ListView    E-Mail-Adresse muss ausgefüllt werden.<||>Passwort muss ausgefüllt werden.