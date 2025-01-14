//
//  Date+Extension.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/14/25.
//

import Foundation

extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
}

extension Date {
    static let yesterday: Date = {
        guard let y = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            print("날짜 오류")
            return Date()
        }
        return y
    }()
    
    static func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter.dateFormatter
        formatter.dateFormat = "yyyyMMdd"
        return formatter.string(from: date)
    }
    
}
