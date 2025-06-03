*** Settings ***
Library    BuiltIn
Library    String
Library    ../../Libraries/elementHelperAppium.py    WITH NAME    ElementHelper
Library    ../../Libraries/screenshotHelperAppium.py    WITH NAME    ScreenshotHelper
Library    DriverSingletonAdapter.py    WITH NAME    mgmt_direct
#Library    ../../Libraries/ScrollIntoView.py

*** Variables ***
${MENU_HEADER_XPATH}    xpath=//android.widget.TextView[@text='']

*** Keywords ***
Menu specific get text
    [Arguments]    ${Selector}
    ${element}=    ElementHelper.Search Element    ${Selector}
    ${MenuContent}=    Set Variable    ${element.text}
    RETURN    ${MenuContent}

#Navigate_And_Click_Menu_Element
Menu specific click
    [Arguments]    ${target_selector}
    #BuiltIn.Sleep    1s
    #${element}=    ElementHelper.Search Element    ${MENU_HEADER_XPATH}
    ${menu_visible}=    check_if_element_exists    ${MENU_HEADER_XPATH}
    #Run Keyword If    ${menu_visible} == ${False}    ScrollIntoView.scroll_to_top
    Run Keyword If    ${menu_visible} == ${False}    mgmt_direct.scroll_to_top
    #Run Keyword If    ${menu_visible} == ${False}    mgmt_direct.Scroll To Top
    #Mgmt_direct.Scroll To Top

    ${element}=    ElementHelper.Search Element    ${MENU_HEADER_XPATH}
    Evaluate    $element.click()
    Take_Screenshot
    ${element}=    ElementHelper.Search Element    ${target_selector}
    Take_Screenshot
    Evaluate    $element.click()

Take_Screenshot
    ScreenshotHelper.Take Screenshot