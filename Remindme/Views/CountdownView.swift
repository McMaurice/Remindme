//
//  CountdownView.swift
//  Remindme
//
//  Created by Macmaurice Osuji on 1/31/24.
//

import SwiftUI
import Combine

struct CountdownView: View {
    @ObservedObject var vm: ViewModel
    var event: Event
    @State private var timeRemaining = 0
    @State private var targetDate = Date()
    @State private var secondsDifference = 0
    @State private var active = false
    
    @State var targetDateString = "Feb 9, 2024 at 5:30:00 PM"
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy 'at' h:mm:ss a"
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(secondsDifference)")
                    .padding()
                
                Text("\(event.formattedDate)")
                Text("\(vm.timeString(from: timeRemaining))")
                    .font(.system(size: 60))
                    .frame(height: 80.0)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(25)
            }
            .navigationTitle(event.title)
            .onAppear {
                initializeCountdown()
            }
            .onReceive(timer) { _ in
                updateTimeRemaining()
            }
        }
    }
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private func initializeCountdown() {
        guard let targetDate = dateFormatter.date(from: event.formattedDate) else {
            print("Error: Unable to parse target date")
            return
        }
        self.targetDate = targetDate
        secondsDifference = Int(targetDate.timeIntervalSinceNow)
        timeRemaining = secondsDifference
    }

    private func updateTimeRemaining() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            active.toggle()
            timer.upstream.connect().cancel()
        }
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView(vm: ViewModel(), event: Event(title: "New Year", date: Date(), isActive: true))
    }
}
