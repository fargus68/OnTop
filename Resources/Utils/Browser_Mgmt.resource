*** Settings ***
Library    Browser    auto_closing_level=keep
#Library    Browser    auto_closing_level=${auto_closing_level}

*** Variables ***

*** Keywords ***
Set up browser
    [Arguments]    ${browser}=chromium
    ...            ${headless}=false
    ...            ${slowMo}=0:00:05
    ...            ${viewport}={'width': 1280, 'height': 720}
    ...            ${url}=https://app.tt-planer.de/login
    New Browser    browser=${browser}    headless=${headless}    slowMo=${slowMo}
    New Context    viewport=${viewport}
    New Page       url=${url}
    ${tmpSessionId}=    Get Browser Ids
    Set Test Variable    ${session_id}    ${tmpSessionId}
    Log    ${session_id}
    Get Title
    ${catalog}=    Get Browser Catalog
    Log    ${catalog}

Tear down browser
    Close Browser

Log Browser IDs
    Log    ${session_id}
