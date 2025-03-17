#RoboCon 2023 - Robot Framework Listener API in Theory and Practice
#

from robot import result, running
from robot.api.interfaces import ListenerV3


class Example(ListenerV3):

    def start_suite(self, data: running.TestSuite, result: result.TestSuite):
        print(f"Suite '{data.name}' starting.")

    def end_test(self, data: running.TestCase, result: result.TestCase):
        print(f"Test '{result.name}' ended with status {result.status}.")