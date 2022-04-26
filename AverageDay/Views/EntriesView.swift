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
            GridView(data: entriesThisMonth) { updatedDay in
                let entriesForThisMonth = entries[.currentMonthString]
                
                if var thisMonthsEntries = entriesForThisMonth {
                    let index = entriesForThisMonth?.firstIndex(where: {$0.id == updatedDay.id})
                    
                    if let index = index {
                        thisMonthsEntries[index] = updatedDay
                        entries[.currentMonthString] = thisMonthsEntries
                        saveEntries()
                    }
                }
                
            }
        }
        .frame(minWidth: 600, minHeight: 630)
        .onAppear {
            entries = dataStore.readEntries()
        }
    }
    
    func saveEntries(){
        dataStore.save(entries: entries)
    }
}

struct EntriesView_Previews: PreviewProvider {
    static var previews: some View {
        EntriesView()
    }
}

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
        }
    }
}

struct CalendarDayView: View {
    @State var editAlert: Bool = false
    @State var day: Day
    
    var updatedDayHandler: ((Day) -> Void)
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
        .onTapGesture {
            editAlert.toggle()
        }
        .popover(isPresented: $editAlert) {
            HStack {
                ForEach(Mood.allCases, id: \.self) { mood in
                    Button {
                        day.mood = mood
                        updatedDayHandler(day)
                    } label: {
                        Text(mood.moodText)
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .frame(width: 50, height: 50)
                    .background(day.mood == mood ? Color.blue: Color.gray.opacity(0.5))
                    .clipShape(Circle())
                    .buttonStyle(PlainButtonStyle())
                    .padding(5)
                }
            }
        }
    }
}
