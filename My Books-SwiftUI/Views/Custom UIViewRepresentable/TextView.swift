//
//  TextView.swift
//  MultiLine TextField
//
//  Created by Stewart Lynch on 10/29/19.
//  Copyright © 2019 Stewart Lynch. All rights reserved.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    var placeholderText: String
    @Binding var text:String
    typealias UIViewType = UITextView
    func makeUIView(context: UIViewRepresentableContext<TextView>) -> UITextView {
        let textView = UITextView()
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = padding
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.text = placeholderText
        textView.textColor = .placeholderText
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = borderColor.cgColor
        textView.layer.cornerRadius = 5
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<TextView>) {
        if !text.isEmpty || uiView.textColor == .label {
            uiView.text = text
            uiView.textColor = .label
        }
        uiView.delegate = context.coordinator
    }
    
    func frame(numLines: CGFloat) -> some View {
        let height = UIFont.systemFont(ofSize: 17).lineHeight * numLines + 20
        return self.frame(height: height)
        
    }
    
    func makeCoordinator() -> TextView.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView
        
        init(_ parent:TextView) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == .placeholderText {
                textView.text = ""
                textView.textColor = .label
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = parent.placeholderText
                textView.textColor = .placeholderText
            }
        }
    }
}

