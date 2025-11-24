//
//  ItemView.swift
//  GamePlan
//
//  Created by Diego Borgo on 11/23/25.
//

import SwiftUI
import MapKit

struct ItemView: View {
    var event: Event

    var body: some View {
        NavigationStack {
            VStack {
                Text("\(event.name)").font(.title)
                Text("Description: \(event.desc)").font(.headline)
                Text("Date: \(event.date)").font(.headline)
                Text("Time: \(event.time)").font(.headline)
                Text("Location: \(event.loc)").font(.headline)
                NavigationLink(destination: MapView(event: event)) {
                    Text("View on Map")
                }.padding().buttonStyle(.borderedProminent)
            }.padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Map View")
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Gradient(colors: [.cyan, .purple, .purple, .purple]).opacity(0.5))
        }.tint(.purple)
    }
}
