//
//  ViewSetting.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/14/25.
//

import Foundation

protocol ViewSetting: AnyObject {
    func setHierarchy() // addSubView
    func setLayout() // snapKit
    func setView() // property
}
