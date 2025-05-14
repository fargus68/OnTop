*** Settings ***
Library    OperatingSystem
Library    Process
Library    String
Library    Browser    auto_closing_level=keep    #enable_presenter_mode={'duration': '0:00:01', 'width': '3px', 'style': 'solid', 'color': 'red'}
Resource    ../../Resources/Framework/fwVariables.resource
#Library    Browser    auto_closing_level=${auto_closing_level}

*** Variables ***

*** Keywords ***
Set up browser
    [Arguments]    ${browser}=chromium
    ...            ${headless}=false
    ...            ${slowMo}=0:00:01
    ...            ${viewport}={'width': 1280, 'height': 720}
    ...            ${url}=https://app.tt-planer.de/login
    #[Arguments]    ${browser}=chromium
    #[Arguments]    ${browser}=firefox
    #[Arguments]    ${browser}=webkit

    #Launch Browser Server    browser=${browser}    headless=${headless}    slowMo=${slowMo}    port=9222
    New Browser    browser=${browser}    headless=${headless}    slowMo=${slowMo}
    New Context    viewport=${viewport}
    New Page       url=${url}
    ${tmpSessionIds}=    Get Browser Ids
    #${tmpSessionId}=    ${tmpSessionIds}[0]
    #${tmpSessionId}=    Replace String    ${tmpSessionId}    browser=
    ${tmpSessionId}=    Remove String    ${tmpSessionIds}[0]    browser=
    #Set Test Variable    ${session_id}    ${tmpSessionId}
    Set Global Variable    ${session_id}    ${tmpSessionId}
    Log    ${session_id}
    Get Title
    ${catalog}=    Get Browser Catalog
    Log    ${catalog}

Tear down browser
    Close Browser
    #Close Context

Log Browser IDs
    Log    ${session_id}

Get Session ID
    RETURN    ${session_id}

Kill all chromium processes
    Log    not implemented yet

Setup AUT Chromium
    Set Up Browser
    InitializeVariableStorage
    SetVariableValue    AUT    Chromium  

Setup AUT Chromium VehicleInsuranceDemoApp
    Set Up Browser    url=https://sampleapp.tricentis.com/101/
    InitializeVariableStorage
    SetVariableValue    AUT    Chromium

Open Existing AUT Chromium VehicleInsuranceDemoApp
    Open Browser
