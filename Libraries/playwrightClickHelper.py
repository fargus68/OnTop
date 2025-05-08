import playwright

async def click(page, selector):
    await page.click(selector)