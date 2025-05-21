import unittest
from unittest.mock import patch, MagicMock, call
import time
import subprocess
import os
import sys

# Import the module to test
from Resources.Utils.Mobile_Mgmt_Direct import (
    set_up_pixel9pro_api35,
    set_up_pixel9pro_api35_no_wait_for_login_screen,
    start_emulator_if_necessary,
    start_appium_if_necessary,
    wait_until_login_screen_is_ready,
    restart_application,
    appium_start_no_base_path_arg_allow_download_insecure_chrome_driver,
    appium_start_base_path_arg_allow_download_insecure_chrome_driver,
    emulator_start,
    open_application_tt_planer_on_google_pixel_9_with_reset,
    open_application_tt_planer_on_google_pixel_9,
    emulator_is_ready,
    setup_aut_pixel9pro_api35,
    setup_aut_pixel9pro_api35_no_wait_for_login_screen
)


class TestMobileMgmt(unittest.TestCase):
    """Test cases for Mobile_Mgmt.py functions."""

    @patch('Resources.Utils.Mobile_Mgmt.start_appium_if_necessary')
    @patch('Resources.Utils.Mobile_Mgmt.start_emulator_if_necessary')
    @patch('Resources.Utils.Mobile_Mgmt.initializeCurrentSession')
    @patch('Resources.Utils.Mobile_Mgmt.close_all_appium_sessions')
    @patch('Resources.Utils.Mobile_Mgmt.time.sleep')
    @patch('Resources.Utils.Mobile_Mgmt.open_application_tt_planer_on_google_pixel_9')
    @patch('Resources.Utils.Mobile_Mgmt.wait_until_login_screen_is_ready')
    def test_set_up_pixel9pro_api35(self, mock_wait, mock_open_app, mock_sleep, 
                                    mock_close_sessions, mock_init_session, 
                                    mock_start_emulator, mock_start_appium):
        """Test the set_up_pixel9pro_api35 function."""
        # Call the function
        set_up_pixel9pro_api35()
        
        # Assert that all the expected functions were called
        mock_start_appium.assert_called_once()
        mock_start_emulator.assert_called_once()
        mock_init_session.assert_called_once()
        mock_close_sessions.assert_called_once()
        mock_sleep.assert_called_once_with(1)
        mock_open_app.assert_called_once()
        mock_wait.assert_called_once()

    @patch('Resources.Utils.Mobile_Mgmt.start_appium_if_necessary')
    @patch('Resources.Utils.Mobile_Mgmt.start_emulator_if_necessary')
    @patch('Resources.Utils.Mobile_Mgmt.initializeCurrentSession')
    @patch('Resources.Utils.Mobile_Mgmt.close_all_appium_sessions')
    @patch('Resources.Utils.Mobile_Mgmt.time.sleep')
    @patch('Resources.Utils.Mobile_Mgmt.open_application_tt_planer_on_google_pixel_9')
    def test_set_up_pixel9pro_api35_no_wait_for_login_screen(self, mock_open_app, mock_sleep, 
                                                            mock_close_sessions, mock_init_session, 
                                                            mock_start_emulator, mock_start_appium):
        """Test the set_up_pixel9pro_api35_no_wait_for_login_screen function."""
        # Call the function
        set_up_pixel9pro_api35_no_wait_for_login_screen()
        
        # Assert that all the expected functions were called
        mock_start_appium.assert_called_once()
        mock_start_emulator.assert_called_once()
        mock_init_session.assert_called_once()
        mock_close_sessions.assert_called_once()
        mock_sleep.assert_called_once_with(1)
        mock_open_app.assert_called_once()

    @patch('Resources.Utils.Mobile_Mgmt.window_exists')
    @patch('Resources.Utils.Mobile_Mgmt.emulator_start')
    @patch('Resources.Utils.Mobile_Mgmt.emulator_is_ready')
    @patch('Resources.Utils.Mobile_Mgmt.time.sleep')
    @patch('Resources.Utils.Mobile_Mgmt.setwindowtopos')
    def test_start_emulator_if_necessary_when_exists(self, mock_setwindowtopos, mock_sleep, 
                                                   mock_emulator_is_ready, mock_emulator_start, 
                                                   mock_window_exists):
        """Test start_emulator_if_necessary when emulator window already exists."""
        # Setup
        mock_window_exists.return_value = True
        
        # Call the function
        start_emulator_if_necessary()
        
        # Assert
        mock_window_exists.assert_called_once_with("Android Emulator - Pixel9Pro_API35:5554")
        mock_emulator_start.assert_not_called()
        mock_emulator_is_ready.assert_not_called()
        mock_setwindowtopos.assert_has_calls([
            call("-avd", 1350, 1120, 1330, 250),
            call("Android Emulator - Pixel9Pro_API35:5554", 2730, 130)
        ])

    @patch('Resources.Utils.Mobile_Mgmt.window_exists')
    @patch('Resources.Utils.Mobile_Mgmt.emulator_start')
    @patch('Resources.Utils.Mobile_Mgmt.emulator_is_ready')
    @patch('Resources.Utils.Mobile_Mgmt.time.sleep')
    @patch('Resources.Utils.Mobile_Mgmt.setwindowtopos')
    def test_start_emulator_if_necessary_when_not_exists(self, mock_setwindowtopos, mock_sleep, 
                                                       mock_emulator_is_ready, mock_emulator_start, 
                                                       mock_window_exists):
        """Test start_emulator_if_necessary when emulator window does not exist."""
        # Setup
        mock_window_exists.return_value = False
        mock_emulator_is_ready.return_value = True
        
        # Call the function
        start_emulator_if_necessary()
        
        # Assert
        mock_window_exists.assert_called_once_with("Android Emulator - Pixel9Pro_API35:5554")
        mock_emulator_start.assert_called_once_with("Pixel9Pro_API35")
        mock_emulator_is_ready.assert_called_once()
        mock_setwindowtopos.assert_has_calls([
            call("-avd", 1350, 1120, 1330, 250),
            call("Android Emulator - Pixel9Pro_API35:5554", 2730, 130)
        ])

    @patch('Resources.Utils.Mobile_Mgmt.window_exists')
    @patch('Resources.Utils.Mobile_Mgmt.appium_start_no_base_path_arg_allow_download_insecure_chrome_driver')
    @patch('Resources.Utils.Mobile_Mgmt.time.sleep')
    @patch('Resources.Utils.Mobile_Mgmt.setwindowtopos')
    def test_start_appium_if_necessary_when_exists(self, mock_setwindowtopos, mock_sleep, 
                                                 mock_appium_start, mock_window_exists):
        """Test start_appium_if_necessary when Appium window already exists."""
        # Setup
        mock_window_exists.return_value = True
        
        # Call the function
        start_appium_if_necessary()
        
        # Assert
        mock_window_exists.assert_called_once_with("appium")
        mock_appium_start.assert_not_called()
        mock_setwindowtopos.assert_called_once_with("appium", 10, 1120, 1330, 250)

    @patch('Resources.Utils.Mobile_Mgmt.window_exists')
    @patch('Resources.Utils.Mobile_Mgmt.appium_start_no_base_path_arg_allow_download_insecure_chrome_driver')
    @patch('Resources.Utils.Mobile_Mgmt.time.sleep')
    @patch('Resources.Utils.Mobile_Mgmt.setwindowtopos')
    def test_start_appium_if_necessary_when_not_exists(self, mock_setwindowtopos, mock_sleep, 
                                                     mock_appium_start, mock_window_exists):
        """Test start_appium_if_necessary when Appium window does not exist."""
        # Setup
        mock_window_exists.return_value = False
        
        # Call the function
        start_appium_if_necessary()
        
        # Assert
        mock_window_exists.assert_called_once_with("appium")
        mock_appium_start.assert_called_once()
        mock_sleep.assert_called_once_with(1)
        mock_setwindowtopos.assert_called_once_with("appium", 10, 1120, 1330, 250)

    @patch('Resources.Utils.Mobile_Mgmt.BuiltIn')
    @patch('Resources.Utils.Mobile_Mgmt.scroll_to_top')
    def test_wait_until_login_screen_is_ready_success(self, mock_scroll_to_top, mock_builtin):
        """Test wait_until_login_screen_is_ready when login button is found."""
        # Setup mock AppiumLibrary
        mock_appium_lib = MagicMock()
        mock_builtin.return_value.get_library_instance.return_value = mock_appium_lib
        
        # Call the function
        wait_until_login_screen_is_ready()
        
        # Assert
        mock_builtin.return_value.get_library_instance.assert_called_once_with('AppiumLibrary')
        mock_scroll_to_top.assert_called_once()
        mock_appium_lib.wait_until_element_is_visible.assert_has_calls([
            call('xpath=//android.widget.TextView[@text=""]', timeout='10s'),
            call('xpath=//android.widget.Button[@text="Einloggen"]', timeout='10s')
        ])
        mock_appium_lib.click_element.assert_called_once_with('xpath=//android.widget.TextView[@text=""]')

    @patch('Resources.Utils.Mobile_Mgmt.BuiltIn')
    @patch('Resources.Utils.Mobile_Mgmt.scroll_to_top')
    @patch('Resources.Utils.Mobile_Mgmt.restart_application')
    def test_wait_until_login_screen_is_ready_login_button_not_found(self, mock_restart, mock_scroll_to_top, mock_builtin):
        """Test wait_until_login_screen_is_ready when login button is not found."""
        # Setup mock AppiumLibrary
        mock_appium_lib = MagicMock()
        mock_builtin.return_value.get_library_instance.return_value = mock_appium_lib
        
        # Make the second wait_until_element_is_visible call raise an exception
        mock_appium_lib.wait_until_element_is_visible.side_effect = [None, Exception("Element not found")]
        
        # Call the function
        wait_until_login_screen_is_ready()
        
        # Assert
        mock_restart.assert_called_once()

    @patch('Resources.Utils.Mobile_Mgmt.BuiltIn')
    def test_restart_application(self, mock_builtin):
        """Test restart_application function."""
        # Setup mock AppiumLibrary
        mock_appium_lib = MagicMock()
        mock_builtin.return_value.get_library_instance.return_value = mock_appium_lib
        
        # Call the function
        restart_application()
        
        # Assert
        mock_builtin.return_value.get_library_instance.assert_called_once_with('AppiumLibrary')
        mock_appium_lib.close_application.assert_called_once()
        mock_appium_lib.wait_until_element_is_visible.assert_called_once_with(
            'xpath=//android.widget.Button[@text="Einloggen"]', timeout='10s'
        )

    @patch('Resources.Utils.Mobile_Mgmt.subprocess.run')
    @patch('Resources.Utils.Mobile_Mgmt.logger.info')
    def test_appium_start_no_base_path_arg_allow_download_insecure_chrome_driver(self, mock_logger, mock_run):
        """Test appium_start_no_base_path_arg_allow_download_insecure_chrome_driver function."""
        # Call the function
        appium_start_no_base_path_arg_allow_download_insecure_chrome_driver()
        
        # Assert
        mock_run.assert_called_once()
        mock_logger.assert_called_once_with("Appium Server gestartet")

    @patch('Resources.Utils.Mobile_Mgmt.subprocess.run')
    @patch('Resources.Utils.Mobile_Mgmt.logger.info')
    def test_appium_start_base_path_arg_allow_download_insecure_chrome_driver(self, mock_logger, mock_run):
        """Test appium_start_base_path_arg_allow_download_insecure_chrome_driver function."""
        # Call the function
        appium_start_base_path_arg_allow_download_insecure_chrome_driver()
        
        # Assert
        mock_run.assert_called_once()
        mock_logger.assert_called_once_with("Appium Server gestartet")

    @patch('Resources.Utils.Mobile_Mgmt.subprocess.run')
    @patch('Resources.Utils.Mobile_Mgmt.logger.info')
    def test_emulator_start(self, mock_logger, mock_run):
        """Test emulator_start function."""
        # Call the function
        emulator_start("TestEmulator")
        
        # Assert
        mock_run.assert_called_once()
        mock_logger.assert_called_once_with("Emulator gestartet")

    @patch('Resources.Utils.Mobile_Mgmt.BuiltIn')
    @patch('Resources.Utils.Mobile_Mgmt.logger.info')
    def test_open_application_tt_planer_on_google_pixel_9_with_reset(self, mock_logger, mock_builtin):
        """Test open_application_tt_planer_on_google_pixel_9_with_reset function."""
        # Setup mock AppiumLibrary
        mock_appium_lib = MagicMock()
        mock_builtin.return_value.get_library_instance.return_value = mock_appium_lib
        mock_appium_lib.open_application.return_value = "app_id_123"
        
        # Call the function
        open_application_tt_planer_on_google_pixel_9_with_reset()
        
        # Assert
        mock_builtin.return_value.get_library_instance.assert_called_once_with('AppiumLibrary')
        mock_appium_lib.open_application.assert_called_once()
        mock_logger.assert_called_once_with("app_id_123")

    @patch('Resources.Utils.Mobile_Mgmt.BuiltIn')
    def test_open_application_tt_planer_on_google_pixel_9(self, mock_builtin):
        """Test open_application_tt_planer_on_google_pixel_9 function."""
        # Setup mock AppiumLibrary
        mock_appium_lib = MagicMock()
        mock_builtin.return_value.get_library_instance.return_value = mock_appium_lib
        
        # Call the function
        open_application_tt_planer_on_google_pixel_9()
        
        # Assert
        mock_builtin.return_value.get_library_instance.assert_called_once_with('AppiumLibrary')
        mock_appium_lib.open_application.assert_called_once()

    @patch('Resources.Utils.Mobile_Mgmt.subprocess.run')
    def test_emulator_is_ready_true(self, mock_run):
        """Test emulator_is_ready function when emulator is ready."""
        # Setup
        mock_process = MagicMock()
        mock_process.stdout = "1\n"
        mock_run.return_value = mock_process
        
        # Call the function
        result = emulator_is_ready()
        
        # Assert
        self.assertTrue(result)
        mock_run.assert_called_once_with(
            ["adb", "shell", "getprop", "sys.boot_completed"],
            capture_output=True,
            text=True
        )

    @patch('Resources.Utils.Mobile_Mgmt.subprocess.run')
    def test_emulator_is_ready_false(self, mock_run):
        """Test emulator_is_ready function when emulator is not ready."""
        # Setup
        mock_process = MagicMock()
        mock_process.stdout = "0\n"
        mock_run.return_value = mock_process
        
        # Call the function
        result = emulator_is_ready()
        
        # Assert
        self.assertFalse(result)
        mock_run.assert_called_once_with(
            ["adb", "shell", "getprop", "sys.boot_completed"],
            capture_output=True,
            text=True
        )

    @patch('Resources.Utils.Mobile_Mgmt.set_up_pixel9pro_api35')
    @patch('Resources.Utils.Mobile_Mgmt.InitializeVariableStorage')
    @patch('Resources.Utils.Mobile_Mgmt.SetVariableValue')
    def test_setup_aut_pixel9pro_api35(self, mock_set_var, mock_init_var, mock_setup):
        """Test setup_aut_pixel9pro_api35 function."""
        # Call the function
        setup_aut_pixel9pro_api35()
        
        # Assert
        mock_setup.assert_called_once()
        mock_init_var.assert_called_once()
        mock_set_var.assert_called_once_with("AUT", "Pixel9Pro_API35")

    @patch('Resources.Utils.Mobile_Mgmt.set_up_pixel9pro_api35_no_wait_for_login_screen')
    @patch('Resources.Utils.Mobile_Mgmt.InitializeVariableStorage')
    @patch('Resources.Utils.Mobile_Mgmt.SetVariableValue')
    def test_setup_aut_pixel9pro_api35_no_wait_for_login_screen(self, mock_set_var, mock_init_var, mock_setup):
        """Test setup_aut_pixel9pro_api35_no_wait_for_login_screen function."""
        # Call the function
        setup_aut_pixel9pro_api35_no_wait_for_login_screen()
        
        # Assert
        mock_setup.assert_called_once()
        mock_init_var.assert_called_once()
        mock_set_var.assert_called_once_with("AUT", "Pixel9Pro_API35")


if __name__ == '__main__':
    unittest.main()