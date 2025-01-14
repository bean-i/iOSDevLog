//
//  LottoData.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/14/25.
//

import Foundation

struct Lotto: Decodable {
    let drwNoDate: String
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
    let drwNo: Int
}
