//
//  DataBaseHelper.swift
//  SimpleNotesApplication
//
//  Created by chirayu-pt6280 on 16/01/23.
//

import Foundation
import SQLite3

class DataBaseHelper {
    
    var db:OpaquePointer?
    
    let filePath = "Notes.sqlite"
    
    init() {
        
        createDataBase()
    }
    
    
    func createDataBase() {
        
        let fileUrl =  try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appending(path: filePath)
        print(fileUrl)
        
        if sqlite3_open(fileUrl.path(),&db) == SQLITE_OK {
            
            print("successfully created")
            
        }
        
    }
    
    func createTable() {
        
        let createTableString = "CREATE TABLE IF NOT EXISTS notes(UUID TEXT PRIMARY KEY ,TITLE TEXT,CONTENT TEXT,PRIORITY TEXT,DATE TEXT)"
        
        let dropTable = "DROP TABLE notes"
        
        var stmt:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db,createTableString, -1, &stmt, nil) == SQLITE_OK {
          
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("table created successfully")
            } else {
                print("cannot create table")
            }
            
        }
        
        sqlite3_finalize(stmt)
    }
    
    func insertNotes(_ notes:Notes) {
        
        print(#function)
        
        let insertNotesString = "INSERT INTO notes(UUID,TITLE,CONTENT,PRIORITY,DATE) VALUES(?,?,?,?,?)"
        
        var stmt:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertNotesString, -1, &stmt, nil) == SQLITE_OK {
            
            sqlite3_bind_text(stmt, 1, (notes.id.uuidString as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 2,(notes.title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 3, (notes.content as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 4, (notes.priority.rawValue as NSString).utf8String, -1, nil)
//            sqlite3_bind_int(stmt,5, Int32(notes.createdOn.timeIntervalSince1970))
//            sqlite3_bind_double(stmt,5, notes.createdOn.timeIntervalSince1970)
            sqlite3_bind_text(stmt,5,(DateFormatHelper.shared.getStringFromDate(notes.createdOn) as NSString).utf8String,-1,nil)
            
           if  sqlite3_step(stmt) == SQLITE_DONE {
                
               print("successfully inserted")
           } else {
               print("unable to insert data")
           }
            
            sqlite3_finalize(stmt)
            
        }
        
    }
    
    func readNotes()->[Priority:[Notes]] {
        
        print(#function)
        let readNotesString = "SELECT * FROM notes"
        
        var notes:[Priority:[Notes]] = [.pinned:[],.high:[],.medium:[]]
        
        var stmt:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, readNotesString, -1, &stmt, nil) == SQLITE_OK {
            
            while sqlite3_step(stmt) == SQLITE_ROW {
        
                let id = String(cString: sqlite3_column_text(stmt, 0))
                let title = String(cString: sqlite3_column_text(stmt, 1))
                let content = String(cString: sqlite3_column_text(stmt, 2))
                let priority = String(cString: sqlite3_column_text(stmt, 3))
//                let date = sqlite3_column_double(stmt,4)
                let date = String(cString: sqlite3_column_text(stmt, 4))
                
                let note = Notes(id: UUID(uuidString: id) ?? UUID(), title: title, content: content, priority: Priority(rawValue: priority) ?? .medium, date: DateFormatHelper.shared.getDateFromString(date))
                notes[note.priority]?.append(note)
            }
            
        }
        
        sqlite3_finalize(stmt)
        
        return notes
    }
    
    func deleteNotes(_ uuid:UUID) {
        
        
        print(#function)
        
        let deleteTableString = "DELETE FROM notes WHERE UUID = ?"
        
        var  stmt:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, deleteTableString, -1, &stmt, nil) == SQLITE_OK {
            
            print("okay")
            sqlite3_bind_text(stmt,1,(uuid.uuidString as NSString).utf8String, -1, nil)
            
         if  sqlite3_step(stmt) == SQLITE_DONE {
                 
             print("rows successfully deleted")
             
            }
        }
        
        sqlite3_finalize(stmt)
    }
}
