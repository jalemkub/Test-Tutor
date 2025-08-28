*** Settings ***
Library  SeleniumLibrary
Library  ExcelLibrary

*** Variables ***
${URL}  http://localhost:8081/SpringMVCProject/
${BROWSER}  chrome
${DataTableRegisterTutor}  ExcelProject/Register Tutor .xlsx
${Sheet}  RegisterTutor
${Row}  21


# Login
${Loc_Email}  //input[@id='email_prefix']
${Loc_Password}  //input[@id='password']
${Btn_submit}  //input[@value='เข้าสู่ระบบ']
${link_tologin}  //img[@alt='Login']

# Screenshot
${screenshot}  screenshotRegisterTutor/

#Error form
${Errorform}  //p[contains(text(),'ไม่สามารถบันทึกได้')]


# Register Tutor
${link_toregister}  //a[contains(text(),'สมัครเป็นติวเตอร์')]
${Loc_TypeSubject}  id:skill1
${Loc_Experience}  //textarea[@id='expertise']
${Btn_Cancel}  //input[@value='ยกเลิก']
${Btn_Register}  //input[@value='ลงทะเบียน']
${Loc_SuccessMessage}  //div[contains(text(),'ลงทะเบียนสำเร็จ')]