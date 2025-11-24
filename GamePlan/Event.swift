//
//  Event.swift
//  GamePlan
//
//  Created by Diego Borgo on 11/20/25.
//

import Foundation
import SwiftData
import SwiftUI
import MapKit

@Model
class Event {
    @Attribute var name: String
    @Attribute var desc: String
    @Attribute var date: String
    @Attribute var time: String
    @Attribute var loc: String
    @Attribute var lat: Double?
    @Attribute var lon: Double?
    
    init(n:String, d:String, da:String, t:String, l:String, lat:Double?, lon:Double?) {
        self.name = n
        self.desc = d
        self.date = da
        self.time = t
        self.loc = l
        self.lon = lon
        self.lat = lat
    }
}
