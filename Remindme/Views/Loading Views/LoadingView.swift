//
//  ContentView.swift
//  Remindme
//
//  Created by Macmaurice Osuji on 1/29/24.
//

import SwiftUI

struct LoadingView: View {
    @State private var rotation: Double = 0.0
    @State private var loading = false
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.cyan, Color.green],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing).ignoresSafeArea()
            VStack {
                ZStack {
                    lineView()
                        .stroke(.blue, lineWidth: 3)
                        .frame(width: 50, height: 50)
                        .rotationEffect(Angle(degrees: loading ? 360 : 0))
                    lineView()
                        .stroke(.yellow, lineWidth: 3)
                        .frame(width: 50, height: 50)
                        .rotationEffect(Angle(degrees: loading ? 180 : 0))
                    lineView()
                        .stroke(.yellow, lineWidth: 3)
                        .frame(width: 50, height: 50)
                        .rotationEffect(Angle(degrees: loading ? 180 : 0))
                        .offset(x: 10, y: 10)
            
                }
                .padding(30)
                Text("Loading..")
                    .font(.headline)
            }
        }
      .onAppear {
          withAnimation(
            .linear
                .speed(0.1)
                .repeatForever(autoreverses: false))
          {
            loading = true
        }
      }
    }
}


struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
