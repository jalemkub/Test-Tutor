*** Settings ***
Library    SeleniumLibrary
*** Variables ***
#website URL and Browser
${URL}    http://localhost:8080/SpringMVCProject/
${BROWSER}    chrome
${DataTableRegisterStudent}  ExcelProject/Register Student.xlsx
${Sheet}    RegisterStudent
${Loc_For_Register}  //a[contains(text(),'เข้าสู่ระบบ ▼')]
${Loc_RegisterStudent}  //a[contains(text(),'ลงทะเบียน')]
${LocImageFile}  ExcelProject/Images/
# screenshot
${screenshot}  ScreenshotsRegisterStudent/


#row Excel
${Row}  80

#Input Fill Locators
${LocStuID}  //input[@id='student_id']
${LocFName}  //input[@id='fname']
${LocLName}  //input[@id='lname']
${LocPhone}  //input[@id='phon_num']
${LocYear_of_Study}  //select[@name='yfs']
${LocEmail}  //input[@id='email_prefix']
${LocPassword}  //input[@id='password']
${LocBTTImage}  //input[@type="file"]
# ${LocBTTImage}  //input[@id='image']

#button register
${BtnRegister}  //input[@value='ลงทะเบียน']
# ${BtnRegister}  //input[@value='submit']


${textErrorID}  //span[@id='err_stu_id']
${textErrorEmail}  (//span[@id='err_email'])[1]
${textErrorFName}  //span[@id='err_fname']
${textErrorLName}  //span[@id='err_lname']
${textErrorPhone}  //span[@id='err_phone']
${textEmail}  id:err_email
${textErrorPassword}  //span[@id='err_password']
${textErrorImage}  //span[@id='err_image']
${textErrorYear}  //span[@id='err_yfs']
${error_form}  //p[@class='error']
${success_form}  //p[contains(text(),'ลงทะเบียนสำเร็จ! กรุณาเข้าสู่ระบบ')]

${SCREENSHOT_PATH}    C:\\Users\\jalem\\OneDrive\\Desktop\\Test_Tutor\\ScreenshotRegisterStudent\\IMG_Fail_${Row}.png
${img}=    pyautogui.screenshot(${SCREENSHOT_PATH})


