*** Settings ***
Library    sessionHelperAppium.py
Resource    ../Resources/Utils/Mobile_Mgmt.resource

*** Test Cases ***
Get driver from AppiumLibrary test
    Open Application TT-Planer On Google Pixel 9
    ${driver}=    Get Driver From Appiumlibrary
    Log    ${driver}