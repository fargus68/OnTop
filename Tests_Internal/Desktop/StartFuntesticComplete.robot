*** Settings ***
Library    FlaUILibrary
Library    String

*** Variables ***
${FilePath}    C:\\Users\\matth\\source\\repos\\FuntesticComplete\\FuntesticComplete\\bin\\x64\\Release\\net9.0-windows10.0.26100\\
${FileName}    FuntesticComplete.exe
${xpathConfigurationMenu}    //MenuBar/MenuItem[@AutomationId='MenuBarItemConfiguration']
${xpathConfigurationPlaningMenu}    //*[@AutomationId='MenuFlyoutSubItemConfigurationPlanning']
${xpathConfigurationPlaningTestObjectTypesMenu}    //*[@AutomationId='MenuFlyoutItemConfigurationPlanningTestObjectType']
${xpathConfigurationPlaningTestLevelMenu}    //*[@AutomationId='MenuFlyoutItemConfigurationPlanningTestLevel']
${xpathTestManagementMenu}    //MenuBar/MenuItem[@AutomationId='MenuBarItemTestManagement']
${xpathTestManagementTestProjectMenu}    //*[@AutomationId='MenuFlyoutItemManagementTestProject']
${ActualPid}    16752

*** Test Cases ***
Start FuntesticComplete
    ${FullPath}    catenate    SEPARATOR=    ${FilePath}    ${FileName}
    Log    ${FullPath}
    ${pid}    Launch Application    ${FullPath}

Start Dialog Konfiguration Testplanung Testobjekttypen
    ${pid}    Attach Application By PID    ${ActualPid}
    Click    ${xpathConfigurationMenu}
    Take Screenshot
    Click    ${xpathConfigurationPlaningMenu}
    Take Screenshot
    Take Screenshot    ${xpathConfigurationPlaningTestObjectTypesMenu}
    Click    ${xpathConfigurationPlaningTestObjectTypesMenu}
    Take Screenshot
    Click    ${xpathConfigurationPlaningTestLevelMenu}
    Take Screenshot

Start Dialog Testplanung Testobjekte
    ${pid}    Attach Application By PID    ${ActualPid}
    Click    ${xpathTestManagementMenu}
    Take Screenshot
    Click    ${xpathTestManagementTestProjectMenu}
    Take Screenshot
    Take Screenshot    ${xpathTestManagementTestProjectMenu}

       
