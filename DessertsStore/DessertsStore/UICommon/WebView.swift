//
//  WebView.swift
//  DessertsStore
//
//  Created by Manasa M on 8/9/24.
//

import SwiftUI

import WebKit
// web view helper to play the youtube video in our application
struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
