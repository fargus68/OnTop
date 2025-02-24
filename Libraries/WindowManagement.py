import pygetwindow as gw

def setwindowtopos (partofwindowstitle, x : int, y : int, width : int = -1, height : int = - 1):
    success = False
    print(x, y, width, height)
    print(type(x))
    # Find the console window by title
    #window = gw.getWindowsWithTitle('Command Prompt')[0]
    print(gw.getAllTitles())

    #list = gw.getAllWindows()
    list = gw.getAllTitles()
    for title in list:
        if partofwindowstitle in title:
            window = gw.getWindowsWithTitle(title)[0]
            #window.resizeTo(width, height)
            if width != -1 and height != -1:
                window.width = width
                window.height = height
            window.moveTo(x, y)
            success = True
            break

    return success

def window_exists (partofwindowstitle):
    success = False
    list = gw.getAllTitles()
    for title in list:
        if partofwindowstitle in title:
            success = True
            break
    return success