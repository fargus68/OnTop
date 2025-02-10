*** Settings ***
Library    Browser    auto_closing_level=keep
Resource    ../../Resources/Utils/Browser_Mgmt.resource
Resource    ../../Resources/Controls/NumericUpDown.resource

*** Keywords ***
Local set up browser
    New Browser    browser=chromium    headless=false    slowMo=0:00:05
    New Context    viewport={'width': 1280, 'height': 720}
    New Page       url=https://app.tt-planer.de/login

*** Test Cases ***
Get_LoginEmail
    #Set Up Browser
    Local set up browser
    NumericUpDownProcessing    <GET>    nudSpielerinnerungStunden    id=email    X
    
Set_LoginEmail
    #Set Up Browser
    Local set up browser
    NumericUpDownProcessing    <SET>    nudSpielerinnerungStunden    id=email    48