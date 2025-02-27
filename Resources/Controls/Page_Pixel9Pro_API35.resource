*** Settings ***
Library    String
Library    AppiumLibrary

*** Variables ***

*** Keywords ***
Page specific get text
    [Arguments]    ${Selector}
    ${PageContent}=    AppiumLibrary.Get Text    ${Selector}
    RETURN    ${PageContent}

Page specific get classes
    [Arguments]    ${Selector}
    Wait Until Element Is Visible    ${Selector}
    ${ListWithActive}=    Create List    active
    ${ListWithInactive}=    Create List    inactive
    
    ${PageName}=    AppiumLibrary.Get Text    ${Selector}
    ${WindowTitle}=    AppiumLibrary.Get Text    //android.webkit.WebView
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
    AppiumLibrary.Click Element   ${Selector}