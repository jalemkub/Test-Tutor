*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
*** Variables ***
${URL}  http://localhost:8081/SpringMVCProject/
${BROWSER}  chrome
${DataTableLoginAdmin}  ExcelProject/LoginAdmin.xlsx
${Sheet}  LoginAdmin
${Row}  22
${link_tologin}  //img[@alt='Login']


${Loc_EmailAM}  //input[@id='email_prefix']
${Loc_PasswordAM}  //input[@id='password']

${Btn_submit}  //input[@value='เข้าสู่ระบบ']
${Errorform}  //p[@class='error']
${success_form}  //p[contains(text(),'เข้าสู่ระบบเรียบร้อย')]
${screenshot}  screenshotLoginAdmin/