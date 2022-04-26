//
//  DayDataStore.swift
//  Average Day
//
//  Created by J Manuel Zaragoza on 4/25/22.
//

import Foundation

struct DataStore {
    func getFileURL () -> URL? {
        
        do {
            let documentsFolder = try  FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let folderURL = documentsFolder.appendingPathComponent("AverageDay_Days.json")
            return folderURL
        } catch {
            print("Failed to retrive the url : \(error.localizedDescription)")
            return nil
        }
    }
    
    func readEntries() -> [String: [Day]] {
        guard let url = getFileURL() else {return [:]}
        
        do {
            let data = try Data(contentsOf: url)
            let entries = try JSONDecoder().decode([String: [Day]].self, from: data)
            return entries
        } catch {
            print("Failed to read: \(error.localizedDescription)")
            return [:]
        }
    }
    
    func save(entries: [String: [Day]]) {
        guard let url = getFileURL(), let data = try? JSONEncoder().encode(entries) else {
            return
        }
        
        do {
            try data.write(to: url)
        } catch {
            print("Failed to saved: \(error.localizedDescription)")
        }
    }
}
