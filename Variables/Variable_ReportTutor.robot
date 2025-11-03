*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary

*** Variables ***
${URL}  http://localhost:8080/SpringMVCProject/
${BROWSER}  chrome
${DataTableReportTutor}  ExcelProject/ReportTutor.xlsx
${Sheet}  ReportTutor
${Row}  11
${link_tologin}  //img[@alt='Login']


${Loc_Email}  //input[@id='email_prefix']
${Loc_Password}  //input[@id='password']

${Btn_submit}  //input[@value='เข้าสู่ระบบ']

${MycourseLink}  //a[contains(text(),'คอร์สที่ลงทะเบียน')]
${Descriptioncourse}  //a[contains(text(),'ดูรายละเอียด')]
${Report_Loc}    //a[contains(text(),'รายงานผู้สอน')]
${Input_Report}    //textarea[@id='details']

${BTN_submitReport}   //input[@value='ส่งรายงาน']

${SCREENSHOT_PATH}    C:\\Users\\jalem\\OneDrive\\Desktop\\Test_Tutor\\ScreenshotReportTutor\\IMG_Fail_${Row}.png
${img}=    pyautogui.screenshot(${SCREENSHOT_PATH})

${Success_Message}   //p[@class='success-msg']