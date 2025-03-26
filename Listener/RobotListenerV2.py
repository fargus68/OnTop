from robot.libraries.BuiltIn import BuiltIn

b = BuiltIn()

class RobotListenerV2:

    ROBOT_LISTENER_API_VERSION = 2
    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    def __init__(self):
        self.ROBOT_LIBRARY_LISTENER = self
        pass

    def start_suite(self, name, attrs):
        print(name)
        print(attrs)
        pass

    def start_test(self, name, attrs):
        print(name)
        print(attrs)
        pass

    def start_keyword(self, name, attrs):
        print(name)
        print(attrs)
        pass

    def end_keyword(self, name, attrs):
        print(name)
        print(attrs)
        pass

    def end_test(self, name, attrs):
        print(name)
        print(attrs)
        pass

    def end_suite(self, name, attrs):
        print(name)
        print(attrs)
        pass

    def log_message(self, message):
        print(message)
        pass

    def message(self, message):
        print(message)

        pass

    def library_import(self, name, attrs):
        print(name)
        print(attrs)
        pass

    def resource_import(self, name, attrs):
        print(name)
        print(attrs)
        pass

    def variables_import(self, name, attrs):
        print(name)
        print(attrs)
        pass

    def output_file(self, path):
        print(path)
        pass

    def log_file(self, path):
        print(path)
        pass

    def report_file(self, path):
        print(path)
        pass

    def xunit_file(self, path):
        print(path)
        pass

    def debug_file(self, path):
        print(path)
        pass

    def close(self):
        pass