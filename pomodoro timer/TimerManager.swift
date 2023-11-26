//
//  TimerManager.swift
//  pomodoro timer
//
//  Created by 이한결 on 11/26/23.
//

import Foundation

class TimerManager: ObservableObject {
    @Published var secondsLeft = 0
    @Published var timerState = TimerState.stopped
    var timer: Timer?

    func setTimer(minutes: Int) {
        secondsLeft = minutes * 60
        secondsLeft = 2
        startTimer()
    }

    func startTimer() {
        timerState = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }

            if self.secondsLeft > 0 {
                self.secondsLeft -= 1
            } else {
                self.resetTimer()
            }
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
}
