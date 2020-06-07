//
//  LocalData.swift
//  MoviewList
//
//  Created by Ahmed Elesdody on 4/8/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import Foundation
import CoreData
class CoreDataService :DAO{
    var mangedConetxt:NSManagedObjectContext!
    init(mangedConetxt:NSManagedObjectContext) {
        self.mangedConetxt = mangedConetxt
    }
    func fetchCoreData(remote:Bool)->Array<NSManagedObject>{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
        let predicate = NSPredicate(format: "remote == %@", NSNumber(value: remote))
        fetchRequest.predicate = predicate
        do{
            return try (mangedConetxt?.fetch(fetchRequest))!
        }
        catch let error as NSError{
            print(error.localizedDescription)
            return Array<NSManagedObject>()
        }
    }
    func saveRemoteData(movieList:Array<Movie>){
        deletePreviousList()
        let entity = NSEntityDescription.entity(forEntityName: "MovieEntity", in: mangedConetxt!)
        
        for movie in movieList {
            let movieEntity = NSManagedObject(entity: entity!, insertInto: mangedConetxt)
            movieEntity.setValue(movie.title, forKey: "title")
            movieEntity.setValue(movie.img, forKey: "imgUrl")
            movieEntity.setValue(movie.realseYear, forKey: "year")
            movieEntity.setValue(movie.rate, forKey: "rate")
            movieEntity.setValue(movie.genr[0], forKey: "genr")
            movieEntity.setValue(true, forKey: "remote")
            do{
                try mangedConetxt!.save()
            }
            catch let error as NSError{
                print(error.description)
            }
        }
        
    }
    
    func deletePreviousList(){
        let remoteData :Array<NSManagedObject> = fetchCoreData(remote: true)
        for movie in remoteData {
            mangedConetxt?.delete(movie)
            do{
                try mangedConetxt!.save()
            }
            catch let error as NSError{
                print(error.description)
            }
        }
    }
    func deleteMovieWithTitle(title:String){
        let movies :Array<NSManagedObject> = fetchMovieWithTitle(title: title)
        for movie in movies {
            mangedConetxt?.delete(movie)
            do{
                try mangedConetxt!.save()
            }
            catch let error as NSError{
                print(error.description)
            }
        }
    }
    
    
    
    func fetchMovieWithTitle(title:String)->Array<NSManagedObject>{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
        let predicate = NSPredicate(format: "title == %@", title)
        fetchRequest.predicate = predicate
        do{
            return try (mangedConetxt?.fetch(fetchRequest))!
        }
        catch let error as NSError{
            print(error.localizedDescription)
            return Array<NSManagedObject>()
        }
    }
    
    
}
