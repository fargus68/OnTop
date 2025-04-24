*** Settings ***
Library    Browser

*** Variables ***

*** Keywords ***

*** Test Cases ***
TEST
    New Browser    browser=chromium    headless=false    slowMo=0:00:05
    New Context    viewport={'width': 1280, 'height': 720}
    New Page       url=https://app.tt-planer.de/login

    ${email}=    Get Text    id=email
    ${pwd}=    Get Text    id=password



    Log Many       email = ${email}    pwd = ${pwd}
    Log    pwd = ${pwd}

    Close Browser