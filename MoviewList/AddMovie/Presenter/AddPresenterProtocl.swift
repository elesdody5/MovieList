//
//  AddPresenterProtocl.swift
//  MoviewList
//
//  Created by Ahmed Elesdody on 4/8/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import Foundation
protocol AddPresenterProtcol :AnyObject{
    func saveInDatabase(movie:Movie?)->Bool
}
