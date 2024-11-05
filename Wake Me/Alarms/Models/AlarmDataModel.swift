//
//  AlarmDataModel.swift
//  Wake Me
//
//  Created by Changjin Ha on 11/4/24.
//

import Foundation

struct AlarmDataModel: Hashable {
    let id = UUID()
    let label: String
    let time: String
    let repeatDayOfWeek: [Int]
    let sound: String
    let type: AlarmTypeModel
    var isOn: Bool
    
    init(label: String, time: String, repeatDayOfWeek: [Int], sound: String, type: AlarmTypeModel, isOn: Bool = true) {
        self.label = label
        self.time = time
        self.repeatDayOfWeek = repeatDayOfWeek
        self.sound = sound
        self.type = type
        self.isOn = isOn
    }
}
