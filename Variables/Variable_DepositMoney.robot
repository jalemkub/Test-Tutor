*** Settings ***
Library  SeleniumLibrary
Library  ExcelLibrary
Library    pyautogui
*** Variables ***
${URL}  http://localhost:8080/wep-tutor/
${BROWSER}  chrome
${DataTableDeposit}  ExcelProject/Deposit_Money.xlsx
${Sheet}  DepositMoney
${Row}  7

${Loc_MenuLogin}  //a[contains(text(),'เข้าสู่ระบบ ▼')]
${Loc_goLogin}    //a[@href='goLogin']

# login locators
${Loc_Email}  //input[@id='email_prefix']
${Loc_Password}  //input[@id='password']
${Btn_submit}  //input[@value='เข้าสู่ระบบ']


# deposit money locators
${Loc_Deposit_Menu}    //a[contains(text(),'จัดการเงิน ▼')]
${Loc_Deposit}    //a[contains(text(),'ฝากเงิน')]
${Loc_Input_DepositAmount}    //input[@id='amount']
${Loc_gen_QR}    //input[@value='สร้าง QR Code']


# capture screenshot location
${SCREENSHOT_PATH}    C:\\Users\\jalem\\OneDrive\\Desktop\\Test_Tutor\\ScreenshotDepositMoney\\IMG_Fail_${Row}.png
${img}=    pyautogui.screenshot(${SCREENSHOT_PATH})


#Omise Locin
${Loc_Brownser_omi}    https://sso-idp.omise.co/realms/engagement/protocol/openid-connect/auth?client_id=dashboard&redirect_uri=https%3A%2F%2Fdashboard.omise.co%2Fv2%2Fcharges&state=92afcb05-3ef8-46df-9344-cf184229c2f3&response_mode=fragment&response_type=code&scope=openid&nonce=ded86da2-6df3-41b2-81d0-064e8c010896&ui_locales=th&code_challenge=SsxgXQ8UMrI15jhZ8N7qYMmoleQfBniWZgQW6IrPiuo&code_challenge_method=S256
${Loc_UserOmi}    //input[@id='username']
${Loc_PassOmi}    //input[@id='password']
${Btn_LocOmi}    //input[@id='kc-login']
${OmiUser}    jalem091807@gmail.com
${OmiPass}    Jalem4544471@

# ${Loc_Statment}    //a[normalize-space()='Charges']
${Loc_Pending}    xpath=//a[contains(@href,'/v2/charges/chrg_test_')]
${Loc_ClickTest}    (//button[contains(text(),'Testing')])[1]
${Pay_sucess}    //span[normalize-space()='Mark as paid']
# ${Loc_Pending}    xpath=(//a[starts-with(@href,'/v2/charges/chrg_test_')])[1]


# ${Loc_Pending}    a[href^='/v2/charges/chrg_test_']
# Loc_Pending

