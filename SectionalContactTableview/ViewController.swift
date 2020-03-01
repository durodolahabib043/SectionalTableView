//
//  ViewController.swift
//  SectionalContactTableview
//
//  Created by Habib Durodola on 2020-03-01.
//  Copyright © 2020 doh. All rights reserved.
//

import UIKit

class ViewController: UIViewController  , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!

    let cellId = "tableCellIndentifier"

    let name = ["Abidemi" , "Adebayo" , "olayide", "Abidemi" , "Adebayo" , "olayide"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        // Do any additional setup after loading the view.
        navigationItem.title = "Contact"
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.name.count ;

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomTableViewCell

        cell.nameLabel.text = name[indexPath.row]
        return cell ;

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        let sectionName: String
        switch section {
            case 0:
                sectionName = "Name"
            case 1:
                sectionName = "Last Name"
            default:
                sectionName = "Nick Name"
        }
        return sectionName
    }


}

