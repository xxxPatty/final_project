//
//  WebView.swift
//  final_project2
//
//  Created by 林湘羚 on 2021/1/2.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @State var link:String
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = URL(string: link) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    typealias UIViewType = WKWebView
}
struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(link:"")
    }
}
