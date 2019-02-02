//
//  AddInfoViewController.swift
//  udacity-on-the-map
//
//  Created by 尾山昌太郎 on 2019/01/27.
//  Copyright © 2019年 尾山昌太郎. All rights reserved.
//

import UIKit


class AddInfoViewController: UIViewController {

    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var studentWeb: UITextField!
    @IBOutlet weak var findLocation: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //showOverWriteAlert()
        
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func findLocationButton(_ sender: Any) {
        print(address.text!)
        print(studentWeb.text!)
        UdacityClient.getSessionInfo(completion: handleRequestTokenResponse(success:error:))
        
    }
    
    func handleRequestTokenResponse(success: Bool, error: Error?) {
        if success {
            print("success")
        } else {
            print(error)
        }
    }
    
    func showOverWriteAlert() {
        let alertVC = UIAlertController(title: "Login Failed", message: "test", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
        
    }
    
}
