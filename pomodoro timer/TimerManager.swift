//
//  TimerManager.swift
//  pomodoro timer
//
//  Created by 이한결 on 11/26/23.
//

import Foundation

class TimerManager: ObservableObject {
    static let shared = TimerManager()
    
    @Published var secondsLeft = 0
    @Published var timerState = TimerState.stopped
    @Published var showAlert = false
    var alertTitle = ""
    var timerType: TimerType = .focus
    var timer: Timer?

    var onTimerUpdate: (() -> Void)?
    
    func setTimer(type: TimerType) {
        self.timerType = type
        secondsLeft = type.minutes * 60
        startTimer()
    }


    func startTimer() {
        timerState = .running
        
        // 별도의 스레드에서 타이머 실행
        DispatchQueue.global(qos: .background).async {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                DispatchQueue.main.async {
                    guard let self = self else { return }

                    if self.secondsLeft > 0 {
                        self.secondsLeft -= 1
                    } else {
                        self.showAlert = true
                        switch self.timerType {
                        case .focus:
                            self.alertTitle = "집중 시간 종료"
                        case .shortBreak:
                            self.alertTitle = "짧은 휴식 시간 종료"
                        case .longBreak:
                            self.alertTitle = "긴 휴식 시간 종료"
                        }
                        self.resetTimer()
                    }
                    self.onTimerUpdate?()
                }
            }
            RunLoop.current.run()
        }
    }
    
    func pauseTimer() {
        timerState = .paused
        timer?.invalidate()
    }

    func resetTimer() {
        timerState = .stopped
        timer?.invalidate()
        secondsLeft = 0 // 타이머 초기 시간으로 재설정
    }
    
    func timeString() -> String {
        let minutes = secondsLeft / 60
        let seconds = secondsLeft % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
