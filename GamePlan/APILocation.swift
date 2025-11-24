//
//  APILocation.swift
//  GamePlan
//
//  Created by Diego Borgo on 11/22/25.
//

import Foundation
import SwiftUI

struct APILocation: Identifiable {
    var id = UUID()
    var name = String()
    var desc = String()
    var date = String()
    var time = String()
    var loc = String()
}
