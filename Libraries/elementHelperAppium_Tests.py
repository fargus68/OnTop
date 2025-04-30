"""
Unit tests for elementHelperAppium.py

This module contains unit tests for the functions in elementHelperAppium.py.
It uses unittest and mock to test the functions in isolation from their dependencies.

To run the tests:
    python -m unittest elementHelperAppium_Tests.py

The tests cover:
- search_element: Tests for finding elements with various retry counts and selectors
- search_sub_elements: Tests for finding multiple elements
- wait_until_element_exists_and_text_correct: Tests for waiting until an element exists with correct text

Each test uses mocks to simulate the behavior of the Appium driver and other dependencies.
"""

import unittest
from unittest.mock import MagicMock, patch
from selenium.webdriver.common.by import By
from selenium.common import NoSuchElementException
from elementHelperAppium import search_element, search_sub_elements, wait_until_element_exists_and_text_correct


class TestElementHelperAppium(unittest.TestCase):
    """Unit tests for elementHelperAppium.py functions"""

    def setUp(self):
        """Set up test fixtures before each test method"""
        # Create a mock driver
        self.mock_driver = MagicMock()
        self.mock_driver.session_id = "mock_session_id"

        # Create a mock element
        self.mock_element = MagicMock()

        # Create a mock for contexts
        self.mock_driver.contexts = ["NATIVE_APP", "WEBVIEW"]

        # Set up patches
        self.get_current_session_patcher = patch('elementHelperAppium.get_current_session')
        self.mock_get_current_session = self.get_current_session_patcher.start()
        self.mock_get_current_session.return_value = self.mock_driver

        self.scroll_page_down_patcher = patch('elementHelperAppium.scroll_page_down')
        self.mock_scroll_page_down = self.scroll_page_down_patcher.start()

    def tearDown(self):
        """Tear down test fixtures after each test method"""
        self.get_current_session_patcher.stop()
        self.scroll_page_down_patcher.stop()

    def test_search_element_success_first_try(self):
        """Test search_element when element is found on first try"""
        # Arrange
        self.mock_driver.find_element.return_value = self.mock_element

        # Act
        result = search_element("//some/xpath")

        # Assert
        self.assertEqual(result, self.mock_element)
        self.mock_driver.find_element.assert_called_once_with(By.XPATH, "//some/xpath")
        self.mock_scroll_page_down.assert_not_called()

    def test_search_element_success_after_retry(self):
        """Test search_element when element is found after retry"""
        # Arrange
        self.mock_driver.find_element.side_effect = [
            NoSuchElementException("Element not found"),
            self.mock_element
        ]

        # Act
        result = search_element("//some/xpath")

        # Assert
        self.assertEqual(result, self.mock_element)
        self.assertEqual(self.mock_driver.find_element.call_count, 2)
        self.mock_scroll_page_down.assert_called_once_with(self.mock_driver)

    def test_search_element_not_found(self):
        """Test search_element when element is not found after all retries"""
        # Arrange
        self.mock_driver.find_element.side_effect = NoSuchElementException("Element not found")

        # Act
        result = search_element("//some/xpath", retry_count=2)

        # Assert
        self.assertIsNone(result)
        self.assertEqual(self.mock_driver.find_element.call_count, 3)  # Initial + 2 retries
        self.assertEqual(self.mock_scroll_page_down.call_count, 3)

    def test_search_element_with_xpath_prefix(self):
        """Test search_element with xpath= prefix in selector"""
        # Arrange
        self.mock_driver.find_element.return_value = self.mock_element

        # Act
        result = search_element("xpath=//some/xpath")

        # Assert
        self.assertEqual(result, self.mock_element)
        self.mock_driver.find_element.assert_called_once_with(By.XPATH, "//some/xpath")

    def test_search_sub_elements_success(self):
        """Test search_sub_elements when elements are found"""
        # Arrange
        mock_elements = [MagicMock(), MagicMock()]
        self.mock_driver.find_elements.return_value = mock_elements

        # Act
        result = search_sub_elements("//some/xpath")

        # Assert
        self.assertEqual(result, mock_elements)
        self.mock_driver.find_elements.assert_called_once_with(By.XPATH, "//some/xpath")

    def test_search_sub_elements_with_xpath_prefix(self):
        """Test search_sub_elements with xpath= prefix in selector"""
        # Arrange
        mock_elements = [MagicMock(), MagicMock()]
        self.mock_driver.find_elements.return_value = mock_elements

        # Act
        result = search_sub_elements("xpath=//some/xpath")

        # Assert
        self.assertEqual(result, mock_elements)
        self.mock_driver.find_elements.assert_called_once_with(By.XPATH, "//some/xpath")

    def test_search_sub_elements_empty_result(self):
        """Test search_sub_elements when no elements are found"""
        # Arrange
        self.mock_driver.find_elements.return_value = []

        # Act
        result = search_sub_elements("//some/xpath")

        # Assert
        self.assertEqual(result, [])
        self.mock_driver.find_elements.assert_called_once_with(By.XPATH, "//some/xpath")

    def test_wait_until_element_exists_and_text_correct_success(self):
        """Test wait_until_element_exists_and_text_correct when text matches"""
        # Arrange
        with patch('elementHelperAppium.search_element') as mock_search_element:
            self.mock_element.text = "expected text"
            mock_search_element.return_value = self.mock_element

            # Act
            result = wait_until_element_exists_and_text_correct("//some/xpath", "expected text")

            # Assert
            self.assertTrue(result)
            mock_search_element.assert_called_once_with("//some/xpath")

    def test_wait_until_element_exists_and_text_correct_failure(self):
        """Test wait_until_element_exists_and_text_correct when text doesn't match"""
        # Arrange
        with patch('elementHelperAppium.search_element') as mock_search_element:
            self.mock_element.text = "wrong text"
            mock_search_element.return_value = self.mock_element

            # Act
            result = wait_until_element_exists_and_text_correct("//some/xpath", "expected text")

            # Assert
            self.assertFalse(result)
            mock_search_element.assert_called_once_with("//some/xpath")

    def test_wait_until_element_exists_and_text_correct_element_not_found(self):
        """Test wait_until_element_exists_and_text_correct when element is not found"""
        # Arrange
        with patch('elementHelperAppium.search_element') as mock_search_element:
            mock_search_element.return_value = None

            # Act
            result = wait_until_element_exists_and_text_correct("//some/xpath", "expected text")

            # Assert
            self.assertFalse(result)
            mock_search_element.assert_called_once_with("//some/xpath")

    def test_search_element_zero_retry_count(self):
        """Test search_element with retry_count=0"""
        # Arrange
        self.mock_driver.find_element.return_value = self.mock_element

        # Act
        result = search_element("//some/xpath", retry_count=0)

        # Assert
        self.assertEqual(result, self.mock_element)
        self.mock_driver.find_element.assert_called_once_with(By.XPATH, "//some/xpath")
        self.mock_scroll_page_down.assert_not_called()

    def test_search_element_zero_retry_count_not_found(self):
        """Test search_element with retry_count=0 when element is not found"""
        # Arrange
        self.mock_driver.find_element.side_effect = NoSuchElementException("Element not found")

        # Act
        result = search_element("//some/xpath", retry_count=0)

        # Assert
        self.assertIsNone(result)
        self.mock_driver.find_element.assert_called_once_with(By.XPATH, "//some/xpath")
        self.mock_scroll_page_down.assert_called_once_with(self.mock_driver)


if __name__ == '__main__':
    unittest.main()
