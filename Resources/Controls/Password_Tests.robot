*** Settings ***
Library    Browser    auto_closing_level=keep
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Controls/Password.resource

*** Keywords ***
Local set up browser
    New Browser    browser=chromium    headless=false    slowMo=0:00:05
    New Context    viewport={'width': 1280, 'height': 720}
    New Page       url=https://app.tt-planer.de/login

*** Test Cases ***
Get_LoginPasswort
    #Set Up Browser
    Local set up browser
    PasswordProcessing    <GET>    pwdPassword    id=password    X
    
Set_LoginPasswort
    #Set Up Browser
    Local set up browser
    PasswordProcessing    <SET>    pwdPassword    id=password    <GETPASSWORD>