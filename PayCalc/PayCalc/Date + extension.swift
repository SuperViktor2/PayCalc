//
//  Date + extension.swift
//  PayCalc
//
//  Created by Viktor Goleš on 28.07.2023..
//

import Foundation

extension Date {
    var intOfMonth: Int? {
        Calendar.current.dateComponents([.month], from: self).month
    }
}
