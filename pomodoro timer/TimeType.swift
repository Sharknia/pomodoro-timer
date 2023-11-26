//
//  TimeType.swift
//  pomodoro timer
//
//  Created by 이한결 on 11/27/23.
//

import Foundation

enum TimerType: Int {
    case focus = 25
    case shortBreak = 5
    case longBreak = 20

    var minutes: Int {
        return self.rawValue
    }
}
