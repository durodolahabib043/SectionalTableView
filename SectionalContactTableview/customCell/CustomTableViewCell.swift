//
//  CustomTableViewCell.swift
//  SectionalContactTableview
//
//  Created by Habib Durodola on 2020-03-01.
//  Copyright © 2020 doh. All rights reserved.
//

import UIKit

protocol CustomTableViewCellDelegate {
    func selectedFavourite(cell : UITableViewCell)
    
}

class CustomTableViewCell: UITableViewCell {
    var delegate: CustomTableViewCellDelegate? = nil

    
    @IBOutlet weak var nameLabel: UILabel!
        override func awakeFromNib() {
        super.awakeFromNib()
        let starButton = UIButton(type: .system)
        starButton.setImage(#imageLiteral(resourceName: "fav_star"), for: .normal)
        starButton.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        starButton.tintColor = .red
        starButton.addTarget(self, action: #selector(handleClick), for: .touchUpInside)
        accessoryView = starButton

    }
    @objc func handleClick() {
        print("handleClick")
        
        if self.delegate != nil {
            self.delegate?.selectedFavourite( cell: self)
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
