//
//  DetailView.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/08/20.
//

import SwiftUI
import WebKit

struct DetailView: View {
    
    var url: URL
    var title: String
    
    var body: some View {
        WebView(url: url)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct WebView: UIViewRepresentable {
 
    var url: URL
 
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: URL(string: "https://www.example.com")!, title: "Example")
    }
}
