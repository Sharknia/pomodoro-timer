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
    var timerManager = TimerManager.shared // 싱글턴 인스턴스 사용
    var menuBarManager: MenuBarManager?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // 메인 윈도우를 표시하지 않음
        NSApplication.shared.setActivationPolicy(.accessory)

        // MenuBarManager 인스턴스 생성
        self.menuBarManager = MenuBarManager(timerManager: timerManager)
        
        timerManager.onTimerUpdate = { [weak self] in
            self?.menuBarManager?.updateMenuBar()
            self?.menuBarManager?.constructMenu()
        }
    }
    
    func application(_ application: NSApplication, open urls: [URL]) {
        for url in urls {
            handleURL(url)
        }
    }

    private func handleURL(_ url: URL) {
        guard let command = url.host else { return }

        switch command {
        case "startFocus":
            menuBarManager?.startFocus()
        case "startShortBreak":
            menuBarManager?.startShortBreak()
        case "startLongBreak":
            menuBarManager?.startLongBreak()
        case "pauseTimer":
            menuBarManager?.pauseTimer()
        case "resetTimer":
            menuBarManager?.resetTimer()
        case "resumeTimer":
            menuBarManager?.resumeTimer()
        default:
            break
        }
    }

}
