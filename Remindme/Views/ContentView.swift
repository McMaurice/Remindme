//
//  ContentView.swift
//  Remindme
//
//  Created by Macmaurice Osuji on 1/29/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoading = true
    
    var body: some View {
       if isLoading {
           LoadingView()
               .onAppear {
                   DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                       isLoading = false
                   }
               }
       } else {
           HomeView()
       }
   }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
