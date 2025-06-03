"""
UiAutomator2 Monitoring Dashboard Module

This module provides a web-based monitoring dashboard for the UiAutomator2 server.
It allows monitoring the status of the UiAutomator2 server, active Appium sessions,
and other relevant information through a simple HTTP server.

Usage:
    from Resources.Utils.UiAutomator2MonitoringDashboard import start_monitoring_dashboard
    
    # Start the monitoring dashboard
    start_monitoring_dashboard()
"""

import json
import logging
import threading
import time
from http.server import HTTPServer, BaseHTTPRequestHandler

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class MonitorHandler(BaseHTTPRequestHandler):
    """
    HTTP request handler for the UiAutomator2 monitoring dashboard.
    """
    def do_GET(self):
        """
        Handle GET requests to the monitoring dashboard.
        
        Supported endpoints:
        - /status: Returns the current status of the UiAutomator2 server and Appium sessions
        """
        if self.path == '/status':
            # Get UiAutomator2 status
            uia2_status = self.server.driver_singleton.check_uiautomator2_server_status()
            uia2_process = self.server.driver_singleton.check_uiautomator2_process()
            
            # Get Appium session info
            sessions = self.server.driver_singleton.get_sessions()
            
            status_data = {
                'uiautomator2_server': 'Running' if uia2_status else 'Not responding',
                'uiautomator2_process': 'Running' if uia2_process else 'Not running',
                'appium_sessions': len(sessions),
                'session_ids': [s['id'] for s in sessions],
                'timestamp': time.strftime('%Y-%m-%d %H:%M:%S')
            }
            
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            self.wfile.write(json.dumps(status_data).encode())
        else:
            self.send_response(404)
            self.end_headers()

def start_monitoring_dashboard(driver_singleton, port=8080):
    """
    Start a simple web server to monitor UiAutomator2 server status.
    
    Args:
        driver_singleton: An instance of DriverSingleton
        port (int): Port for the monitoring dashboard (default: 8080)
    """
    def _run_server():
        server = HTTPServer(('localhost', port), MonitorHandler)
        server.driver_singleton = driver_singleton
        logger.info(f"UiAutomator2 monitoring dashboard started at http://localhost:{port}/status")
        server.serve_forever()
    
    # Start server in a background thread
    server_thread = threading.Thread(target=_run_server, daemon=True)
    server_thread.start()
    
    return server_thread

# Convenience function to get the DriverSingleton instance and start the dashboard
def start_dashboard(port=8080):
    """
    Convenience function to start the monitoring dashboard.
    
    This function gets the DriverSingleton instance and starts the monitoring dashboard.
    
    Args:
        port (int): Port for the monitoring dashboard (default: 8080)
    """
    from Resources.Utils.DriverSingleton import DriverSingleton
    
    # Get the DriverSingleton instance
    driver_singleton = DriverSingleton()
    
    # Start the monitoring dashboard
    return start_monitoring_dashboard(driver_singleton, port)