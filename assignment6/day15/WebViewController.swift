//
//  WebViewController.swift
//  assignment6
//
//  Created by Sammy Jung on 2024/01/15.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    
    var urlStr: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: urlStr) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

}
