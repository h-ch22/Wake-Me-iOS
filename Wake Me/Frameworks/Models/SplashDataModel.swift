//
//  SplashDataModel.swift
//  Wake Me
//
//  Created by Changjin Ha on 11/4/24.
//

import Foundation
import SwiftData

@Model
class SplashDataModel {
    @Attribute(.unique) var isFirst: Bool
    
    init(isFirst: Bool) {
        self.isFirst = isFirst
    }
}
