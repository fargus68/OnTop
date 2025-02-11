def check_if_element_contains_class(list_of_classes, class_name):
    class_found = False
    for theClass in list_of_classes:
        if class_name == theClass:
            class_found = True
            break
    return class_found
