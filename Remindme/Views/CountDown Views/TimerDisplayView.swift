//
//  TimerView.swift
//  Remindme
//
//  Created by Macmaurice Osuji on 2/13/24.
//

import SwiftUI


extension CountdownView {
    var TimerDisplayView: some View {
        Section {
            Text("\(eventViewModel.timeString(from: event.isActive ? timeRemaining : 0 ))")
                .font(.system(size: 45))
                .frame(height: 80.0)
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(25)
                .shadow(radius: 10)
                .padding()
            
            HStack(spacing: 50) {
                Text("DAYS")
                Text("HRS")
                Text("MINS")
                Text("SECS")
            }
            .padding(.bottom, 50)
            
        }
    }
}

