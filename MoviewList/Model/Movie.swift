//
//  Movie.swift
//  MoviewList
//
//  Created by Ahmed Elesdody on 3/25/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import UIKit
extension Movie{
    func setImageView(imgView:UIImageView){
        let imageURL = URL(fileURLWithPath:img)
        let image    = UIImage(contentsOfFile: imageURL.path)
        return imgView.image=image
    }
}
struct Movie {
    var title:String
    var img:String
    var rate:Float
    var realseYear:String
    var genr:[String]
    
}
