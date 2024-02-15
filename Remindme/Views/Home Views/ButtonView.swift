//
//  ButtonView.swift
//  Remindme
//
//  Created by Macmaurice Osuji on 2/13/24.
//

import SwiftUI

struct SetAReminderButtonView: View {
    var body: some View {
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


struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SetAReminderButtonView()
    }
}
