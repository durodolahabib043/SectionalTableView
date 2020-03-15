//
//  ViewController.swift
//  SectionalContactTableview
//
//  Created by Habib Durodola on 2020-03-01.
//  Copyright © 2020 doh. All rights reserved.
//

import UIKit

class ViewController: UIViewController  , UITableViewDelegate , UITableViewDataSource , CustomTableViewCellDelegate{



    @IBOutlet weak var tableView: UITableView!

    let cellId = "tableCellIndentifier"
    let headerId = "headerCellId"

    let section = ["Name" , "Last Name" , "Nick Name"]
    var isAnimated = false

    var ExpandableArray = [

        ExpandableCell(isExpanded: false, dataSourceInfo: [InnerDataSource(favourite: false, innerDataSource: [  "DS" ])]) // is maps to join
        ,
        ExpandableCell(isExpanded: false, dataSourceInfo: [InnerDataSource(favourite: false, innerDataSource: [  "Make"]),InnerDataSource(favourite: false, innerDataSource: [  "Luck"]), InnerDataSource(favourite: false, innerDataSource: [  "ted"]),InnerDataSource(favourite: false, innerDataSource: [  "phil"]),
                                                           InnerDataSource(favourite: false, innerDataSource: [  "Normal"]),
                                                           InnerDataSource(favourite: false, innerDataSource: [  "Power"])])
    ]
    override func viewDidLoad() {
        super.viewDidLoad()


        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: headerId)
        navigationItem.title = "Contact"
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
    }

    @objc func handleRightClick() {
        print("right animation")
        var indexPath = [IndexPath]()

        for section in section.indices {
            //  IndexPath (row: row, section: 0)
            for row in ExpandableArray.indices {
                indexPath.append(IndexPath(row: row, section: section))
            }

        }

        for isExpandedd in ExpandableArray {
            if (isExpandedd.isExpanded) {
                if (!isAnimated) {
                    tableView.reloadRows(at: indexPath, with: .right)
                    isAnimated = true
                }
                else {
                    tableView.reloadRows(at: indexPath, with: .left)
                    isAnimated = false
                }
            }
        }


    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (ExpandableArray[section].isExpanded){
            return 0
        }
        return self.ExpandableArray[section].dataSourceInfo.count ;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomTableViewCell
        cell.delegate = self
        cell.nameLabel.text = ExpandableArray[indexPath.section].dataSourceInfo[indexPath.row].innerDataSource[0]

        if (ExpandableArray[indexPath.section].dataSourceInfo[indexPath.row].favourite){
            cell.accessoryView?.tintColor = UIColor.red
        }
        else {
            cell.accessoryView?.tintColor =  UIColor.lightGray

        }
        return cell ;

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return ExpandableArray.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)

        //  button.addTarget(self, action: #selector(handleOpenClose), for: .touchUpInside)

        button.tag = section

        return button
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45;
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    @objc func handleOpenClose (btn: UIButton) {
        let section = btn.tag
        var cellIndex = [IndexPath]()

        for index in ExpandableArray.indices {
            cellIndex.append(IndexPath(row: index, section: section))
        }
        //
        let isExpanded = ExpandableArray[section].isExpanded // keep check of the expansion
        ExpandableArray[section].isExpanded = !isExpanded
        btn.setTitle(isExpanded ? "Open" : "Close", for: .normal)

        if (isExpanded){
            tableView.insertRows(at: cellIndex, with:  .fade);
        }
        else {
            tableView.deleteRows(at: cellIndex, with: .fade)
        }

    }
    func selectedFavourite(cell : UITableViewCell) {
        let selectedCell = tableView.indexPath(for: cell)
        guard let row = selectedCell?.row else {
            return
        }
        guard let section = selectedCell?.section else {
            return
        }
        let isFavourite = ExpandableArray[section].dataSourceInfo[row].favourite // check for favourite
        ExpandableArray[section].dataSourceInfo[row].favourite = !isFavourite
        if (isFavourite){
            cell.accessoryView?.tintColor = .lightGray
        }
        else {
            cell.accessoryView?.tintColor = .red
        }

        tableView.reloadRows(at: [selectedCell!], with: .fade)
    }
}

