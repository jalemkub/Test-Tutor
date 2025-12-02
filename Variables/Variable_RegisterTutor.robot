*** Settings ***
Library  SeleniumLibrary
Library  ExcelLibrary

*** Variables ***
${URL}  http://localhost:8080/wep-tutor/
${BROWSER}  chrome
${DataTableRegisterTutor}  ExcelProject/RegisterTutor.xlsx
${Sheet}  RegisterTutor
${Row}  21


# Login
${Loc_Email}  //input[@id='email_prefix']
${Loc_Password}  //input[@id='password']
${Btn_submit}  //input[@value='เข้าสู่ระบบ']
${Loc_LoginMenu}  //a[contains(text(),'เข้าสู่ระบบ ▼')]
${Loc_gologin}  //a[@href='goLogin']
# Screenshot
${screenshot}  screenshot_RegisterTutor/

#Error form
${Errorform1}    //p[@id='skillError']
${Errorform2}    //p[@id='expertiseError']
${Errorform3}    //p[@class='error']

# Register Tutor
${link_toregister}  //a[contains(text(),'สมัครเป็นติวเตอร์')]
${Loc_TypeSubject}  id:skill1
${Loc_Experience}  //textarea[@id='expertise']
${Btn_Cancel}  //input[@value='ยกเลิก']
${Btn_Register}  //input[@value='ลงทะเบียน']
# ${Loc_SuccessMessage}    //p[contains(text(),'ลงทะเบียนติวเตอร์สำเร็จ')]
${Loc_Success}    (//p[contains(text(),'ลงทะเบียนติวเตอร์สำเร็จ')])[1]
# ${Loc_SuccessMessage}    div[class='content-container'] p:nth-child(2)

# Logout
${Btn_Logout}  //input[@value='ออกจากระบบ']

# ${SCREENSHOT_PATH}    C:\\Users\\jalem\\OneDrive\\Desktop\\Test_Tutor\\screenshotReTutor\\IMG_Fail_${Row}.png
# ${img}=    pyautogui.screenshot(${SCREENSHOT_PATH})