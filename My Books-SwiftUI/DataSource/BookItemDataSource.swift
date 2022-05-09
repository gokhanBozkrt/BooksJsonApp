//
//  BookItemDataSource.swift
//  CTHelpSPMMaster
//
//  Created by Stewart Lynch on 2019-06-28.
//  Copyright © 2019 CreaTECH Solutions. All rights reserved.
//

import UIKit

class BookItemDataSource: NSObject, ObservableObject {
    
    @Published var books = [BookItem]()
    @Published var selectedBook:BookItem?
    
    override init() {
        books = StorageFunctions.retrieveBooks()
    }
    
    func addBook(with title:String, author:String, notes:String = "") {
        let book = BookItem(title:title, author:author, notes: notes)
        books.append(book)
        saveBooks()
    }
    
    func saveBooks() {
        StorageFunctions.storeBooks(books: books)
    }
    
    func deleteBook(at indexSet:IndexSet) {
        books.remove(atOffsets: indexSet)
        saveBooks()
    }
    func updateBook(title: String, author:String, notes:String) {
        let index = books.firstIndex { $0.id == selectedBook!.id}
        books[index!].title = title
        books[index!].author = author
        books[index!].notes = notes
        selectedBook = books[index!]
        saveBooks()
    }
    func book(at index:Int) -> BookItem {
        return books[index]
    }
    
}
