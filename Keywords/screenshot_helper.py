# screenshot_helper.py
import pyautogui
import os
# from datetime import datetime

def capture_alert_screenshot(row):
    """
    Capture a full-screen screenshot and save it to the screenshotDepositMoney folder.
    File will be named alert_<row>_<timestamp>.png
    """
    folder = os.path.join(os.getcwd(), "screenshotDepositMoney")
    os.makedirs(folder, exist_ok=True)
    
    # timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    excelrow = row - 1
    path = os.path.join(folder, f"alert_{excelrow}.png")

    pyautogui.screenshot(path)
    print(f"[INFO] Screenshot saved: {path}")
    return path
