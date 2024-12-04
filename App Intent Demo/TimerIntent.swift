//
//  addTimerIntent.swift
//  appintent
//
//  Created by Jorge Salcedo on 10/11/24.
//

import AppIntents

struct AddTimerIntent: AppIntent {
    static var title = LocalizedStringResource("Start a New Timer")

    // Enum for time units
    enum TimeUnit: String, AppEnum {
        case seconds = "Seconds"
        case minutes = "Minutes"
        
        static var typeDisplayRepresentation: TypeDisplayRepresentation {
            "Time Unit"
        }
        
        static var caseDisplayRepresentations: [Self: DisplayRepresentation] {
            [
                .seconds: DisplayRepresentation(title: "Seconds"),
                .minutes: DisplayRepresentation(title: "Minutes")
            ]
        }
    }

    // Single input for parsing time and unit
    @Parameter(
        title: "Duration",
        description: "Specify the time and unit (e.g., 20 seconds or 5 minutes)"
    )
    var duration: String

    func perform() async throws -> some IntentResult {
        // Parse the user input
        guard let parsedDuration = parseDuration(input: duration) else {
            throw NSError(domain: "AddTimerIntentErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Could not understand the duration. Please specify in the format '20 seconds' or '5 minutes'."])
        }
        
        let totalSeconds = parsedDuration.unit == .minutes ? parsedDuration.value * 60 : parsedDuration.value

        // Add the timer only if the value is valid
        if totalSeconds > TimerViewModel.shared.getTimer() {
            TimerViewModel.shared.addTimer(seconds: totalSeconds)
        }

        return .result()
    }

    // Helper method to parse the duration input
    private func parseDuration(input: String) -> (value: Int, unit: TimeUnit)? {
        let lowercasedInput = input.lowercased()
        
        if lowercasedInput.contains("minute") {
            if let value = extractNumber(from: lowercasedInput) {
                return (value, .minutes)
            }
        } else if lowercasedInput.contains("second") {
            if let value = extractNumber(from: lowercasedInput) {
                return (value, .seconds)
            }
        }
        return nil
    }

    // Extract numerical value from a string
    private func extractNumber(from input: String) -> Int? {
        let pattern = "\\d+"
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(input.startIndex..<input.endIndex, in: input)
        
        if let match = regex?.firstMatch(in: input, options: [], range: range),
           let range = Range(match.range, in: input) {
            return Int(input[range])
        }
        return nil
    }
}




struct GetTimerIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Get remaining timer"
    
    func perform() async throws -> some IntentResult & ReturnsValue<Int> {
        let remainingSeconds = TimerViewModel.shared.getTimer()
        
        return .result(value: remainingSeconds)
    }
}
