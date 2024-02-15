//
//  CountdownView.swift
//  Remindme
//
//  Created by Macmaurice Osuji on 1/31/24.
//

import SwiftUI

struct CountdownView: View {
    
    @EnvironmentObject var eventViewModel: EventViewModel
    let event: EventModel
    
    @State private var targetDate = Date()
    @State private var secondsDifference = 0
    @State private var active = false
    @State private var timeRemaining = 0
    @State private var confirmationDialog = false
    
    @State var targetDateString = "Feb 14, 2024 at 12:30:00 PM"
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy 'at' h:mm:ss a"
        return formatter
    }()
    
    var body: some View {
        VStack {
            Text("\(event.title)")
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Image("Clock")
                .resizable()
                .scaledToFit()
                .padding()
            
            VStack {
                Text("\(eventViewModel.timeString(from: event.isActive ? timeRemaining : 0 ))")
                    .font(.system(size: 45))
                    .frame(height: 80.0)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(25)
                    .shadow(radius: 10)
                    .padding()
            }
            
            HStack(spacing: 50) {
                Text("DAYS")
                Text("HRS")
                Text("MINS")
                Text("SECS")
            }
            .padding(.bottom, 50)
            
            if !event.isActive {
                Text("This event is not active at the moment!😔")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .padding(.bottom)
            }
            
            if event.isActive {
                VStack {
                    Button {
                        confirmationDialog.toggle()
                    } label: {
                        Text("Stop Timer")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal, 20)
                            .background(event.isActive ? Color.red : Color.green)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                    .padding(.bottom)
                    .confirmationDialog("Are you sure you want to end this reminder? 🤔", isPresented: $confirmationDialog, titleVisibility: .visible) {
                        Button("Continue", role: .destructive) {
                            eventViewModel.switchCompletion(event: event)
                        }
                    }
                }
            }
        }
        .onAppear {
            initializeCountdown()
        }
        .onReceive(timer) { _ in
            
            updateTimeRemaining()
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
        if timeRemaining > 0 && event.isActive {
            timeRemaining -= 1
        } else {
            eventViewModel.switchCompletion(event: event)
            active.toggle()
            timer.upstream.connect().cancel()
        }
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CountdownView(event: EventModel(title: "Happy new year", date: Date(), isActive: true))
        }
        .environmentObject(EventViewModel())
    }
}
