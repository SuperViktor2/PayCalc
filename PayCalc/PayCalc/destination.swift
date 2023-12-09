//
//  destination.swift
//  PayCalc
//
//  Created by Viktor Goleš on 28.07.2023..
//

import Foundation

enum Destination: Hashable {
    case shift(Job)
    case addShift(Job, Shift? = nil)
}
