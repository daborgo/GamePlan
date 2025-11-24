//
//  jsonWebVM.swift
//  GamePlan
//
//  Created by Diego Borgo on 11/22/25.
//

import Foundation

struct tsdb: Decodable {
    let events: [event]
}

struct event: Decodable {
    let strEvent: String?
    let strSport: String?
    let dateEvent: String?
    let strTime: String?
    let strVenue: String?
}

class jsonWebVM: ObservableObject {
    @Published var locArray: [APILocation]
    @Published var rawJson: String?
    @Published var error: String?
    
    init() {
        locArray = []
    }
    
    func getJsonData(d:String) {
        let urlAsString = "https://www.thesportsdb.com/api/v1/json/123/eventsday.php?d=\(d)"
        
        let url = URL(string: urlAsString)!
        let urlSession = URLSession.shared
        
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            var err: NSError?
            
            do {
                let jsonString = String(data: data!, encoding: .utf8)
                DispatchQueue.main.async {
                    self.rawJson = jsonString
                }
                
                let decodedData = try JSONDecoder().decode(tsdb.self, from: data!)
                let array = decodedData.events.map { e in
                    APILocation(name: e.strEvent ?? "", desc: e.strSport ?? "", date: e.dateEvent ?? "", time: e.strTime ?? "", loc: e.strVenue ?? "")
                }
                DispatchQueue.main.async {
                    self.locArray = array
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = "error: \(error)"
                }
            }
        })
        jsonQuery.resume()
    }
}
