//
//  ViewController.swift
//  Lession6 - exercise
//
//  Created by mai.dinh.chuong on 3/26/19.
//  Copyright © 2019 Sun-Asterisk Inc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class TableViewController: UIViewController {

    @IBOutlet weak var myTable: UITableView!
    var arrResponse = [[String : Any]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("https://api.androidhive.info/contacts/")
            .responseJSON
            { (response) in
                if ((response.result.value) != nil)
                {
                    let json = JSON(response.result.value!)
                    print(json)
                    if let responseData = json["contacts"].arrayObject
                    {
                        self.arrResponse = responseData as! [[String : Any]]
                    }
                    if self.arrResponse.count > 0
                    {
                        self.myTable.reloadData()
                    }
                }
            }
    }
}

extension TableViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        
        var dict = arrResponse[indexPath.row]
        
        cell.textLabel?.text = dict["name"] as? String
        cell.detailTextLabel?.text = dict["email"] as? String
        
        return cell
    }
    
    
}
