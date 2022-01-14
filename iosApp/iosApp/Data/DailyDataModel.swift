//
//  DailyDataModel.swift
//  iosApp
//
//  Created by Danang Wijaya on 12/01/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import Foundation
import shared
// MARK: - Daily
struct Daily: Identifiable {
    let id = UUID()
    var data : DailyData?
}

