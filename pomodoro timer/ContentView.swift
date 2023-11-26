
import SwiftUI

struct ContentView: View {
    @StateObject private var timerManager = TimerManager()

    var body: some View {
        VStack {
            if timerManager.timerState != .stopped {
                Text("남은 시간: \(timerManager.secondsLeft)초")
                    .font(.largeTitle)
                    .padding()
                    .foregroundColor(.white)
            }

            if timerManager.timerState == .stopped {
                Button("25분 집중 시작") {
                    timerManager.setTimer(minutes: 25)
                }
                .customButtonStyle(backgroundColor: Color.gray.opacity(0.8))

                Button("5분 휴식 시작") {
                    timerManager.setTimer(minutes: 5)
                }
                .customButtonStyle(backgroundColor: Color.gray.opacity(0.8))

                Button("20분 긴휴식 시작") {
                    timerManager.setTimer(minutes: 20)
                }
                .customButtonStyle(backgroundColor: Color.gray.opacity(0.8))
            } else {
                Button(action: {
                    if timerManager.timerState == .running {
                        timerManager.pauseTimer()
                    } else {
                        timerManager.startTimer()
                    }
                }) {
                    Label(timerManager.timerState == .running ? "일시 정지" : "다시 시작", systemImage: timerManager.timerState == .running ? "pause.circle" : "play.circle")
                }
                .customButtonStyle(backgroundColor: Color.gray.opacity(0.8))

                Button("리셋") {
                    timerManager.resetTimer()
                }
                .customButtonStyle(backgroundColor: Color.gray.opacity(0.8))
            }
        }
        .frame(width: 300, height: 200)
        .background(Color.black)
    }
}

extension View {
    func customButtonStyle(backgroundColor: Color) -> some View {
        self.padding(10)
            .frame(minWidth: 100, maxWidth: .infinity)
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(8)
            .font(.headline)
    }
}


#Preview {
    ContentView()
}
