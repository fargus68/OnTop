#RoboCon 2023 - Robot Framework Listener API in Theory and Practice
#

from robot import result, running
#from robot.api.interfaces import ListenerV3

class ListenerClass:

    ROBOT_LISTENER_API_VERSION = 3

    def start_suite(self, data: running.TestSuite, result: result.TestSuite):
        print(f"Suite '{data.name}' starting.")

    def start_keyword(self, name, attributes):
        #print(f"*INFO* Executing keyword: {name}")
        if name == "FlowExecution":
            print(f"Flow execution")
            print(attributes)

    #[Arguments]    ${Flow}    ${FlowRecord}

    def end_test(self, data: running.TestCase, result: result.TestCase):
        print(f"Test '{result.name}' ended with status {result.status}.")