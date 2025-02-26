*** Settings ***
Library    ExcelLibrary
Library    String
Resource    ../../Resources/Framework/fwVariables.resource
Resource    ../../Resources/Framework/fwDialog.resource
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Utils/Mobile_Mgmt.resource

*** Variables ***

*** Keywords ***
Setup AUT Chromium
    Set Up Browser
    InitializeVariableStorage
    SetVariableValue    AUT    Chromium

Setup AUT Pixel9Pro_API35
    Set Up Pixel9Pro_API35
    InitializeVariableStorage
    SetVariableValue    AUT    Pixel9Pro_API35

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