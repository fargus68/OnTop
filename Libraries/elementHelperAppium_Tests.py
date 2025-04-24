#from sessionHelperAppium import open_session
from sessionHelperAppium import *
from elementHelperAppium import search_element

#driver = open_session()
#driver = get_current_session()
#print(search_element("//android.view.View[@text='Typ: Teilnahme am Training?']/parent::*/android.view.View[@text='📱 App:']/android.widget.CheckBox"))
#print(search_element("//android.view.View[@text='Typ: Terminumfrage für Spielverlegung']/parent::*/android.view.View[@text='📱 App:']/android.widget.CheckBox"))
#print(search_element("//android.view.View[@text='Typ: Ersatzanfrage an dich gestellt']/parent::*/android.view.View[@text='📱 App:']/android.widget.CheckBox"))
#print(search_element("//android.widget.CheckBox[@resource-id='chat_push_notification'']"))
#print(search_element("//android.widget.Button[@text='Set']"))
#print(search_element("//android.widget.Button[@text='Einloggen']"))
#print(search_element("xpath=//*[@hint='E-MAIL ADRESSE:']"))
print(search_element("xpath=//android.view.View[@resource-id='navbar-collapse'][2]/android.widget.ListView/android.view.View[3]/android.view.View/android.widget.TextView"))