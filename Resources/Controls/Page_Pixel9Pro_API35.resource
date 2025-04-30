*** Settings ***
Library    BuiltIn
Library    String
#Library    AppiumLibrary
Library    ../../Libraries/elementHelperAppium.py    WITH NAME    ElementHelper
Library    ../../Libraries/screenshotHelperAppium.py    WITH NAME    ScreenshotHelper


*** Variables ***

*** Keywords ***
Page specific get text
    [Arguments]    ${Selector}
    #${PageContent}=    AppiumLibrary.Get Text    ${Selector}
    ${element}=    ElementHelper.Search Element    ${Selector}
    ${PageContent}=    Set Variable    ${element.text}
    RETURN    ${PageContent}

Page specific get classes
    [Arguments]    ${Selector}
    #Wait Until Element Is Visible    ${Selector}

    ${ListWithActive}=    Create List    active
    ${ListWithInactive}=    Create List    inactive

    ${PageElement}=    ElementHelper.Search Element    ${Selector}
    ${PageName}=    Set Variable    ${PageElement.text}
    #${PageName}=    AppiumLibrary.Get Text    ${Selector}
    ${WindowElement}=    ElementHelper.Search Element    //android.webkit.WebView
    #${WindowTitle}=    AppiumLibrary.Get Text    //android.webkit.WebView
    ${WindowTitle}=    Set Variable    ${WindowElement.text}

    IF    "${PageName}" == "Profil" and "${WindowTitle}" == "Mein Profil | TT-Planer"
        RETURN    ${ListWithActive}
    ELSE
        RETURN    ${ListWithInactive}
    END

    IF    "${PageName}" == "${WindowTitle}"
        RETURN    ${ListWithActive}
    ELSE
        RETURN    ${ListWithInactive}
    END

    RETURN    not handled yet

Page specific click
    [Arguments]    ${Selector}
    #AppiumLibrary.Wait Until Element Is Visible    ${Selector}
    #BuiltIn.Sleep    250ms
    #AppiumLibrary.Click Element   ${Selector}
    #BuiltIn.Sleep    250ms
    BuiltIn.Sleep    500ms
    ${element}=    ElementHelper.Search Element    ${Selector}
    Evaluate    $element.click()
    ScreenshotHelper.Take Screenshot