*** Settings ***
Library    ExcelLibrary
Library    String
Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Framework/fwDialog.resource
Resource    ../../Resources/Utils/Browser_Mgmt.resource

*** Variables ***

*** Keywords ***

*** Test Cases ***
ExpectedDialogFound
    Set Up Browser
    InitializeDialogData    dlgLogin
    CheckIfDialogExists    dlgLogin

ExpectedDialogNotFound
    Set Up Browser
    InitializeDialogData    dlgPasswordReset
    CheckIfDialogExists    dlgPasswordReset