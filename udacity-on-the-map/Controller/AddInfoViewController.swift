//
//  AddInfoViewController.swift
//  udacity-on-the-map
//
//  Created by 尾山昌太郎 on 2019/01/27.
//  Copyright © 2019年 尾山昌太郎. All rights reserved.
//

import UIKit
import CoreLocation




class AddInfoViewController: UIViewController {

    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var studentWeb: UITextField!
    @IBOutlet weak var findLocation: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        address.text = ""
        studentWeb.text = ""
    }

    @IBAction func findLocationButton(_ sender: Any) {
        if address.text == "" || studentWeb.text == "" {
            showEmptyFieldAlert()
        } else {
            UdacityClient.getPublicUserInfo(completionHandler: handlePublicInfoResponse(success:error:))
            ParseClient.getStudentLocationInfo(key: UdacityClient.Auth.key, completionHandler: handleRequestResponse(result:error:))
        }
    }
    
    func handleRequestResponse(result: ParseClient.registerStatus?, error: Error?) {
        Locations.setLocations(address: self.address.text!, userName: UdacityClient.PublicInfo.firstName!, mediaURL: self.studentWeb.text!)
        if result == ParseClient.registerStatus.registered {
            DispatchQueue.main.async {
                Locations.setHttpMethod(httpMethod: "PUT")
                self.showOverWriteAlert()
                self.performSegue(withIdentifier: "putConfirmLocation", sender: nil)
            }
        } else if result == ParseClient.registerStatus.unregistered {
            DispatchQueue.main.async {
                Locations.setHttpMethod(httpMethod: "POST")
                self.performSegue(withIdentifier: "postConfirmLocation", sender: nil)
            }
        } else {
            print (error!)
        }
    }
    
    
    func handlePublicInfoResponse(success: Bool, error: Error?) {
        if success {
            print("successfully get public info")
        } else {
            print("could not get public info")
            print(error)
        }
    }

    
    func showOverWriteAlert() {
        let alertVC = UIAlertController(title: "Do you want to overwrite?", message: "Record is detected!", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func showEmptyFieldAlert() {
        let alertVC = UIAlertController(title: "Field is Empty", message: "Please fill your information!", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }


    
}


