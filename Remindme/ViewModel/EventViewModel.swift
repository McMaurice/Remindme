//
//  ViewModel.swift
//  Remindme
//
//  Created by Macmaurice Osuji on 2/8/24.
//

import Foundation

class EventViewModel: ObservableObject {
    @Published var events: [EventModel] {
        didSet {
            if let encoded = try? JSONEncoder().encode(events) {
                UserDefaults.standard.set(encoded, forKey: "events")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "events") {
            if let decodedItems = try? JSONDecoder().decode([EventModel].self, from: savedItems) {
                events = decodedItems
                return
            }
        }

        events = []
    }
    
    
    /*
     CRUD FUNCTIONS
     
     C create
     R read
     U update
     D delete item
     
     
     */
    
    func addEvent(title: String, date: Date) {
        let newEvent = EventModel(title: title, date: date, isActive: true)
        NotificationManager.instance.scheduleNotification(date: date, title: title)
        events.append(newEvent)
    }
    
    func deleteEvent(indexSet: IndexSet) {
        events.remove(atOffsets: indexSet)
    }
    
    func moveEvent(from: IndexSet, to: Int) {
        events.move(fromOffsets: from, toOffset: to)
    }
    
    func switchCompletion(event: EventModel) {
        if let index = events.firstIndex(where: { $0.id == event.id}) {
            events[index] = event.updateCompletion()
        }
    }
    
    func timeString(from seconds: Int) -> String {
        if seconds <= 0 {
            return "00 : 00 : 00 : 00"
        }

        let days = seconds / 86400
        let hours = (seconds % 86400) / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = seconds % 60

        return String(format: "%02i : %02i : %02i : %02i", days, hours, minutes, remainingSeconds)
    }
}

