def scroll_into_view(url, xpath):
    from appium import webdriver
    from selenium.webdriver.common.by import By
    driver = webdriver.Remote(url)
    print(driver.current_url)
    #driver = webdriver.Remote(_executor=driver_url, desired_capabilities={})
    element = driver.find_element(xpath)
    element = driver.find_element(By.XPATH, xpath)
    driver.execute_script("arguments[0].scrollIntoView(true);", element)