
import SwiftUI

struct ContentView: View {
    @StateObject private var timerManager = TimerManager()

    var body: some View {
        VStack {
            Text("남은 시간: \(timerManager.secondsLeft)초")
                .font(.largeTitle)
                .padding()

            if timerManager.timerState == .stopped {
                Button("25분 집중 시작") {
                    timerManager.setTimer(minutes: 25)
                }
                .customButtonStyle(backgroundColor: .green)

                Button("5분 휴식 시작") {
                    timerManager.setTimer(minutes: 5)
                }
                .customButtonStyle(backgroundColor: .blue)

                Button("20분 긴휴식 시작") {
                    timerManager.setTimer(minutes: 20)
                }
                .customButtonStyle(backgroundColor: .orange)
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
                .customButtonStyle(backgroundColor: .yellow)

                Button("리셋") {
                    timerManager.resetTimer()
                }
                .customButtonStyle(backgroundColor: .red)
            }
        }
        .frame(width: 300, height: 200)
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
