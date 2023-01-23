//
//  Notes.swift
//  SimpleNotesApplication
//
//  Created by chirayu-pt6280 on 19/12/22.
//

import Foundation


enum Priority:String,CaseIterable,Hashable,Codable {
    
    case pinned = "Pinned"

    case high = "Important"
    
    case medium = "Casual"
    

}

class Notes:Codable {
    
    
    let id:UUID
    var title:String
    var content:String
    let priority:Priority
    var createdOn:Date
    
    
    init(id:UUID,title:String,content:String,priority:Priority,date:Date) {
        
        self.id = id
        self.title = title
        self.content = content
        self.priority = priority
        self.createdOn = date
    }
    
   convenience init(title: String, content: String, priority: Priority) {
       self.init(
        id: UUID(),
        title: title,
        content: content,
        priority: priority,
        date: Date()
       )
    }
    
    
    
    
}




class DateFormatHelper {
    
    let dateFormatter = DateFormatter()
    
   static let shared = DateFormatHelper()
    
    private init() {
        
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        dateFormatter.timeZone = TimeZone(abbreviation: "PST")
        
    }
    
    func getDateFromString(_ value: String)->Date {
        
        return dateFormatter.date(from: value) ?? Date()
    }
    
    func getStringFromDate(_ date: Date)->String {
        
        return dateFormatter.string(from: date)
        
    }
    
    
}
