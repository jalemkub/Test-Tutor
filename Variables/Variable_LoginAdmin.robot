*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
*** Variables ***
${URL}  http://localhost:8081/SpringMVCProject/
${BROWSER}  chrome
${DataTableRegisterStudent}  ExcelProject/LoginAdmin.xlsx
${Sheet}  LoginAdmin

${link_tologin}  //img[@alt='Login']


${Loc_EmailAM}  //input[@id='email_prefix']
${Loc_PasswordAM}  //input[@id='password']

${Btn_submit}  //input[@value='เข้าสู่ระบบ']

${TxtError}  //p[@class='error']