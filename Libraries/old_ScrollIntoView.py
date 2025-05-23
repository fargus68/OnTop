from time import sleep
from Resources.Utils.DriverSingletonAdapter import get_current_session

def scroll_to_top():
    driver = get_current_session()
    driver.switch_to.context(driver.contexts[1])
    print(driver.current_context)
    driver.execute_script("window.scrollTo(0, 0)")
    driver.switch_to.context(driver.contexts[0])
    sleep(0.25)

def scroll_page_down():
    driver = get_current_session()
    driver.switch_to.context(driver.contexts[1])
    print(driver.current_context)
    driver.execute_script("window.scrollBy(0, 850)")
    driver.switch_to.context(driver.contexts[0])
    sleep(0.25)
