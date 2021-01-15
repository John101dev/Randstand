//
//  WebView.swift
//  RandstandTest
//
//  Created by 愤怒大葱鸭 on 1/14/21.
//  Copyright © 2021 Randstand. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @State var urlStr: String

    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        if let url = URL(string: urlStr) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(urlStr: "")
    }
}
