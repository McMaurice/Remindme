//
//  HomeView.swift
//  Remindme
//
//  Created by Macmaurice Osuji on 1/29/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var eventViewModel: EventViewModel
   
    @State private var addActivity = false
    @State var showSheet = false
    
    var body: some View {
            VStack {
                List {
                    ForEach(eventViewModel.events) { event in
                        NavigationLink {
                            CountdownView(event: event)
                        } label: {
                            HomeListView(event: event)
                        }
                    }
                    .onDelete(perform: eventViewModel.deleteEvent)
                    .onMove(perform: eventViewModel.moveEvent)
                    
                }
                .navigationBarTitle("Reminders")
                .listStyle(.plain)
                .overlay(Group {
                    if  eventViewModel.events.isEmpty {
                        ZStack() {
                            VStack {
                                Text("Empty List!")
                            }
                            
                        }
                        
                    }
                })
                .toolbar {
                    EditButton()
                }
                
                Button {
                    showSheet.toggle()
                } label: {
                    SetAReminderButtonView()
                }
                
            }
            .sheet(isPresented: $showSheet) {
                AddView()
            }
        
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
        }
        .environmentObject(EventViewModel())
    }
}
