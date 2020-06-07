//
//  NetworkService.swift
//  MoviewList
//
//  Created by Ahmed Elesdody on 4/8/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import Foundation
class NetworkService{
    
    public func queryAllMovies(completionHandler : @escaping (_ json:Array<Dictionary<String,Any>>) -> Void ) {

        let url = URL(string: "http://api.androidhive.info/json/movies.json")
        let request  = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request){
            (data,response,error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Array<Dictionary<String,Any>>
                DispatchQueue.main.async {
                    completionHandler(json)
                    print("fetch data")
                }
            } catch{
                print(error)
            }
        }
        task.resume()
    }
}
