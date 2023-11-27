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
        // 메인 윈도우를 표시하지 않음
        NSApplication.shared.setActivationPolicy(.accessory)
        
        // 메뉴 바 아이템 생성
        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        // 드롭다운 메뉴 생성
        constructMenu()
        
        // 타이머 초기화 및 업데이트
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.updateMenuBar()
        }
        
        timerManager.onTimerUpdate = { [weak self] in
            self?.updateMenuBar()
            self?.constructMenu()
        }
        
    }

    
    func updateMenuBar() {
        let timeString = timerManager.timerState != .stopped ? timerManager.timeString() : "--:--"
        statusItem?.button?.title = timeString
    }
    
    func constructMenu() {
        let menu = NSMenu()
        
        // 타이머 상태에 따라 메뉴 아이템 추가
        if timerManager.timerState == .stopped {
            menu.addItem(withTitle: "25분 집중 시작", action: #selector(startFocus), keyEquivalent: "")
            menu.addItem(withTitle: "5분 휴식 시작", action: #selector(startShortBreak), keyEquivalent: "")
            menu.addItem(withTitle: "20분 긴휴식 시작", action: #selector(startLongBreak), keyEquivalent: "")
        } else if timerManager.timerState == .paused {
            menu.addItem(withTitle: "다시 시작", action: #selector(resumeTimer), keyEquivalent: "")
            menu.addItem(withTitle: "리셋", action: #selector(resetTimer), keyEquivalent: "")
        } else { // 타이머가 실행 중일 때
            menu.addItem(withTitle: "일시 정지", action: #selector(pauseTimer), keyEquivalent: "")
            menu.addItem(withTitle: "리셋", action: #selector(resetTimer), keyEquivalent: "")
        }

        statusItem?.menu = menu
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
