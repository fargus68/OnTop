from time import sleep
from elementHelperAppium import search_element
from robot.api import logger
from lxml.etree import *

def search_row(grid_selector, row_ix, all_data):
    logger.info('search row by data')
    #logger.info(all_data)

    row_selector = grid_selector + '/android.view.View[@index=' + str(row_ix) + ']'
    logger.info('row selector = ' + row_selector)

    print(type(all_data))
    aut_row = all_data[0]
    print(type(aut_row))
    col_count = len(aut_row)
    print('col_count = ' + str(col_count))

    row_found = True

    for col_ix in range(1, col_count):
        print('col_ix = ' + str(col_ix))
        selector = all_data[0][col_ix]
        print('selector = ' + str(selector))
        column = all_data[1][col_ix]
        print('column = ' + str(column))
        value = all_data[2][col_ix]
        print('value = ' + str(value))

        if str(value) != 'None':
            cell_selector = row_selector + "/*" + selector[1:]
            print('cell_selector = ' + cell_selector)
            theCell = search_element(cell_selector)
            print('Cell text = ' + theCell.text)

            if str(value) != theCell.text:
                row_found = False
                break
    return row_found

def delete_row(grid_selector, all_data):
    sleep(1)
    row_ix = 0
    row_to_delete_found = False

    #rows_selector = grid_selector + '/android.view.View'
    #rows = driver.find_elements(AppiumBy.XPATH, rows_selector)
    #actual_row_count = len(rows)
    #print("actual_row_count = " + str(actual_row_count))

    #does not work without espresso driver
    #actual_row_count = get_real_row_count(grid_selector, driver)
    #print("actual_row_count = " + str(actual_row_count))

    #for testing purposes
    row_to_delete_found = False

    while not row_to_delete_found:

        if search_row(grid_selector, row_ix, all_data):
            row_to_delete_found = True
            break
        else:
            row_ix += 1

    print("Row ix to delete = " + str(row_ix) )

    actionMenuSelector = grid_selector + '/android.view.View[@index=' + str(row_ix) + ']//android.widget.Button'
    search_element(actionMenuSelector).click()

    deleteMenuItemSelector = grid_selector + '/android.view.View[@index=' + str(row_ix) + ']//android.widget.TextView[@text=" Löschen"]'
    search_element(deleteMenuItemSelector).click()

    modalDialogOkButtonSelector = '//android.widget.Button[@resource-id="com.android.chrome:id/positive_button"]'
    search_element(modalDialogOkButtonSelector).click()

def get_real_row_count(grid_selector, driver):
    # Den gesamten Seitenquelltext abrufen
    page_source_unicode = driver.page_source
    page_source = page_source_unicode.encode('utf-8')
    #print('tree = ' + str(page_source))

    # XPath verwenden, um alle Zeilen in der Tabelle zu finden
    from lxml import etree
    from lxml import html

    htmltree = etree.HTML(page_source)
    tree = etree.XML(page_source)

    print("htmltree")
    print("########")
    print(etree.tostring(htmltree, pretty_print=True).decode('utf-8'))
    print()
    print("xmltree")
    print("########")
    print(etree.tostring(tree, pretty_print=True).decode('utf-8'))

    rows_selector = grid_selector + '/android.view.View'
    #rows_selector = '//android.widget.GridView'
    #rows_selector = "//android.widget.GridView/android.view.View"
    alle_zeilen = tree.xpath(rows_selector)  # Passe den XPath an deine Tabelle an
    anzahl_zeilen = len(alle_zeilen)
    print(f"Die Gesamtanzahl der Zeilen in der Tabelle ist: {anzahl_zeilen}")

    result = tree.xpath('//android.widget.FrameLayout')
    print(result)

    print(type(tree))

    namespaces = {'android': 'http://schemas.android.com/apk/res/android'}
    result = tree.xpath('//android.widget.GridView', namespaces=namespaces)
    print(result)

    #klappt!
    #root = tree.getroottree()
    #print(root)
    #print(etree.tostring(root, pretty_print=True).decode('utf-8'))

    print("LIBXML_COMPILED_VERSION = " + str(LIBXML_COMPILED_VERSION))
    print("LIBXML_VERSION = " + str(LIBXML_VERSION))
    print("LIBXSLT_COMPILED_VERSION + " + str(LIBXSLT_COMPILED_VERSION))
    print("LIBXSLT_VERSION = " + str(LIBXSLT_VERSION))
    print("LXML_VERSION = " + str(LXML_VERSION))

    root = tree.Element("root")
    print(root.tag)

    #Findet nix
    print("Experiment 1 = " + str(root.find('.', namespaces=namespaces)))
    print(root.find('.//android.widget.GridView', namespaces=namespaces).text)

    #print(f"Die Gesamtanzahl der Zeilen in der Tabelle ist: {anzahl_zeilen}")
    return anzahl_zeilen