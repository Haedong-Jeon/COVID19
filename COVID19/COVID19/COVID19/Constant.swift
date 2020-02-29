//
//  Constant.swift
//  COVID19
//
//  Created by 전해동 on 2020/02/29.
//  Copyright © 2020 전해동. All rights reserved.
//

import UIKit

class Constant {
    //오류 메시지
    static let locationPermissionDeniedAlertTitle = "위치 서비스"
    static let locationPermissionDeniedAlertMsg = "위치 서비스 사용을 허가해주세요."
    static let networkConnectionErrorTitle = "네트워크 연결 오류"
    static let networkConnectionErrorMsg = "네트워크가 불안정합니다."
    static let retry = "다시 시도"
    static let ok = "확인"
    static let menuCount = 4
    //메뉴 타이틀
    static let patientNumbByRegionMenu = "지역별 확진자 수"
    static let checkPatientLocationMenu = "확진자 방문지역 확인"
    static let orderMaskMenu = "마스크 주문하기"
    static let checkNews = "관련 뉴스 체크하기"
}

class Alert{
    enum TYPE{
        static let locationPermissionDenied = 1111
        static let networkConnectionError = 2222
        static let noAlert = 0
    }
}
