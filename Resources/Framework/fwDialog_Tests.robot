*** Settings ***
Library    ExcelLibrary
Library    String
Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Framework/fwDialog.resource
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Utils/Mobile_Mgmt.resource

*** Variables ***

*** Keywords ***

*** Test Cases ***
Chromium_ExpectedDialogFound
    Setup AUT Chromium
    InitializeDialogData    dlgLogin
    CheckIfDialogExists

Chromium_ExpectedDialogNotFound
    Setup AUT Chromium
    InitializeDialogData    dlgPasswordReset
    CheckIfDialogExists

Pixel9Pro_API35_ExpectedDialogFound
    Setup AUT Pixel9Pro_API35
    InitializeDialogData    dlgLogin
    CheckIfDialogExists

Pixel9Pro_API35_ExpectedDialogNotFound
    Setup AUT Pixel9Pro_API35
    InitializeDialogData    dlgPasswordReset
    CheckIfDialogExists