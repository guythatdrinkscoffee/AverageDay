//
//  GridView.swift
//  Average Day
//
//  Created by J Manuel Zaragoza on 4/26/22.
//

import SwiftUI

struct GridView: View {
    var data: [Day]
    
    var dayUpdatedHandler: ((Day) -> Void)
    
    var gridColumns: [GridItem] {
        [GridItem(.adaptive(minimum: 80, maximum: 80),spacing: 5)]
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns, spacing: 15) {
                ForEach(data, id: \.id) { entry in
                    CalendarDayView(day: entry) { updatedDay in
                        dayUpdatedHandler(updatedDay)
                    }
                }
            }
            .padding(.top, 10)
        }
    }
}

