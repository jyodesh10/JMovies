//
//  YoutubePlayer.swift
//  JMovies
//
//  Created by Jyodesh Shakya on 22.06.26.
//

import SwiftUI
import WebKit

struct YoutubePlayer: UIViewRepresentable {
    let videoID: String

    func makeUIView(context: Context) -> WKWebView {
            let configuration = WKWebViewConfiguration()
            configuration.allowsInlineMediaPlayback = true
            configuration.mediaTypesRequiringUserActionForPlayback = []
            
            let webView = WKWebView(frame: .zero, configuration: configuration)
            webView.scrollView.isScrollEnabled = false
            
            // 1. We match the iframe domain and append the native &origin parameter
            let embedDomain = "https://www.youtube-nocookie.com"
            
            let htmlTemplate = """
            <!DOCTYPE html>
            <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
                <style>
                    body, html { margin: 0; padding: 0; width: 100%; height: 100%; background-color: black; overflow: hidden; }
                    iframe { border: none; width: 100%; height: 100%; }
                </style>
            </head>
            <body>
                <iframe 
                    src="\(embedDomain)/embed/\(videoID)?playsinline=1&modestbranding=1&rel=0&origin=\(embedDomain)" 
                    title="YouTube video player" 
                    frameborder="0" 
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
                    referrerpolicy="strict-origin-when-cross-origin"
                    allowfullscreen>
                </iframe>
            </body>
            </html>
            """
            
            // 2. CRITICAL FIX FOR 152-4: The baseURL must exactly match the domain used above.
            // This prevents YouTube's "bait" security scripts from flagging a referrer mismatch.
            if let baseURL = URL(string: embedDomain) {
                webView.loadHTMLString(htmlTemplate, baseURL: baseURL)
            }
            
            return webView
        }

        func updateUIView(_ uiView: WKWebView, context: Context) {
            // Left intentionally blank to prevent the infinite redraw white screen loop
        }
}
