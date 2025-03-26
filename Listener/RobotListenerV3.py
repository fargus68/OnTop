from robot.libraries.BuiltIn import BuiltIn

class RobotListenerV3:

    ROBOT_LIBRARY_SCOPE = "GLOBAL"
    ROBOT_LISTENER_API_VERSION = 3

    def __init__(self):
        pass

    def start_suite(self, suite, result):
        pass

    def start_test(self, test, result):
        pass

    def end_test(self, test, result):
        pass

    def end_suite(self, suite, result):
        pass

    def log_message(self, message):
        pass

    def message(self, message):
        pass

    def debug_file(self, path):
        pass

    def output_file(self, path):
        pass

    def xunit_file(self, path):
        pass

    def log_file(self, path):
        pass

    def report_file(self, path):
        pass

    def close(self):
        pass