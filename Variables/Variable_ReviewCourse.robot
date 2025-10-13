*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary

*** Variables ***
${URL}  http://localhost:8080/SpringMVCProject/
${BROWSER}  chrome
${DataTableReviewCourse}  ExcelProject/ReviewCourse.xlsx
${Sheet}  Review Course
${Row}  17
${link_tologin}  //img[@alt='Login']


${Loc_Email}  //input[@id='email_prefix']
${Loc_Password}  //input[@id='password']

${Btn_submit}  //input[@value='เข้าสู่ระบบ']

${my courseLink}  //a[contains(text(),'คอร์สที่ลงทะเบียน')]
${Descriptioncourse}  //a[contains(text(),'ดูรายละเอียด')]
${Btn_Review}  //a[contains(text(),'รีวิวคอร์ส')]


${Stars5}    //label[@for='score1']
${Stars4}    //label[@for='score2']
${Stars3}    //label[@for='score3']
${Stars2}    //label[@for='score4']
${Stars1}    //label[@for='score5']



${CommentText}  //textarea[@id='comment']

${SendReview}  //button[contains(text(),'ส่งรีวิว')]


${SuccessMessage}    //p[@class='result_message']