//
//  MovieListViewProtocole.swift
//  MoviewList
//
//  Created by Ahmed Elesdody on 4/8/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import Foundation
import CoreData
protocol MovieViewProtocole :AnyObject {
  func refreshData(json:Array<Dictionary<String,Any>>)
    func reloadTableView()
    func addRemoteMovie(movieEntity:NSManagedObject)
    func addLocalMovie(movieEntity:NSManagedObject)
}
