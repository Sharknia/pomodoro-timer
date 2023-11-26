
import SwiftUI

struct ContentView: View {
    @StateObject private var timerManager = TimerManager()

    var body: some View {
        VStack {
            if timerManager.timerState != .stopped {
                Text(timerManager.timeString())
                    .font(.largeTitle)
                    .padding()
                    .foregroundColor(.white)
            }

            if timerManager.timerState == .stopped {
                Button("25분 집중 시작") {
                    timerManager.setTimer(type: .focus)
                }
                .customButtonStyle(backgroundColor: Color.gray.opacity(0.8))

                Button("5분 휴식 시작") {
                    timerManager.setTimer(type: .shortBreak)
                }
                .customButtonStyle(backgroundColor: Color.gray.opacity(0.8))

                Button("20분 긴휴식 시작") {
                    timerManager.setTimer(type: .longBreak)
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
        .alert(isPresented: $timerManager.showAlert) {
            Alert(title: Text(timerManager.alertTitle), dismissButton: .default(Text("확인")))
        }
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
