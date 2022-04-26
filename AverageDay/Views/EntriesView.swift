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
