//
//  EventView.swift
//  GamePlan
//
//  Created by Diego Borgo on 10/25/25.
//

import SwiftUI
import SwiftData
import MapKit

struct EventView: View {
    @Environment(\.modelContext) private var context
    @Query var events: [Event]
    
    @StateObject var webVM = jsonWebVM()
    @State var apiText: String = ""
    
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

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Enter a date (YYYY-MM-DD)", text: $apiText)
                    Button("Get API Events", action: {
                        apiQueryAndAdd()
                    }).buttonStyle(.borderedProminent)
                }
                ScrollView(.vertical) {
                    VStack {
                        ForEach(filterEventList) { event in
                            VStack(alignment: .leading) {
                                NavigationLink(destination: ItemView(event: event)) {
                                    Text("\(event.name) - \(event.loc)").padding().frame(maxWidth: .infinity).background(.white).cornerRadius(8)
                                }
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }.background(Color.gray.opacity(0.5)).cornerRadius(8).frame(maxWidth: .infinity)
                HStack {
                    Button("Add Event", action: {
                        showingAddEvent = true
                    }).buttonStyle(.borderedProminent)
                    Button("Delete Event", action: {
                        showingDeleteEvent = true
                    }).buttonStyle(.borderedProminent)
                    Button("Clear All", action: {
                        for event in events {
                            context.delete(event)
                        }
                    }).buttonStyle(.borderedProminent).tint(.red)
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
                            if addEventName.isEmpty || addEventDesc.isEmpty || addEventDate.isEmpty || addEventTime.isEmpty || addEventLoc.isEmpty {
                                err = "ERROR: Please fill all fields."
                                return
                            }
                            addEvent(n:addEventName, d:addEventDesc, da:addEventDate, t:addEventTime, l:addEventLoc)
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
                        Button("Delete", action: {
                            let matches = events.filter { $0.name == deleteEventName }
                            if let delEvent = matches.first {
                                context.delete(delEvent)
                                deleteEventName = ""
                                err = ""
                                showingDeleteEvent = false
                            } else {
                                err = "ERROR: Event not found."
                            }
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
    
    var filterEventList: [Event] {
        if searchText.isEmpty {
            return events
        } else {
            return events.filter { event in
                event.name.contains(searchText) || event.loc.contains(searchText)
            }
        }
    }
    
    var searchBar: some View {
        HStack {
            TextField("Search events by name or location", text: $searchText)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.white)
        }
    }
    
    func addEvent(n:String, d:String, da:String, t:String, l:String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = l
        MKLocalSearch(request: request).start { response, error in
            guard let coordinate = response?.mapItems.first?.placemark.coordinate else {
                DispatchQueue.main.async {
                    err = "ERROR: Could not find location."
                }
                return
            }
            DispatchQueue.main.async {
                let event = Event(n:n, d:d, da:da, t:t, l:l, lat:coordinate.latitude, lon:coordinate.longitude)
                context.insert(event)
                addEventName = ""
                addEventDesc = ""
                addEventDate = ""
                addEventTime = ""
                addEventLoc = ""
                err = ""
                showingAddEvent = false
            }
        }
    }
    
    func apiQueryAndAdd() {
        webVM.getJsonData(d:apiText)
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            for e in webVM.locArray {
                if events.contains(where: { $0.name == e.name && $0.date == e.date }) {
                    continue
                }
                addEvent(n:e.name, d:e.desc, da:e.date, t:e.time, l:e.loc)
            }
        }
    }
}
