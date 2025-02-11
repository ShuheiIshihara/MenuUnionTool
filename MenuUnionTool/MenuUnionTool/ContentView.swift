//
//  ContentView.swift
//  MenuUnionTool
//
//  Created by 石原脩平 on 2025/01/13.
//

import SwiftUI

struct ContentView: View {
    @State var instruments: [Instrument] = []
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            
        }
        .padding()
        .task {
            do {
                instruments = try await supabase
                    .from("meal_menu")
                    .select()
                    .execute()
                    .value
                print(instruments)
            } catch {
                dump(error)
            }
        }
    }
}

#Preview {
    ContentView()
}
