*** Settings ***
Library    SeleniumLibrary
*** Variables ***
#website URL and Browser
${URL}    http://localhost:8081/SpringMVCProject/
${BROWSER}    chrome
${DataTableRegisterStudent}  ExcelProject/Register Student.xlsx
${Sheet}    RegisterStudent
${Loc_Register}  //img[@alt='Register']
${LocImageFile}  ExcelProject/Images/
# screenshot
${screenshot}  ScreenshotsRegisterStudent/


#row Excel
${Row}  9

#Input Fill Locators
${LocStuID}  //input[@id='student_id']
${LocFName}  //input[@id='fname']
${LocLName}  //input[@id='lname']
${LocPhone}  //input[@id='phon_num']
${LocYear_of_Study}  //select[@name='yfs']
${LocEmail}  //input[@id='email_prefix']
${LocPassword}  //input[@id='password']
${LocBTTImage}  //input[@type="file"]

#button register
${BtnRegister}  //input[@value='ลงทะเบียน']

#Error Messages
${textErrorID}  //span[@id='err_stu_id']
${textErrorEmail}  (//span[@id='err_email'])[1]
${textErrorFName}  //span[@id='err_fname']
${textErrorLName}  //span[@id='err_lname']
${textErrorPhone}  //span[@id='err_phone']
${textErrorPassword}  //span[@id='err_password']
${textErrorImage}  //span[@id='err_image']
${textErrorYear}  //option[contains(text(),'-- เลือกชั้นปี --')]