//
//  ExpandableCell.swift
//  SectionalContactTableview
//
//  Created by Habib Durodola on 2020-03-01.
//  Copyright © 2020 doh. All rights reserved.
//

import Foundation


struct ExpandableCell {
    var isExpanded : Bool 
    let dataSourceInfo : [InnerDataSource]
}

struct InnerDataSource {
    var favourite: Bool
    let innerDataSource : [String]
}
