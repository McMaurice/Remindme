//
//  HomeListView.swift
//  Remindme
//
//  Created by Macmaurice Osuji on 2/13/24.
//

import SwiftUI

struct HomeListRow: View {
    
    var event: EventModel
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "alarm")
                    .font(.title.bold())
                Text(event.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
                Spacer()
                Text(event.isActive ? "Active" : "Inactive")
                    .foregroundColor(event.isActive ? Color.green : Color.red)
                    .padding(.trailing)
            }
            .padding(.trailing, 5)
            .padding(.bottom, 5)
            
            HStack {
                Text("Due on:")
                    .fontWeight(.bold)
                    .padding(.trailing, 2)
                Text("\(event.date.formatted(date: .abbreviated, time: .standard))")
            }
            .font(.callout)
            .padding(.trailing)
            
        }
    }
}


struct HomeListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeListRow(event: EventModel(title: "newyear", date: Date(), isActive: true))
    }
}
