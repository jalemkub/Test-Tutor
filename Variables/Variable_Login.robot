*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
*** Variables ***
${URL}  http://localhost:8081/SpringMVCProject/
${BROWSER}  chrome
${DataTableRegisterStudent}  ExcelProject/Login.xlsx
${Sheet}  Login

${link_tologin}  //img[@alt='Login']


${Loc_Email}  //input[@id='email_prefix']
${Loc_Password}  //input[@id='password']

${Btn_submit}  //input[@value='เข้าสู่ระบบ']

${TXtError}  //p[@class='error']