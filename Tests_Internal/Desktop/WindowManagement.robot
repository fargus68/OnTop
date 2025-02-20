*** Settings ***
Library    FlaUILibrary
Library    String

*** Variables ***
${xpathConsoleWindows}    //*[@AutomationId='Console Window']
${WINDOW_TITLE_PATTERN}    //*[@ClassName='ConsoleWindowClass']

*** Keywords ***


*** Test Cases ***
Move emulator window
    #${elements}=    Find All Elements    ${WINDOW_TITLE_PATTERN}
    #${elements}=    Find All Elements    //*[@ClassName='ConsoleWindowClass']
    #Log Many    ${elements}
    #${elements}    Find All Elements    ${xpathConsoleWindows}
