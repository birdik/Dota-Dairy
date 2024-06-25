//
//  WebView.swift
//  Dota Dairy
//
//  Created by birdik on 19.06.2024.
//

import SwiftUI
import WebKit


struct WebView: View {
    @AppStorage("link") var link: String = ""
    @State var urlLink: String = ""
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea(.all, edges: .all)
            if !urlLink.isEmpty {
                WebViewRepresentable(url: URL(string: urlLink)!)
                    .ignoresSafeArea(.all, edges: .all)
            }
        }
        .onAppear {
            getRequest()
        }
    }
    
    private func getRequest() {
        
        getFirebaseData(field: "isChangeAllURL", dataType: .bool) { isAllChangeURL in
            
            let isAllChangeURL = isAllChangeURL as? Bool ?? false
            
            getFirebaseData(field: "url_link", dataType: .url) { urlLinkTemp in
                
                let urlLink = urlLinkTemp as? String  ?? "https://google.com"
                
                if isAllChangeURL {
                    self.urlLink = urlLink
                    self.link = urlLink
                } else {
                    if link.isEmpty {
                        self.urlLink = urlLink
                        self.link = urlLink
                    } else {
                        self.urlLink = self.link
                    }
                }
            }
        }
    }
}

struct WebViewRepresentable: UIViewRepresentable {
    
    let url: URL
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebViewRepresentable
        var isLoad = false
        var timer: Timer?
        
        init(parent: WebViewRepresentable) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            isLoad = false
            timer?.invalidate()
            timer = nil

            // Запуск таймера на 5 секунд
            timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
                guard let self = self else { return }
                if !isLoad {
                    print("Страница не загрузилась")
                }
            }
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            isLoad = true
            timer?.invalidate()
            timer = nil
            HTTPCookieStorage.shared.saveCookies()
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            timer?.invalidate()
            timer = nil
            isLoad = false
            print("Page load failed: \(error.localizedDescription)")
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            timer?.invalidate()
            timer = nil
            isLoad = false
            print("Page load failed: \(error.localizedDescription)")
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero, configuration: makeWebViewConfiguration())
        webView.navigationDelegate = context.coordinator
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.contentInset = .zero
        webView.scrollView.scrollIndicatorInsets = .zero
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = true

        
        HTTPCookieStorage.shared.loadCookies { cookies in
            for cookie in cookies {
                webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
            }
            webView.load(URLRequest(url: self.url))
        }
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
    
    private func makeWebViewConfiguration() -> WKWebViewConfiguration {
        let configuration = WKWebViewConfiguration()
        configuration.websiteDataStore = .default()
        return configuration
    }
    
}

extension HTTPCookieStorage {
    private static let cookiesKey = "savedCookies"
    
    func saveCookies() {
        print("SaveCookies")
        let cookies = cookies ?? []
        let cookieData = cookies.compactMap { try? NSKeyedArchiver.archivedData(withRootObject: $0, requiringSecureCoding: false) }
        UserDefaults.standard.set(cookieData, forKey: HTTPCookieStorage.cookiesKey)
    }
    
    func loadCookies(completion: @escaping ([HTTPCookie]) -> Void) {
        guard let cookiesData = UserDefaults.standard.array(forKey: HTTPCookieStorage.cookiesKey) as? [Data] else {
            completion([])
            return
        }
        
        let cookies = cookiesData.compactMap { try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData($0) as? HTTPCookie }
        completion(cookies)
        
    }
}

#Preview {
    WebView()
}
