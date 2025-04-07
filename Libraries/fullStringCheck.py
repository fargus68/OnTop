from robot.api import logger

def full_string_check(expected : str, actual : str):
    bool_success : bool = False
    if  expected == actual:
        logger.debug('Expected value "{}" found.'.format(expected))
        bool_success = True
    else:
        logger.error('Expected "{}" but got "{}"'.format(expected, actual))
    return bool_success
