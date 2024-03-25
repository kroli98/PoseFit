//
//  ContentView.swift
//  PoseFitWatch Watch App
//
//  Created by Kiss Roland on 09/02/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var isPaused = false
    
    var body: some View {
        VStack {
            Text("Fekvőtámasz")
                .font(.title3)
            HStack{
                HStack{
                    Image(systemName: "heart.fill")
                    Text("68")
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                
                Spacer()
                Text("2/15")
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                Spacer()
                Text("00:30")
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            }
            Spacer()
            VStack{
                if(!isPaused)
                {
                    Image(systemName: "pause")
                        .font(.largeTitle)
                        
                }else{
                    Image(systemName: "play.fill")
                        .font(.largeTitle)
                }
            }
            
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation{
                    isPaused.toggle()
                }
            }
            Spacer()
            Button("Üzenet küldés")
            {
                WatchConnectivityManager.shared.send("Hello World!\n\(Date().ISO8601Format())")

            }
            HStack{
                Button("Befejezés")
                {}
                Button("Következő")
                {}
            }
            .font(.system(size: 12))
            
            
        }
        .padding(.bottom)
        .ignoresSafeArea()
    }
        
}

#Preview {
    ContentView()
}
