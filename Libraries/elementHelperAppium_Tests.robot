*** Settings ***
Library    sessionHelperAppium.py
Library    elementHelperAppium.py

*** Variables ***

*** Test Cases ***
Checkbox state detection test
    ${driver}=    Open Session
    ${rc}=    search_element    //android.view.View[@text='Typ: Teilnahme am Training?']/parent::*/android.view.View[@text='📱 App:']/android.widget.CheckBox    ${driver}
    Log    ${rc}
    ${rc}=    search_element    //android.view.View[@text='Typ: Terminumfrage für Spielverlegung']/parent::*/android.view.View[@text='📱 App:']/android.widget.CheckBox    ${driver}
    Log    ${rc}
    ${rc}=    search_element    //android.view.View[@text="Typ: Ersatzanfrage an dich gestellt"]/parent::*/android.view.View[@text="📱 App:"]/android.widget.CheckBox    ${driver}
    Log    ${rc}
    ${rc}=    search_element    //android.widget.CheckBox[@resource-id="chat_push_notification"]    ${driver}
    Log    ${rc}