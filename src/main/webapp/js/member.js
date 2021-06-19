function toMemberRoll(memberRoll) {
    let memberRollName
    switch(memberRoll) {
        case "ROLE_ADMIN" :
            memberRollName = "관리자";
            break;
        case "ROLE_MEMBER" :
            memberRollName = "일반회원";
            break;
        default:
    }
    return memberRollName;
}