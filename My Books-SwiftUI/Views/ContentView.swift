//
//  ContentView.swift
//  PagerVC
//
//  Created by Stewart Lynch on 2019-12-20.
//  Copyright © 2019 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    enum Action {
        case more, addBook
    }
    @State private var performAction = false
    @State private var actionType:Action?
    @EnvironmentObject var myBooks:BookItemDataSource
    
    var body: some View {
        NavigationView {
                VStack {
                    List() {
                        ForEach(myBooks.books) { book in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(book.title)").font(.headline)
                                    Text("\(book.author)").font(.caption)
                                }
                                Spacer()
                                Button(action: {
                                    self.actionType = .more
                                    self.myBooks.selectedBook = book
                                    self.performAction = true
                                }) {
                                    Text("More").padding(.horizontal)
                                        .padding(.vertical,5)
                                        .background(Color.blue)
                                        .cornerRadius(5)
                                        .foregroundColor(.white)
                                }.buttonStyle(BorderlessButtonStyle()) // This focusses tap on the button and not the row
                            }
                        }
                        .onDelete { (indexSet) in
                            self.myBooks.deleteBook(at: indexSet)
                        }
                    }
                    .sheet(isPresented: $performAction) {
                        if self.actionType == .more {
                            SingleBookView().environmentObject(self.myBooks)
                        } else {
                            NewEditBookView().environmentObject(self.myBooks)
                        }
                    }
            }
            .navigationBarTitle("My Books")
            .navigationBarItems(trailing:
                    Button(action: {
                        self.actionType = .addBook
                        self.performAction.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                    }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(BookItemDataSource())
    }
}



