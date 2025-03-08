from sessionHelperAppium import open_session
from elementHelperAppium import search_element

driver = open_session()
#print(search_element("//android.view.View[@text='Typ: Teilnahme am Training?']/parent::*/android.view.View[@text='📱 App:']/android.widget.CheckBox", driver))
#print(search_element("//android.view.View[@text='Typ: Terminumfrage für Spielverlegung']/parent::*/android.view.View[@text='📱 App:']/android.widget.CheckBox", driver))
print(search_element("//android.view.View[@text='Typ: Ersatzanfrage an dich gestellt']/parent::*/android.view.View[@text='📱 App:']/android.widget.CheckBox", driver))
print(search_element("//android.widget.CheckBox[@resource-id='chat_push_notification'']", driver))