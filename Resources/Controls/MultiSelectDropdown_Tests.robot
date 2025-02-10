*** Settings ***
Library    Browser    auto_closing_level=keep
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Controls/MultiSelectDropdown.resource

*** Keywords ***
Local set up browser
    New Browser    browser=chromium    headless=false    slowMo=0:00:05
    New Context    viewport={'width': 1280, 'height': 720}
    New Page       url=https://app.tt-planer.de/login

*** Test Cases ***
Get_LoginEmail
    #Set Up Browser
    Local set up browser
    MultiSelectDropdownProcessing    <GET>    txtEmail    id=email    X
    
Set_LoginEmail
    #Set Up Browser
    Local set up browser
    MultiSelectDropdownProcessing    <SET>    txtEmail    id=email    matthias@matthias-schmotz.de