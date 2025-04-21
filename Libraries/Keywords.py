def check_keyword_existence(value : str, keyword : str):
    bool_keyword_var_found : bool = False
    ix_keyword_start : int =    value.find("<" + keyword)
    if  ix_keyword_start != -1:
        bool_keyword_var_found = True
    return bool_keyword_var_found

def get_keyword_value(value : str, keyword : str):
    ix_keyword_start : int =    value.find("<" + keyword)
    ix_keyword_value_start : int = ix_keyword_start + len("<" + keyword) + 1
    ix_keyword_end : int = value.find(">", ix_keyword_start)
    ix_keyword_value_end : int = ix_keyword_end
    keyword_value = value[ix_keyword_value_start : ix_keyword_value_end]
    return keyword_value

def get_keyword_string_values(value : str, keyword : str):
    ix_keyword_start : int =    value.find("<" + keyword)
    ix_keyword_value_start : int = ix_keyword_start + len("<" + keyword) + 1
    ix_keyword_end : int = value.find(">", ix_keyword_start)
    ix_keyword_value_end : int = ix_keyword_end
    keyword_value = value[ix_keyword_value_start + 1 : ix_keyword_value_end - 1]
    string_values = keyword_value.split('","')
    return string_values

def get_full_keyword_substring(value : str, keyword : str):
    ix_keyword_start : int =    value.find("<" + keyword)
    ix_keyword_end : int = value.find(">", ix_keyword_start)
    full_keyword_part : str = value[ix_keyword_start : ix_keyword_end + 1]
    return full_keyword_part

def get_any_full_keyword_substring(value : str):
    ix_keyword_start : int =    value.find("<")
    ix_keyword_end : int = value.find(">", ix_keyword_start)
    full_keyword_part : str = value[ix_keyword_start : ix_keyword_end + 1]
    return full_keyword_part