//
//  ContentView.swift
//  App Intent Demo
//
//  Created by Jorge Salcedo on 09/11/24.
//

import SwiftUI

struct ContentView: View {
    private let timerViewModel = TimerViewModel.shared

    var body: some View {
        TimelineView(.periodic(from: .now, by: 1)) { _ in
            let remaining = timerViewModel.remainingTime

            VStack {
                Text(remaining > 0 ? "Blocked" : "No timer running")
                    .font(.largeTitle)
                    .foregroundStyle(Color.pink)

                if remaining > 0 {
                    Text("\(formatted(remaining)) left")
                        .font(.title)
                        .monospacedDigit()

                    Text("Take a little break and try again later.")
                }

                Button {
                    UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                } label: {
                    Text("Go to Home Screen")
                }
                .buttonStyle(.borderedProminent)
                .padding()
                .tint(.black)
            }
            .padding()
        }
    }

    private func formatted(_ seconds: Int) -> String {
        let pattern: Duration.TimeFormatStyle.Pattern = seconds >= 3600 ? .hourMinuteSecond : .minuteSecond
        return Duration.seconds(seconds).formatted(.time(pattern: pattern))
    }
}

#Preview {
    ContentView()
}
