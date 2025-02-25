*** Settings ***
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Controls/UnorderedList.resource

*** Test Cases ***
Browser_Get_UnorderedList_KeywordX
    Set Up Browser
    Click    text=Einloggen
    UnorderedListProcessing    dlgLogin    <GET>    uliFehler    xpath=//*[@class='alert alert-danger border-left-danger alert-dismissible fade show']/ul/li    X

Browser_Chk_UnorderedList_TwoErrorEntries
    Set Up Browser
    Click    text=Einloggen
    InitializeVariableStorage
    SetVariableValue    AUT    Chromium
    UnorderedListProcessing    dlgLogin    <CHK>    uliFehler    xpath=//*[@class='alert alert-danger border-left-danger alert-dismissible fade show']/ul/li    E-Mail-Adresse muss ausgefüllt werden.<||>Passwort muss ausgefüllt werden.