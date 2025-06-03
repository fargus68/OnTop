import appium
from appium.options.android import UiAutomator2Options
from appium.webdriver import webdriver
import requests

SERVER_URL_BASE = 'http://127.0.0.1:4723'

desired_caps = {
    'platformName': 'Android',
    'deviceName': 'emulator-5554',
    'appPackage': 'org.chromium.webapk.a62c68cebaf69977d_v2',
    'appActivity': 'org.chromium.webapk.shell_apk.h2o.H2OOpaqueMainActivity',
    'automationName': 'UIAutomator2',
    'noReset': True,
    'autoGrantPermissions': True,
    'newCommandTimeout': 300,  # Erhöhen auf 300 Sekunden oder mehr
    'adbExecTimeout': 120000,  # 60 Sekunden in Millisekunden
    'waitForIdleTimeout': 30000,  # 30 Sekunden in Millisekunden
    'uiautomator2ServerLaunchTimeout': 60000,  # Add this capability
    'uiautomator2ServerInstallTimeout': 60000,  # Add this capability
    'printPageSourceOnFindFailure': True,
}

from appium.webdriver.client_config import AppiumClientConfig
client_config = AppiumClientConfig(
    remote_server_addr = SERVER_URL_BASE,
    direct_connection=True,
    keep_alive=True,  # False,
    ignore_certificates=True,
)
driver = appium.webdriver.Remote(
    options=UiAutomator2Options().load_capabilities(desired_caps),
    client_config=client_config
)

print(f"Application opened with session ID: {driver.session_id}")

try:
    response = requests.get(SERVER_URL_BASE + "/sessions")
    if response.status_code == 200:
        sessions = response.json().get('value', [])
        print(f"Number of sessions: {len(sessions)}")
    else:
        print(f"Error retrieving sessions: {response.status_code}")
except Exception as e:
    print(f"Connection error: {e}")


