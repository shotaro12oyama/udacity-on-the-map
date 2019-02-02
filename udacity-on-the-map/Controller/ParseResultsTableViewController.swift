//
//  ParseResultsTableViewController.swift
//  udacity-on-the-map
//
//  Created by 尾山昌太郎 on 2019/01/24.
//  Copyright © 2019 尾山昌太郎. All rights reserved.
//

import UIKit

class ParseResultsTableViewController: UITableViewController {
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ParseClient.requestStudentInfoList() { parseResult, error in
            ParseClient.parse = parseResult
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ParseClient.parse.count

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "parseListIdentifier", for: indexPath)

        // Configure the cell...
        let parseList = ParseClient.parse[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = parseList.firstName
        cell.imageView?.image = UIImage(named: "icon_pin")
        cell.detailTextLabel?.text = parseList.mediaURL
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "LinkedInViewController") as! LinkedInViewController
        let parseList = ParseClient.parse[(indexPath as NSIndexPath).row]
        detailController.webURL = parseList.mediaURL
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    @IBAction func touchLogoutButton(_ sender: Any) {
        UdacityClient.requestLogOut() { success, error in
            if success {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                print(error!)
            }
        }
    }

}
