//
//  MovieListPresenter.swift
//  MoviewList
//
//  Created by Ahmed Elesdody on 4/8/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import Foundation
import CoreData
class MovieListPresenter: MoviePresenterProtocole {
   
    
    
    private weak var view: MovieViewProtocole!
    private var coreDataService:CoreDataService?
    init(view: MovieViewProtocole,mangedConetxt:NSManagedObjectContext) {
        self.view = view
        coreDataService = CoreDataService(mangedConetxt: mangedConetxt)
        
    }

    func callApi(){
      NetworkService().queryAllMovies(completionHandler: self.view.refreshData(json:))
    }
    
    func checkInternet() -> Bool {
        if Reachability.isConnectedToNetwork(){
            return true
        }else{
            return false
        }
    }
    
   
    
    func addLocalData(){
        let remoteData :Array<NSManagedObject> = coreDataService!.fetchCoreData(remote: true)
        for movieEntity in remoteData {
           view.addRemoteMovie(movieEntity: movieEntity)
        }
      view.reloadTableView()
    }
    func fetchLocal(){
        var local :Array<NSManagedObject> = coreDataService!.fetchCoreData(remote: false)
        for movieEntity in local {
           view.addLocalMovie(movieEntity: movieEntity)
        }
        
        view.reloadTableView()
        
    }
    
 
    
    
    
    func saveRemoteData(movieList: Array<Movie>) {
        coreDataService?.saveRemoteData(movieList: movieList)
    }
    
    
    func deleteMovieWithTitle(title: String) {
        coreDataService?.deleteMovieWithTitle(title: title)
    }
    
   
    
}
