*** Settings ***
Library    Browser    auto_closing_level=keep

*** Test Cases ***
Test1
    Log    Test
    New Browser    browser=chromium    headless=false    slowMo=0:00:05
    New Context    viewport={'width': 1280, 'height': 720}
    New Page       url=https://app.tt-planer.de/login

Test2
    New Page       url=https://google.de
    Take Screenshot
    Sleep    5s