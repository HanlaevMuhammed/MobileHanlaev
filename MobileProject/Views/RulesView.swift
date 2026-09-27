//
//  RulesView.swift
//  MobileProject
//

import SwiftUI
import WebKit

struct HTMLView: UIViewRepresentable {
    let fileName: String
    let fileExtension: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        loadHTML(into: webView)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    private func loadHTML(into webView: WKWebView) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            return
        }
        webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
    }
}

struct RulesView: View {
    var body: some View {
        HTMLView(fileName: "rules", fileExtension: "html")
            .navigationTitle(Strings.rulesTabTitle)
    }
}

#Preview {
    NavigationStack {
        RulesView()
    }
}
