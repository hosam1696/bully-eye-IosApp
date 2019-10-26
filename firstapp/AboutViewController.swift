//
//  AboutViewController.swift
//  firstapp
//
//  Created by Hosam Elnabawy on 10/26/19.
//  Copyright © 2019 Hosam Elnabawy. All rights reserved.
//
import WebKit
import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var pageWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadWebView()
        
    }
    
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    
    func loadWebView() {
        if let url = Bundle.main.url(forResource: "BullsEys", withExtension: "html") {
            if let htmlData = try? Data(contentsOf: url) {
                let baseUrl = URL(fileURLWithPath: Bundle.main.bundlePath)
                pageWebView.load(htmlData, mimeType: "text/html", characterEncodingName: "utf-8", baseURL: baseUrl)
            } else {
                print("Error getting Data")
            }
        }
    }

}
