//
//  RemindmeApp.swift
//  Remindme
//
//  Created by Macmaurice Osuji on 1/29/24.
//

import SwiftUI

@main
struct RemindmeApp: App {
    
    @StateObject var eventViewModel: EventViewModel = EventViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .environmentObject(eventViewModel)
        }
    }
}
