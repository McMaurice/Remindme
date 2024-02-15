//
//  AddView.swift
//  Remindme
//
//  Created by Macmaurice Osuji on 1/29/24.
//

import SwiftUI

struct AddView: View {
    @EnvironmentObject var eventViewModel: EventViewModel
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var titleInFocus: Bool
    
    @State private var titleField = ""
    @State private var dateField = Date()
    @State private var showAlert = false
    @State private var alertType: MyAlerts? = nil
    
    let strtingDate = Date()
    let endingDate: Date = Calendar.current.date(byAdding: .day, value: 365, to: Date()) ?? Date()

    
    var dateFormattter: DateFormatter {
        let formater = DateFormatter()
        formater.dateStyle = .full
        formater.timeStyle = .short
        return formater
    }
    
    var backgroundColor = LinearGradient(colors: [Color.green, Color.white],
                                                   startPoint: .topLeading,
                                                   endPoint: .bottomTrailing)
    
    enum MyAlerts {
        case tooShort
        case tooLong
    }
    
    var body: some View {
       
            VStack {
                Form {
                    Section {
                        TextField("Enter the event title", text: $titleField)
                            .focused($titleInFocus)
                    }
                    Section {
                        DatePicker("Select date", selection: $dateField, in: strtingDate...endingDate)
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                    }
                    Section {
                        Text(dateFormattter.string(from: dateField))
                            .foregroundColor(Color.red)
                            .font(.headline)
                    } header: {
                        Text("This Event will take place on:")
                            .foregroundColor(Color.black)
                    }
                }
                
                Button {
                    if inputCheker() {
                        eventViewModel.addEvent(title: titleField, date: dateField)
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
        .navigationTitle("Create New Event")
        .scrollContentBackground(.hidden) // Used to hide the default white color of a form (List views)
        .background(backgroundColor)
        
        .alert(isPresented: $showAlert) {
            getAlert()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.titleInFocus = true}
            }
        }
    
    
    func getAlert() -> Alert {
        switch alertType {
        case .tooShort:
            return Alert(title: Text("Title is too short!"), message: nil, dismissButton: .cancel(Text("Try agin")))
        case .tooLong:
            return Alert(title: Text("Title is too long!"), message: nil, dismissButton:.default(Text("OK"), action: {
            }))
        default:
            return Alert(title: Text("ERROR"))
        }
    }
    
    func inputCheker() -> Bool {
        if titleField.count < 2 {
            alertType = .tooShort
            showAlert.toggle()
            return false
        } else if titleField.count > 30 {
            alertType = .tooLong
            showAlert.toggle()
            return false
        } else {
            return true
        }
    }
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddView()
        }
        .environmentObject(EventViewModel())
    }
}
