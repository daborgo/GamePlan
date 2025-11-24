//
//  ContentView.swift
//  GamePlan
//
//  Created by Diego Borgo on 10/24/25.
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Game Plan").font(.largeTitle).fontWeight(.bold)
                Spacer()
                NavigationLink(destination: EventView()) {
                    Text("Event View").padding()
                }.buttonStyle(.borderedProminent)
                NavigationLink(destination: MapView()) {
                    Text("Map View").padding()
                }.buttonStyle(.borderedProminent)
                Spacer()
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Home")
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Gradient(colors: [.cyan, .purple, .purple, .purple]).opacity(0.5))
        }.tint(.purple)
    }
}
