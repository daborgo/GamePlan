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
    
    @State var addEventName: String = ""
    @State var addEventDesc: String = ""
    @State var addEventDate: String = ""
    @State var addEventTime: String = ""
    @State var addEventLoc: String = ""
    
    @State var deleteEventName: String = ""
    
    @State var showingAddEvent: Bool = false
    @State var showingDeleteEvent: Bool = false
    
    @State var err: String = ""
    @State var deleteErr: String = ""

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
                HStack {
                    Button("Add Event", action: {
                        showingAddEvent = true
                    }).buttonStyle(.borderedProminent)
                    Button("Delete Event", action: {
                        showingDeleteEvent = true
                    }).buttonStyle(.borderedProminent)
                }
                searchBar.padding(.top, 12)
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Event View")
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Gradient(colors: [.cyan, .purple, .purple, .purple]).opacity(0.5))
            .sheet(isPresented: $showingAddEvent) {
                NavigationStack {
                    VStack {
                        HStack {
                            Text("Name: ")
                            TextField("Name", text: $addEventName)
                        }
                        HStack {
                            Text("Description: ")
                            TextField("Description", text: $addEventDesc)
                        }
                        HStack {
                            Text("Date: ")
                            TextField("Date", text: $addEventDate)
                        }
                        HStack {
                            Text("Time: ")
                            TextField("Time", text: $addEventTime)
                        }
                        HStack {
                            Text("Location: ")
                            TextField("Location", text: $addEventLoc)
                        }
                        Button("Add", action: {
                            addEventName = ""
                            addEventDesc = ""
                            addEventDate = ""
                            addEventTime = ""
                            addEventLoc = ""
                            showingAddEvent = false
                        }).buttonStyle(.borderedProminent)
                        Text(err).padding().foregroundColor(.red)
                    }
                    .padding()
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Add Event")
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                addEventName = ""
                                addEventDesc = ""
                                addEventDate = ""
                                addEventTime = ""
                                addEventLoc = ""
                                err = ""
                                showingAddEvent = false
                            }, label: {
                                Text("Cancel")
                            })
                        }
                    }
                }
            }
            .sheet(isPresented: $showingDeleteEvent) {
                NavigationStack {
                    VStack {
                        HStack {
                            Text("Name: ")
                            TextField("Name", text: $deleteEventName)
                        }
                        Button("Search", action: {
                            deleteErr = "Found event!"
                        }).buttonStyle(.borderedProminent)
                        Text(deleteErr).padding().foregroundColor(.green)
                        Button("Delete", action: {
                            deleteEventName = ""
                            deleteErr = ""
                            err = ""
                            showingDeleteEvent = false
                        }).buttonStyle(.borderedProminent).padding(.top, 12)
                        Text(err).padding().foregroundColor(.red)
                    }
                    .padding()
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Delete Event")
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                deleteEventName = ""
                                deleteErr = ""
                                err = ""
                                showingDeleteEvent = false
                            }, label: {
                                Text("Cancel")
                            })
                        }
                    }
                }
            }
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
