// baseUrl
const baseUrl = $(location).attr('protocol') + '//' + $(location).attr('host');

// 공백 확인
function checkBlank(value) {
    var blank_pattern = /[\s]/g;
    return blank_pattern.test(value);
}

// 전화번호 입력 시 하이픈 자동 추가, 숫자 확인
function autoHyphen(str) {
    str = str.replace(/[^0-9]/g, '');
    var tmp = '';

    if( str.length < 4){
        return str;
    }else if(str.length < 7){
        tmp += str.substr(0, 3);
        tmp += '-';
        tmp += str.substr(3);
        return tmp;
    }else if(str.length < 11){
        tmp += str.substr(0, 3);
        tmp += '-';
        tmp += str.substr(3, 3);
        tmp += '-';
        tmp += str.substr(6);
        return tmp;
    }else{
        tmp += str.substr(0, 3);
        tmp += '-';
        tmp += str.substr(3, 4);
        tmp += '-';
        tmp += str.substr(7);
        return tmp;
    }

    return str;
}

// 전화번호 형식 확인
function checkPhoneNum(value) {
    var phone_pattern = /^\d{3}-\d{3,4}-\d{4}$/;
    return phone_pattern.test(value);
}

// 이메일 형식 확인
function checkEmail(value) {
    var email_pattern = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    return email_pattern.test(value);
}

// 비밀번호 형식 확인
function checkPassword(value) {

    // 최소 8자, 최소 하나의 문자와 하나의 숫자 포함
    var pw_pattern = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
    // 최소 8자, 최소 하나의 문자와 숫자, 특수 문자 포함
    var pw_pattern2 = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;
    // 최소 8자, 최소 하나의 대문자, 소문자 포함
    var pw_pattern3 = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/;
    // 최소 8자, 최소 하나의 대문자, 소문자, 숫자, 특수 문자 포함
    var pw_pattern4 = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,}/;
    // 최소 6자 및 최대 12자, 최소 하나의 대문자, 소문자, 숫자, 특수문자 포함
    var pw_pattern5 = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{6,12}/;

    return pw_pattern2.test(value);
}

// 날짜 substring
function dateFormat(value) {
    return value.substr(0, 10);
}