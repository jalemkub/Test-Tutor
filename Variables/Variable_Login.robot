*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
*** Variables ***
${URL}  http://localhost:8080/wep-tutor/
${BROWSER}  chrome
${DataTableLogin}  ExcelProject/Login.xlsx
${Sheet}  Login
${Row}  22
${link_tologin}  //a[contains(text(),'เข้าสู่ระบบ ▼')]
${Loc_Login}  //a[@href='goLogin']


${Loc_Email}  //input[@id='email_prefix']
${Loc_Password}  //input[@id='password']

${Btn_submit}  //input[@value='เข้าสู่ระบบ']


${Errorform}  //p[@class='error']
# ${success_form}  //p[contains(text(),'เข้าสู่ระบบสำเร็จ')]
${success_form}    body > div:nth-child(3) > div:nth-child(1) > p:nth-child(2)

${screenshot}  screenshotLogin/

# ${Btn_Logout}  //input[@value='ออกจากระบบ']


${SCREENSHOT_PATH}    C:\\Users\\jalem\\OneDrive\\Desktop\\Test_Tutor\\screenshotLogin\\IMG_Fail_${Row}.png
${img}=    pyautogui.screenshot(${SCREENSHOT_PATH})