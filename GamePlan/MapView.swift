//
//  MapView.swift
//  GamePlan
//
//  Created by Diego Borgo on 10/25/25.
//

import SwiftUI
import SwiftData
import MapKit

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    @Environment(\.modelContext) private var context
    @Query var events: [Event]

    var event: Event? = nil

    // fallback default
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 33.4255,
            longitude: -111.9400
        ),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )

    @State var markers: [Location] = []

    @State var searchText: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                ZStack(alignment: .bottom) {
                    Map(coordinateRegion: $region, interactionModes: .all, annotationItems: markers){ location in
//                        MapMarker(coordinate: location.coordinate)
                        MapAnnotation(coordinate: location.coordinate) {
                            VStack {
                                Text(location.name).font(.caption)
                                Image(systemName: "mappin.circle.fill").font(.title2).foregroundColor(.red)
                            }
                        }
                    }
                }
                .ignoresSafeArea()
                .onAppear {
                    populateMap()
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Map View")
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Gradient(colors: [.cyan, .purple, .purple, .purple]).opacity(0.5))
        }.tint(.purple)
    }
    
    func populateMap() {
        if let event = event, let lat = event.lat, let lon = event.lon {
            let loc = Location(name: event.name, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            markers = [loc]
            region = MKCoordinateRegion(center:loc.coordinate, span:MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07)
            )
        } else {
            markers = events.compactMap { e in
                guard let lat = e.lat, let lon = e.lon else { return nil }
                return Location(name:e.name, coordinate:CLLocationCoordinate2D(latitude:lat, longitude:lon))
            }
            
            //US map
            region = MKCoordinateRegion(center:CLLocationCoordinate2D(latitude:39.8283, longitude:-98.5795), span:MKCoordinateSpan(latitudeDelta:50, longitudeDelta:50))
        }
    }
}
