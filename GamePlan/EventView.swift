//
//  EventView.swift
//  GamePlan
//
//  Created by Diego Borgo on 10/25/25.
//

import SwiftUI

struct EventView: View {
//    @StateObject var data = FinanceData()
    
    @State var searchText: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.vertical) {
                    VStack {
                        ForEach(0..<20) { i in
                            Text("Event \(i+1)").padding().frame(maxWidth: .infinity).background(.white).cornerRadius(8)
                        }
                    }
                    .padding()
                }.background(Color.gray.opacity(0.5)).cornerRadius(8)
                Button("Add Event", action: {
                    
                }).buttonStyle(.borderedProminent)
                Button("Delete Event", action: {
                    
                }).buttonStyle(.borderedProminent)
                searchBar
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Home")
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
