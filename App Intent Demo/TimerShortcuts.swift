//
//  TimerShortcuts.swift
//  App Intent Demo
//
//  Created by Jorge Salcedo on 12/3/24.
//

import AppIntents

struct TimerShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: AddTimerIntent(),
            phrases: [
                "Start a block session in \(.applicationName)",
                "Block apps with \(.applicationName)"
            ],
            shortTitle: "Start Timer",
            systemImageName: "timer"
        )
    }
}
