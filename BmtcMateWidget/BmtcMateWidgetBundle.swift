//
//  BmtcMateWidgetBundle.swift
//  BmtcMateWidget
//
//  Created by Vasu Deshpande on 10/06/23.
//

import WidgetKit
import SwiftUI

@main
struct BmtcMateWidgetBundle: WidgetBundle {
    var body: some Widget {
        BmtcMateWidget()
        LiveBusActivityWidget()
    }
}
