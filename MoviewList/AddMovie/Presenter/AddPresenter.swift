//
//  AddPresenter.swift
//  MoviewList
//
//  Created by Ahmed Elesdody on 4/8/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import Foundation
import CoreData
class AddPresenter: AddPresenterProtcol {
    var mangedConetxt:NSManagedObjectContext!
    init(mangedConetxt:NSManagedObjectContext) {
        self.mangedConetxt = mangedConetxt
        
    }
    func saveInDatabase(movie:Movie?)->Bool{
        let entity = NSEntityDescription.entity(forEntityName: "MovieEntity", in: mangedConetxt!)
        
        
        let movieEntity = NSManagedObject(entity: entity!, insertInto: mangedConetxt)
        movieEntity.setValue(movie?.title, forKey: "title")
        movieEntity.setValue(movie?.img, forKey: "imgUrl")
        movieEntity.setValue(movie?.realseYear, forKey: "year")
        movieEntity.setValue(movie?.rate, forKey: "rate")
        movieEntity.setValue(movie!.genr[0], forKey: "genr")
        movieEntity.setValue(false, forKey: "remote")
        do{
            try mangedConetxt!.save()
        }
        catch let error as NSError{
            print(error.description)
            return false
        }
        
        return true
    }
}
