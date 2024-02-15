//
//  ViewModel.swift
//  Remindme
//
//  Created by Macmaurice Osuji on 1/29/24.
//

import Foundation

struct EventModel: Identifiable, Codable {
    let id: String
    let title: String
    let date: Date
    let isActive: Bool

    init(id: String = UUID().uuidString, title: String, date: Date, isActive: Bool) {
        self.id = id
        self.title = title
        self.date = date
        self.isActive = isActive
    }
    
    var formattedDate: String {
        date.formatted(date: .abbreviated, time: .standard)
    }
    
    func updateCompletion() -> EventModel {
        return EventModel(id: id, title: title, date: date, isActive: false)
    }

}
