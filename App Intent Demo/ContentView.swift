//
//  ContentView.swift
//  appintent
//
//  Created by Jorge Salcedo on 09/11/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var timerViewModel = TimerViewModel.shared
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text(timerViewModel.remainingTime > 0 ? "Blocked" : "No timer running")
                .font(.largeTitle)
                .foregroundStyle(Color.pink)
            
            if timerViewModel.remainingTime > 3600 {
                Text("\(timerViewModel.remainingTime / 3600) hrs left")
                    .font(.title)
                    .onReceive(timer) { _ in
                        timerViewModel.updateRemainingTime()
                    }
            } else if timerViewModel.remainingTime > 60 {
                Text("\(timerViewModel.remainingTime / 60) min left")
                    .font(.title)
                    .onReceive(timer) { _ in
                        timerViewModel.updateRemainingTime()
                    }
            } else if timerViewModel.remainingTime > 0 {
                Text("\(timerViewModel.remainingTime) sec left")
                    .font(.title)
                    .onReceive(timer) { _ in
                        timerViewModel.updateRemainingTime()
                    }
            }
                
            Text(timerViewModel.remainingTime > 0 ? "Take a little break and try again later." : "")
            Button {
                UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            } label: {
                Text("Go to Home Screen")
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .tint(.black)
        }
    }
}

#Preview {
    ContentView()
}
