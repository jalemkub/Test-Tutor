*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    pyautogui
*** Variables ***
#Data and Browser
${URL}    http://localhost:8080/wep-tutor/
${BROWSER}    Chrome
${DataTableRequestWithdraw}  ExcelProject/RequestWithdraw.xlsx
${Sheet}    RequestWithdraw
${Row}    17

#Login
${Loc_tologinmenu}  //a[contains(text(),'เข้าสู่ระบบ ▼')]
${Loc_tologin}  //a[@href='goLogin']
${Loc_Email}  //input[@id='email_prefix']
${Loc_Password}  //input[@id='password']
${Btn_submit}  //input[@value='เข้าสู่ระบบ']

# RequestWithdraw
${Loc_PathMenu}    //a[contains(text(),'จัดการเงิน ▼')]
${Loc_PathRequestWithdraw}    //a[contains(text(),'ถอนเงิน')]

#Form RequestWithdraw
${SubjectCategory}    //select[@id='bankType']
${AccountNumber}    id:bankAccount
${AmountWithdraw}    id:amount
${BTN_RequestWithdraw}    //input[@value='ยืนยันการถอนเงิน']

#Capture screenshot 
${SCREENSHOT_PATH}    C:\\Users\\jalem\\OneDrive\\Desktop\\Test_Tutor\\screenshotRequestWithdraw\\IMG_Fail_${Row}.png
${img}=    pyautogui.screenshot(${SCREENSHOT_PATH})


#Success Message
${Loc_success}    //p[@class='success']