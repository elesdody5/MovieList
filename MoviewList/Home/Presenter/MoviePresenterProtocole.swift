//
//  MoviePresenterProtocole.swift
//  MoviewList
//
//  Created by Ahmed Elesdody on 4/8/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import Foundation
import CoreData
protocol MoviePresenterProtocole : AnyObject {
    
   func callApi()
    func checkInternet() -> Bool
    func fetchLocal()
    func addLocalData()
    func saveRemoteData(movieList:Array<Movie>)
    func deleteMovieWithTitle(title:String)
    }
