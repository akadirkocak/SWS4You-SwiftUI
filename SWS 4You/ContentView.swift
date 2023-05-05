//
//  ContentView.swift
//  SWS 4You
//
//  Created by SWS-Schueler IT on 25.04.23.
//

import SwiftUI
import WebKit
import Network

struct ContentView: View {
    
    @State private var isConnected = true
    
    var body: some View {
        VStack {
            if isConnected {
                WebView(url: URL(string: "https://4you.sws-shop.de")!)
                    .edgesIgnoringSafeArea(.bottom)
            } else {
                Text("Überprüfen Sie Ihre Verbindung und versuchen Sie es erneut.")
                    .padding()
            }
        }
        .onAppear {
            checkInternetConnection()
        }
    }
    
    func checkInternetConnection() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.isConnected = true
            } else {
                self.isConnected = false
            }
        }
        monitor.start(queue: queue)
    }
}

struct WebView: UIViewRepresentable {
    
    let url: URL
    
    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView()
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

