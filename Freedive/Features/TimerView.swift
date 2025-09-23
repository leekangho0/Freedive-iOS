//
//  TimerView.swift
//  Freedive
//
//  Created by Kanghos on 9/23/25.
//

import SwiftUI

struct TimerView: View {
    @State var isRunning: Bool = false
    @State var startTime: Date?
    @State var elapsedTime: TimeInterval = 0
    @State var timerTask: Task<Void, Never>?
    @State var hangDate: Date?
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        VStack {
            Text(elapsedTime, format: .number)
                .monospaced()

            HStack {
                Button  {
                    isRunning.toggle()
                } label: {
                    Text(isRunning ? "Stop" : "Start")
                }
                .frame(minWidth: 70)

                Button("Reset") {
                    isRunning = false
                    elapsedTime = 0
                }
            }
            .buttonStyle(.borderedProminent)

        }
        .onChange(of: isRunning, { oldValue, newValue in
            if newValue {
                startTimer()
            } else { stopTimer() }
        })
        .onChange(of: scenePhase, { oldValue, newValue in
            handlePhase(newValue)
        })
        .onAppear {

        }
        .onDisappear {
        }
    }
}

extension TimerView {
    func startTimer() {
        stopTimer()
        timerTask = Task {
            while isRunning {
                try? await Task.sleep(for: .seconds(1), clock: .continuous)
                elapsedTime += 1
                print("Tick")
            }
        }
    }

    func stopTimer() {
        timerTask?.cancel()
        timerTask = nil
    }

    func handlePhase(_ phase: ScenePhase) {
        switch phase {
        case .background:
            hangDate = Date()
            isRunning = false
        case .inactive: break
        case .active:
            if let hangDate {
                let current = Date()
                let elapsed = current.timeIntervalSince(hangDate)
                elapsedTime += TimeInterval(Int(elapsed))
                isRunning = true
            }
        @unknown default:
            precondition(false)
        }
    }
}

#Preview {
    TimerView()
}
