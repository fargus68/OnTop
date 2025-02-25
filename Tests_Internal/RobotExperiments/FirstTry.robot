*** Settings ***
Library    Browser

*** Test Cases ***
Test1
    Log    First try
    New Browser    headless=false
    New Page    https://app.tt-planer.de/login
    Type Text    id=email    nur ein Test
    Take Screenshot