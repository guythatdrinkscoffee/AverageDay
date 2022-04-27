//
//  CalendarDayView.swift
//  Average Day
//
//  Created by J Manuel Zaragoza on 4/26/22.
//

import SwiftUI

struct CalendarDayView: View {
    @State var editAlert: Bool = false
    @State var day: Day
    
    var isDayToday: Bool {
        Calendar.current.isDateInToday(day.date)
    }
    
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
                    .foregroundColor(isDayToday ? .white : Color.primary)
            Text(day.mood.moodText)
                .font(.system(size: 36))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(5)

        }
        .background(isDayToday ? .blue : .white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.5), lineWidth: 2)
        )
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
