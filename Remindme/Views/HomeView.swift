//
//  HomeView.swift
//  Remindme
//
//  Created by Macmaurice Osuji on 1/29/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var vm: ViewModel
    @State private var addActivity = false
    @State var showSheet = false
    @State var bkColor = Color.red
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.green.ignoresSafeArea()
                VStack {
                    List {
                        ForEach(vm.events) { event in
                            NavigationLink {
                                CountdownView(vm: vm, event: event)
                            } label: {
                                Section {
                                    VStack {
                                        HStack {
                                            Image(systemName: "alarm")
                                                .font(.title.bold())
                                            Text(event.title)
                                                
                                                .foregroundColor(.blue)
                                            Spacer()
                                            Text(event.isActive ? "Active" : "Ended")
                                                .foregroundColor(event.isActive ? Color.green : Color.red)
                                                .padding(.trailing)
                                        }
                                        .font(.title2.bold())
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
                        }
                        .onDelete(perform: { IndexSet in
                            vm.removeEvent(indexSet: IndexSet)
                        })
                        .onMove(perform: vm.moveEvent)
                        
                    }
                    .navigationBarTitle("Reminders")
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden) // Used to hide the default white color of a form (List views)
                    .overlay(Group {
                        if  vm.events.isEmpty {
                            ZStack() {
                                bkColor.ignoresSafeArea()
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
                        HStack {
                            Image(systemName: "plus")
                            Text("Set a Reminder")
                        }
                        .foregroundColor(.green)
                        .font(.headline)
                        .frame(maxWidth: 300)
                        .padding(20)
                        .background(Color.white.cornerRadius(10).shadow(radius: 10))
                        
                    }
                }
                .sheet(isPresented: $showSheet) {
                    AddView(vm: vm)
                }
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(vm: ViewModel())
    }
}
