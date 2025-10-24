*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
*** Variables ***
${URL}  http://localhost:8080/SpringMVCProject/
${BROWSER}  chrome
${DataTableLogin}  ExcelProject/Login.xlsx
${Sheet}  Login
${Row}  22
${link_tologin}  //img[@alt='Login']


${Loc_Email}  //input[@id='email_prefix']
${Loc_Password}  //input[@id='password']

${Btn_submit}  //input[@value='เข้าสู่ระบบ']


${Errorform}  //p[@class='error']
# ${success_form}  //p[contains(text(),'เข้าสู่ระบบเรียบร้อย')]
${success_form}  '#resultLogin'
# ${success_form}  /html[1]/body[1]/div[2]/div[1]/p[1]

${screenshot}  screenshotLogin/

${Btn_Logout}  //input[@value='ออกจากระบบ']

# *** Settings ***
# Library    SeleniumLibrary
# Library    ExcelLibrary
# *** Variables ***
# ${URL}  http://localhost:8080/SpringMVCProject/
# ${BROWSER}  chrome
# ${DataTableLogin}  ExcelProject/Login.xlsx
# ${Sheet}  Login
# ${Row}  22
# ${link_tologin}  //img[@alt='Login']


# ${Loc_Email}  //input[@id='email_prefix']
# ${Loc_Password}  //input[@id='password']

# ${Btn_submit}  //input[@value='เข้าสู่ระบบ']


# ${Errorform}  //p[@class='error']
# # ${success_form}  //p[contains(text(),'เข้าสู่ระบบเรียบร้อย')]
# ${success_form}  '#resultLogin'
# # ${success_form}  /html[1]/body[1]/div[2]/div[1]/p[1]

# ${screenshot}  screenshotLogin/

# ${Btn_Logout}  //input[@value='ออกจากระบบ']