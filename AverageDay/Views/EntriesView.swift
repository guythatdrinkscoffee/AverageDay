//
//  EntriesView.swift
//  Average Day
//
//  Created by J Manuel Zaragoza on 4/26/22.
//

import SwiftUI

struct EntriesView: View {
    @State var dataStore = DataStore()
    @State var entries: [String:[Day]] = [:]
    
    var entriesThisMonth: [Day] {
        entries[.currentMonthString] ?? []
    }
    
    var body: some View {
        VStack {
            Text(String.currentMonthString.replacingOccurrences(of: "_", with: " "))
                .font(.largeTitle)
                .padding()
            Spacer()
            GridView(data: entriesThisMonth)
        }
        .frame(minWidth: 600, minHeight: 630)
        .onAppear {
            entries = dataStore.readEntries()
        }
    }
}

struct EntriesView_Previews: PreviewProvider {
    static var previews: some View {
        EntriesView()
    }
}

struct GridView: View {
    var data: [Day]
    
    var gridColumns: [GridItem] {
        [GridItem(.adaptive(minimum: 80, maximum: 80),spacing: 5)]
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns, spacing: 15) {
                ForEach(data, id: \.id) {
                    CalendarDayView(day: $0)
                }
            }
        }
    }
}

struct CalendarDayView: View {
    var day: Day
    
    var dateNumber : String {
        let components = Calendar.current.dateComponents([.year,.month,.day], from: day.date)
        return "\(components.day!)"
    }
    
    var body: some View {
        VStack {
            Text(dateNumber)
                    .frame(maxWidth:.infinity, alignment: .trailing)
                    .padding(10)
                    .font(.headline)
            Text(day.mood.moodText)
                .font(.system(size: 36))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(5)
        }
        .background()
        .border(.gray, width: 2)
    }
}
