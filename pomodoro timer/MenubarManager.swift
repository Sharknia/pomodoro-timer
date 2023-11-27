//
//  MenubarManager.swift
//  pomodoro timer
//
//  Created by 이한결 on 11/27/23.
//

import Foundation
import AppKit

class MenuBarManager {
    let statusItem: NSStatusItem
    var timerManager: TimerManager

    init(timerManager: TimerManager) {
        self.timerManager = timerManager
        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        constructMenu()
        updateMenuBar()
    }

    func updateMenuBar() {
        let timeString = timerManager.timerState != .stopped ? timerManager.timeString() : "--:--"
        statusItem.button?.title = timeString
    }
    
    func constructMenu() {
        let menu = NSMenu()
        
        // 타이머 상태에 따라 메뉴 아이템 추가
        if timerManager.timerState == .stopped {
            let startFocusItem = NSMenuItem(title: "25분 집중 시작", action: #selector(startFocus), keyEquivalent: "")
            startFocusItem.target = self
            menu.addItem(startFocusItem)

            let startShortBreakItem = NSMenuItem(title: "5분 휴식 시작", action: #selector(startShortBreak), keyEquivalent: "")
            startShortBreakItem.target = self
            menu.addItem(startShortBreakItem)

            let startLongBreakItem = NSMenuItem(title: "20분 긴휴식 시작", action: #selector(startLongBreak), keyEquivalent: "")
            startLongBreakItem.target = self
            menu.addItem(startLongBreakItem)
        } else if timerManager.timerState == .paused {
            let resumeItem = NSMenuItem(title: "다시 시작", action: #selector(resumeTimer), keyEquivalent: "")
            resumeItem.target = self
            menu.addItem(resumeItem)

            let resetItem = NSMenuItem(title: "리셋", action: #selector(resetTimer), keyEquivalent: "")
            resetItem.target = self
            menu.addItem(resetItem)
        } else { // 타이머가 실행 중일 때
            let resumeItem = NSMenuItem(title: "일시 정지", action: #selector(pauseTimer), keyEquivalent: "")
            resumeItem.target = self
            menu.addItem(resumeItem)

            let resetItem = NSMenuItem(title: "리셋", action: #selector(resetTimer), keyEquivalent: "")
            resetItem.target = self
            menu.addItem(resetItem)
        }

        statusItem.menu = menu
    }
        
    @objc func startFocus() {
        timerManager.setTimer(type: .focus)
        updateMenuBar()
        constructMenu()
    }

    @objc func startShortBreak() {
        timerManager.setTimer(type: .shortBreak)
        updateMenuBar()
        constructMenu()
    }

    @objc func startLongBreak() {
        timerManager.setTimer(type: .longBreak)
        updateMenuBar()
        constructMenu()
    }

    @objc func pauseTimer() {
        timerManager.pauseTimer()
        updateMenuBar()
        constructMenu()
    }

    @objc func resetTimer() {
        timerManager.resetTimer()
        updateMenuBar()
        constructMenu()
    }
    
    @objc func resumeTimer() {
        timerManager.startTimer()
        updateMenuBar()
        constructMenu()
    }
}
