*** Settings ***
Library  SeleniumLibrary
Library  ExcelLibrary

*** Variables ***
${URL}  http://localhost:8081/SpringMVCProject/
${BROWSER}  chrome
${DataTableRegisterStudent}  ExcelProject/RegisterTutor.xlsx
${Sheet}  RegisterTutor
${Row}  22
${link_toregister}  //a[contains(text(),'สมัครเป็นติวเตอร์')]


${Loc_Email}  //input[@id='email_prefix']
${Loc_Password}  //input[@id='password']

${Btn_submit}  //input[@value='เข้าสู่ระบบ']

${screenshot}  screenshotRegisterTutor/