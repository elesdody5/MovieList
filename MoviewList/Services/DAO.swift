//
//  DAO.swift
//  MoviewList
//
//  Created by Ahmed Elesdody on 4/8/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import Foundation
import CoreData
protocol DAO {
    func fetchCoreData(remote:Bool)->Array<NSManagedObject>
    func saveRemoteData(movieList:Array<Movie>)
    func deletePreviousList()
    func deleteMovieWithTitle(title:String)
    func fetchMovieWithTitle(title:String)->Array<NSManagedObject>

}
