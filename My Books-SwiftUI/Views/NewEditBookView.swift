//
//  NewBook.swift
//  PagerVC
//
//  Created by Stewart Lynch on 2019-12-21.
//  Copyright © 2019 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct NewEditBookView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var myBooks:BookItemDataSource
    @State private var title:String = ""
    @State private var author:String = ""
    @State private var notes: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Book Information")) {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    // Custom Textview to get around multi-line TextField
                    TextView(placeholderText: "Note", text: $notes).frame(numLines: 25)
                }
            }.onAppear(perform: {
                if let selectedBook = self.myBooks.selectedBook {
                    self.title = selectedBook.title
                    self.author = selectedBook.author
                    self.notes = selectedBook.notes
                }
            })
        
                .navigationBarTitle(self.myBooks.selectedBook == nil ? "New Book" : "Edit Book", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                if self.myBooks.selectedBook == nil {
                    // add new book
                    self.myBooks.addBook(with: self.title, author: self.author, notes: self.notes)
                     self.myBooks.selectedBook = nil
                } else {
                    // update book
                    self.myBooks.updateBook(title: self.title,
                                            author: self.author,
                                            notes: self.notes)
                }
               
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
                    .disabled(self.title == "" || self.author == "")
            })
        }
    }
}

struct NewEditBookView_Previews: PreviewProvider {
    static var previews: some View {
        NewEditBookView().environmentObject(BookItemDataSource())
    }
}
