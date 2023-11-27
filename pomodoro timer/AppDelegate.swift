//
//  AppDelegate.swift
//  pomodoro timer
//
//  Created by 이한결 on 11/27/23.
//

import Foundation
import SwiftUI
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var timerManager = TimerManager.shared // 싱글턴 인스턴스 사용

    func applicationDidFinishLaunching(_ notification: Notification) {
        
        // 메뉴 바 아이템 생성
        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        // 타이머 초기화 및 업데이트
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.updateMenuBar()
        }
        
        timerManager.onTimerUpdate = { [weak self] in
            self?.updateMenuBar()
        }
    }

    func updateMenuBar() {
        let timeString = timerManager.timerState != .stopped ? timerManager.timeString() : "--:--"
        print(timerManager.timerState)
        statusItem?.button?.title = timeString
    }
}
