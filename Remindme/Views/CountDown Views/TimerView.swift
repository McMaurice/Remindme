//
//  TimerView.swift
//  Remindme
//
//  Created by Macmaurice Osuji on 2/13/24.
//

//import SwiftUI
//
//struct TimerDisplayView: View {
//    
//    @EnvironmentObject var eventViewModel: EventViewModel
//    
//    @State private var timeRemaining = 4435
//    
//    var body: some View {
//        VStack {
//            Text("\(eventViewModel.timeString(from: timeRemaining))")
//                .font(.system(size: 45))
//                .frame(height: 80.0)
//                .frame(minWidth: 0, maxWidth: .infinity)
//                .foregroundColor(.white)
//                .background(Color.blue)
//                .cornerRadius(25)
//                .shadow(radius: 10)
//                .padding()
//        }
//    }
//}
//
//
//struct TimerView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            TimerDisplayView()
//        }
//        .environmentObject(EventViewModel())
//    }
//}
