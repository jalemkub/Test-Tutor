*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary

*** Variables ***
${URL}  http://localhost:8080/wep-tutor/
${BROWSER}  chrome
${DataTableReportTutor}  ExcelProject/ReportTutor.xlsx
${Sheet}  ReportTutor
${Row}  11
${Loc_LoginMenu}    //a[contains(text(),'เข้าสู่ระบบ ▼')]
${Loc_gologin}    //a[@href='goLogin']


${Loc_Email}  //input[@id='email_prefix']
${Loc_Password}  //input[@id='password']

${Btn_submit}  //input[@value='เข้าสู่ระบบ']

${Stu_Menu}    //a[contains(text(),'นักศึกษา ▼')]
${My_RegisterCourse}    //a[contains(text(),'คอร์สที่ลงทะเบียน')]
${Descriptioncourse}  //a[contains(text(),'ดูรายละเอียด')]

${Report_Loc}    //a[@id='btnReport']
${Input_Report}    //textarea[@id='details']

${BTN_submitReport}   //input[@value='ส่งรายงาน']

${SCREENSHOT_PATH}    C:\\Users\\jalem\\OneDrive\\Desktop\\Test_Tutor\\screenshotReportTutor\\IMG_Fail_${Row}.png
${img}=    pyautogui.screenshot(${SCREENSHOT_PATH})

${Success_Message}   //p[@class='success-msg']

${Error_Message}    .error-msg
# ...    //p[@class='error-msg']