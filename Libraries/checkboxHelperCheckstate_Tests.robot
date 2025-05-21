*** Settings ***
Library    Resources/Utils/DriverSingletonAdapter.py
Library    checkboxHelperCheckstate.py
Library    ScrollIntoView.py

*** Variables ***

*** Test Cases ***
Checkbox state detection test
    #${driver}=    sessionHelperAppium.Get Current Session
    #Log    sessionHelperAppium.Get Session Info
    #${rc}=    get_checkbox_state    //android.view.View[@text='Typ: Teilnahme am Training?']/parent::*/android.view.View[@text='📱 App:']/android.widget.CheckBox
    #Log    ${rc}
    Scroll To Top

    ${rc}=    Get Checkbox State    //android.view.View[@text='Typ: Terminumfrage für Spielverlegung']/parent::*/android.view.View[@text='📱 App:']/android.widget.CheckBox
    Log    ${rc}
    ${rc}=    get_checkbox_state    //android.view.View[@text="Typ: Ersatzanfrage an dich gestellt"]/parent::*/android.view.View[@text="📱 App:"]/android.widget.CheckBox
    Log    ${rc}
    ${rc}=    get_checkbox_state    //android.widget.CheckBox[@resource-id="chat_push_notification"]
    Log    ${rc}
