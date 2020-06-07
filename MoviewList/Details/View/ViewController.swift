//
//  ViewController.swift
//  MoviewList
//
//  Created by Ahmed Elesdody on 3/25/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleLabe: UILabel!
    
    @IBOutlet weak var generLabe: UILabel!
    @IBOutlet weak var ratingLabe: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!

    var movie:Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLabe.text = movie?.title
        yearLabel.text = movie?.realseYear
        generLabe.text = (movie?.genr[0])!
        ratingLabe.text = String(movie!.rate)
        let url = URL(string: movie!.img)
        imgView.kf.setImage(with: url)
       //movie?.setImageView(imgView: imgView)
    
    }


}

