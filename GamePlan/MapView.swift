//
//  MapView.swift
//  GamePlan
//
//  Created by Diego Borgo on 10/25/25.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct MapView: View {
//    @StateObject var data = FinanceData()
    
    var location = CLLocationCoordinate2D(
        latitude: 33.4255,
        longitude: -111.9400
    )
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 33.4255,
            longitude: -111.9400
        ),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )

    @State var markers = [
        Location(name: "Tempe", coordinate: CLLocationCoordinate2D(
            latitude: 33.4255,
            longitude: -111.9400
        ))
    ]

    @State var searchText: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                ZStack(alignment: .bottom) {
                    Map(coordinateRegion: $region, interactionModes: .all, annotationItems: markers){ location in
                        MapMarker(coordinate: location.coordinate)
//                        MapAnnotation(coordinate: location.coordinate){
//                            if !searched {
//                                Text(park.name)
//                            } else {
//                                Text(location.name)
//                            }
//                            Circle().strokeBorder(.red, lineWidth: 2).frame(width:20, height: 20)
//                        }
                    }
                }
                .ignoresSafeArea()
//                .onAppear {
//                    find(cityState: park.loc)
//                }
                searchBar.padding(.top, 12)
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Map View")
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Gradient(colors: [.cyan, .purple, .purple, .purple]).opacity(0.5))
        }.tint(.purple)
    }
    
    var searchBar: some View {
        HStack {
            Button {
//                let searchRequest = MKLocalSearch.Request()
//                searchRequest.naturalLanguageQuery = searchText
//                searchRequest.region = region
//
//                MKLocalSearch(request: searchRequest).start { response, error in
//                    guard let response = response else {
//                        print("Error: \(error?.localizedDescription ?? "Unknown error").")
//                        return
//                    }
//                    region = response.boundingRegion
//                    markers = response.mapItems.map { item in
//                        Location(name: item.name ?? "", coordinate: item.placemark.coordinate)
//                    }
//                    searched = true
//                }
            } label: {
                Image(systemName: "location.magnifyingglass")
                    .resizable()
                    .foregroundColor(.accentColor)
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 12)
            }
            TextField("Search for a place of interest", text: $searchText)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.white)
        }
    }
}
