*** Settings ***
Library    ExcelLibrary
Library    String
Resource    Mobile_Mgmt.resource

*** Test Cases ***
Set Up Pixel9Pro_API35
    Set Up Pixel9Pro_API35

Start app
    Open Application TT-Planer on Google Pixel 9
    Wait Until Login Screen Is Ready
