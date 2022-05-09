//
//  SingleBookView.swift
//  PagerVC
//
//  Created by Stewart Lynch on 2019-12-21.
//  Copyright © 2019 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct SingleBookView: View {
    @EnvironmentObject var myBooks:BookItemDataSource
    @Environment(\.presentationMode) var presentationMode
    @State private var editNote = false

    
    var body: some View {
        NavigationView {
                VStack(spacing: 20) {
                    Text(myBooks.selectedBook?.author ?? "Author")
                        .font(.title)
                    Text(myBooks.selectedBook?.notes ?? "Notes").font(.callout)
                        .foregroundColor(Color.primary)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5)
                        .padding()
                    Button(action: {
                        self.editNote = true
                    }) {
                        Text("Edit")
                    }
                    .padding(.horizontal)
                    .padding(.vertical,5)
                    .background(Color.blue)
                    .cornerRadius(5)
                    .foregroundColor(.white)
                    Spacer()

            }
            .navigationBarTitle(self.myBooks.selectedBook?.title ?? "Book Title")
            .navigationBarItems(leading: Button("Dismiss") {
                self.myBooks.selectedBook = nil
                self.presentationMode.wrappedValue.dismiss()
                }
                .sheet(isPresented: self.$editNote) {
                    NewEditBookView().environmentObject(self.myBooks)
            })
        }
    }
}

struct SingleBookView_Previews: PreviewProvider {
    static var previews: some View {
        SingleBookView().environmentObject(BookItemDataSource())
    }
}
