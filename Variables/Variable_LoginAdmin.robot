*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
*** Variables ***
${URL}  http://localhost:8080/wep-tutor/
${BROWSER}  chrome
${DataTableLoginAdmin}  ExcelProject/LoginAdmin.xlsx
${Sheet}  LoginAdmin
${Row}  22
${link_tologin}  //a[contains(text(),'เข้าสู่ระบบ ▼')]
${Loc_Login}  //a[@href='goLogin']


${Loc_EmailAM}  //input[@id='email_prefix']
${Loc_PasswordAM}  //input[@id='password']

${Btn_submit}  //input[@value='เข้าสู่ระบบ']
${Errorform}  //p[@class='error']
${success_form}  //p[@id='resultReview']
${screenshot}  screenshotLoginAdmin/

# ${success_form}  '#resultLogin'

${SCREENSHOT_PATH}    C:\\Users\\jalem\\OneDrive\\Desktop\\Test_Tutor\\screenshotLoginAdmin\\IMG_Fail_${Row}.png
${img}=    pyautogui.screenshot(${SCREENSHOT_PATH})