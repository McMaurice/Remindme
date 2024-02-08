//
//  ViewModel.swift
//  Remindme
//
//  Created by Macmaurice Osuji on 2/8/24.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var events: [Event] {
        didSet {
            if let encoded = try? JSONEncoder().encode(events) {
                UserDefaults.standard.set(encoded, forKey: "events")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "events") {
            if let decodedItems = try? JSONDecoder().decode([Event].self, from: savedItems) {
                events = decodedItems
                return
            }
        }

        events = []
    }
    
    func addEvent(event: Event) {
        events.append(event)
    }
    
    func removeEvent(indexSet: IndexSet) {
        events.remove(atOffsets: indexSet)
    }
    
    func moveEvent(indices: IndexSet, newOffset: Int) {
        events.move(fromOffsets: indices, toOffset: newOffset)
    }
    
    func timeString(from seconds: Int) -> String {
        if seconds <= 0 {
            return "Ended"
        }

        let days = seconds / 86400
        let hours = (seconds % 86400) / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = seconds % 60

        return String(format: "%02i:%02i:%02i:%02i", days, hours, minutes, remainingSeconds)
    }
}
