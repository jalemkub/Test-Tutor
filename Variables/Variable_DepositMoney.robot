*** Settings ***
Library  SeleniumLibrary
Library  ExcelLibrary
Library    pyautogui
*** Variables ***
${URL}  http://localhost:8080/SpringMVCProject/
${BROWSER}  chrome
${DataTableDeposit}  ExcelProject/Deposit_Money.xlsx
${Sheet}  DepositMoney
${Row}  7
${link_tologin}  //img[@alt='Login']

# login locators
${Loc_Email}  //input[@id='email_prefix']
${Loc_Password}  //input[@id='password']
${Btn_submit}  //input[@value='เข้าสู่ระบบ']


# deposit money locators
${link_deposit}    //a[contains(text(),'ฝากเงิน')]
${Loc_Input_DepositAmount}    //input[@id='amount']
${Loc_gen_QR}    //input[@value='สร้าง QR Code']


# capture screenshot location
${SCREENSHOT_PATH}    C:\\Users\\jalem\\OneDrive\\Desktop\\Test_Tutor\\screenshotDepositMoney\\alert_${Row}.png
${img}=    pyautogui.screenshot(${SCREENSHOT_PATH})
