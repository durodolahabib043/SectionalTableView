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
    var dataSourceInfo : [InnerDataSource]
}

struct InnerDataSource {
    var favourite: Bool
    var innerDataSource : [String]
}
