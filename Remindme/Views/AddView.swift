//
//  AddView.swift
//  Remindme
//
//  Created by Macmaurice Osuji on 1/29/24.
//

import SwiftUI

struct AddView: View {
    @StateObject var vm: ViewModel
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var titleInFocus: Bool
    @State private var title = ""
    @State private var date = Date()
    @State private var isActive = true
    
    let strtingDate = Date()
    let endingDate: Date = Calendar.current.date(from: DateComponents(year: 2099)) ?? Date()
    
    var dateFormattter: DateFormatter {
        let formater = DateFormatter()
        formater.dateStyle = .full
        formater.timeStyle = .short
        return formater
    }
    
    var backgroundColor = LinearGradient(colors: [Color.green, Color.white],
                                                   startPoint: .topLeading,
                                                   endPoint: .bottomTrailing)
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Enter the event title", text: $title)
                            .focused($titleInFocus)
                    }
                    Section {
                        DatePicker("Select date", selection: $date, in: strtingDate...endingDate)
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                    }
                    Section {
                        Text(dateFormattter.string(from: date))
                            .foregroundColor(Color.red)
                            .font(.headline)
                    } header: {
                        Text("This Event will take place on:")
                            .foregroundColor(Color.black)
                    }
                }
                
                Button {
                    let newEvent = Event(title: title, date: date, isActive: true)
                    if title.count > 2 {
                        vm.addEvent(event: newEvent)
                        dismiss()
                    }
                } label: {
                    Text("SAVE")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 20)
                        .background(
                            Color.blue
                                .cornerRadius(10)
                                .shadow(radius: 10))
                }

        }
        .scrollContentBackground(.hidden) // Used to hide the default white color of a form (List views)
        .background(backgroundColor)
        .navigationTitle("Create New Event")
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.titleInFocus = true}
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(vm: ViewModel())
    }
}
