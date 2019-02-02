//
//  LinkedInViewController.swift
//  udacity-on-the-map
//
//  Created by 尾山昌太郎 on 2019/01/27.
//  Copyright © 2019年 尾山昌太郎. All rights reserved.
//

import UIKit
import WebKit

class LinkedInViewController: UIViewController {

    @IBOutlet weak var linkedInPage: WKWebView!
    var webURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let urlRequest = URLRequest(url:URL(string:webURL ?? "http://google.com")!)
        linkedInPage.load(urlRequest)
        view.addSubview(linkedInPage)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
