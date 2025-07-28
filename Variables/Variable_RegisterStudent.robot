*** Settings ***
Library    SeleniumLibrary
*** Variables ***
#website URL and Browser
${URL}    http://localhost:8081/SpringMVCProject/
${BROWSER}    chrome
${DataTableRegisterStudent}  ExcelProject/Register Student.xlsx
${Sheet}    RegisterStudent
${Loc_Register}  //img[@alt='Register']

# screenshot
${screenshot}  Screenshots/RegisterStudent/


#row Excel
${Row}  80

#Input Fill Locators
${LocStuID}  //input[@id='student_id']
${LocEmail}  //input[@id='email_prefix']
${LocFName}  //input[@id='fname']
${LocLName}  //input[@id='lname']
${LocPhone}  //input[@id='phon_num']
${LocBTTImage}  //input[@id='image']
${LocYear_of_Study}  //select[@name='yfs']
${LocPassword}  //input[@id='password']

#button register
${ButtonRegister}  //input[@value='ลงทะเบียน']

#Error Messages
${textErrorID}  //span[@id='err_stu_id']
${textErrorEmail}  (//span[@id='err_email'])[1]
${textErrorFName}  //span[@id='err_fname']
${textErrorLName}  //span[@id='err_lname']
${textErrorPhone}  //span[@id='err_phone']
${textErrorPassword}  //span[@id='err_password']
${textErrorImage}  css:#image
${textErrorYear}  css:select[name='yfs']