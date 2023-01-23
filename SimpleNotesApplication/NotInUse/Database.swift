//
//  Database.swift
//  SimpleNotesApplication
//
//  Created by chirayu-pt6280 on 19/12/22.
//

import Foundation


class DataBase {
    
    var noteList:[Priority:[Notes]] = [.high:[Notes(title: "New note", content: "this is a new note a very new note", priority: .high),Notes(title: "New note", content: "this is a new note a very new note", priority: .high),Notes(title: "New note", content: "this is a new note a very new note", priority: .high),Notes(title: "New note", content: "this is a new note a very new note", priority: .high),Notes(title: "New note", content: "this is a new note a very new note", priority: .high),Notes(title: "New note", content: "this is a new note a very new note", priority: .high)],.medium:[Notes(title: "not so important", content: "jdkadksjflkfka;lkdal", priority: .medium),Notes(title: "not so important", content: "jdkadksjflkfka;lkdal", priority: .medium),Notes(title: "not so important", content: "jdkadksjflkfka;lkdal", priority: .medium),Notes(title: "not so important", content: "jdkadksjflkfka;lkdal", priority: .medium)]]
    
    static let sharedDb = DataBase()
    
    private init() {
        
    }
    
    
    func addNotes(_ title:String,_ content:String,_ priority:Priority) {
    
//        print("ASd")
        let note = Notes(title: title, content: content, priority: priority)
        
        guard noteList[priority] != nil else {
//            print("asd")
            noteList[priority] = [note]
            return
        }
        
        noteList[priority]?.append(note)
    
      
    }
}
