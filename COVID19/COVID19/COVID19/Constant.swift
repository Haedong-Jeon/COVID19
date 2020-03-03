//
//  Constant.swift
//  COVID19
//
//  Created by 전해동 on 2020/02/29.
//  Copyright © 2020 전해동. All rights reserved.
//

import UIKit

struct Constant{
    //오류 메시지
    static let locationPermissionDeniedAlertTitle = "위치 서비스"
    static let locationPermissionDeniedAlertMsg = "위치 서비스 사용을 허가해주세요."
    static let networkConnectionErrorTitle = "네트워크 연결 오류"
    static let networkConnectionErrorMsg = "네트워크가 불안정합니다."
    static let retry = "다시 시도"
    static let ok = "확인"
    static let cancel = "취소"
    static let menuCount = 4
    //메뉴 타이틀
    static let patientNumbByRegionMenu = "지역별 확진자 수"
    static let checkPatientLocationMenu = "확진자 방문지역 확인"
    static let orderMaskMenu = "마스크 주문하기"
    static let checkNews = "관련 뉴스 체크하기"
    //쇼핑 url
    static let shoppingURL =  "https://www.google.com/search?hl=ko&tbm=shop&sxsrf=ALeKk03lPCfUvNAePtti0rnfiQ3Vmb0rig%3A1583194863849&ei=76JdXqaxM-izmAWA2qjIDg&q=KF80+%EB%A7%88%EC%8A%A4%ED%81%AC&oq=KF80+%EB%A7%88%EC%8A%A4%ED%81%AC&gs_l=psy-ab-sh.3..0l10.18503.19535.0.19873.5.5.0.0.0.0.155.281.0j2.2.0....0...1c.1.64.psy-ab-sh..3.2.280...0i7i30k1.0.seNrzPqTsBQ"
}

struct Alert{
    enum TYPE{
        static let locationPermissionDenied = 1111
        static let locationPermissionNotDetermined = 2222
        static let networkConnectionError = 3333
        static let noAlert = 0
    }
}

struct Region{
    static let cities:Array<String> = ["서울", "부산", "대구", "인천", "광주", "대전", "울산", "세종", "경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주"]
}

struct NumOfPatient{
    static var patientNum:Array<String> = ["","","","","","","","","","","","","","","","",""]
}
