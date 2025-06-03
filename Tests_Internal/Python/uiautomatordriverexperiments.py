import uiautomator2 as u2

try:
    device = u2.connect('emulator-5554')
except u2.core.AccessibilityServiceAlreadyRegisteredError as e:
    print("AccessibilityServiceAlreadyRegisteredError: " + str(e))
    exit(1)
except Exception as e:
    print("Error connecting to device: " + str(e))
    exit(1)

device.app_clear("org.chromium.webapk.a62c68cebaf69977d_v2")  # Löscht App-Daten
#device.app_clear("com.android.chrome")
device.app_stop("org.chromium.webapk.a62c68cebaf69977d_v2")   # Stoppt die App
#device.app_stop("org.chromium.webapk.a62c68cebaf69977d_v2")
#device.shell("am force-stop org.chromium.webapk.a62c68cebaf69977d_v2")
device.app_start("org.chromium.webapk.a62c68cebaf69977d_v2")   # Startet die App
#exit(0)

print("app_current = " + str(device.app_current()))
app_current = device.app_current()
for key in app_current:
    print("app_current['" + key + "'] = " + str(app_current[key]))
print("")

print("app_list_running = " + str(device.app_list_running()))
for app in device.app_list_running():
    print("app_running = " + str(app))
print("")


print("adb_device.info = " + str(device.adb_device.info))

print("app_list = " + str(device.app_list()))
for app in device.app_list():
    print("app = " + str(app))

print("")

print("settings = " + str(device.settings))
print("shell = " + str(device.shell))
device_info = device.info
#print("device_info = " + str(device_info))
print("")
for key in device_info:
    #print(key + " = " + str(device_info[key]))
    print("device_info['" + key + "'] = " + str(device_info[key]))

#session = u2.Session
#print(str(session.app_info(, package_name='com.android.chrome')))

#session = device.session('com.android.chrome',attach=True)

# Zuerst den aktuellen Paketnamen ermitteln
app_current = device.app_current()
package_name = app_current['package']
print("Aktueller Paketname:", package_name)

# Dann die Session mit dem korrekten Paketnamen erstellen
#session = device.session(package_name, attach=True)
session = device.session("org.chromium.webapk.a62c68cebaf69977d_v2", attach=True)
print("session.info = " + str(session.info))
print("session.app_current = " + str(session.app_current()))
print("session.app_info = " + str(session.app_info(package_name='com.android.chrome')))

email_address = session.xpath('//*[@hint="E-MAIL ADRESSE:"]').set_text("matthias@matthias-schmotz.de")

device.click(200, 200)

print("email_address = " + str(session.xpath('//*[@hint="E-MAIL ADRESSE:"]').get_text()))

#session.app_stop("org.chromium.webapk.a62c68cebaf69977d_v2")
#app_current = device.app_current()
#app_current.clear()

#exit(0)exit(0)
