//
//  MovieListTableViewController.swift
//  MoviewList
//
//  Created by Ahmed Elesdody on 3/25/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData
class MovieListTableViewController:UIViewController, UITableViewDelegate,UITableViewDataSource ,AddDelegation,MovieViewProtocole{
    
    
   
    
    
  
    
  
    
    @IBOutlet weak var indicatoin: UIActivityIndicatorView!
    var remoteMovieList:Array<Movie>?
    var localMovie:Array<Movie>?
    @IBOutlet weak var tableView: UITableView!
     private var presenter :MoviePresenterProtocole?
    
    override func viewDidLoad() {
        super.viewDidLoad()
          var appDeleate:AppDelegate = (UIApplication.shared.delegate as!AppDelegate)
        var mangedConetxt:NSManagedObjectContext = appDeleate.persistentContainer.viewContext
        presenter = MovieListPresenter(view: self, mangedConetxt: mangedConetxt)
        
        tableView.rowHeight = 140
        remoteMovieList=Array<Movie>()
        localMovie=Array<Movie>()
        tableView.isHidden = true
        if presenter!.checkInternet(){
            presenter!.callApi()
            
        }
        else {
            // fetch movies stored from api in coredata
            presenter!.addLocalData()
        }
        // fetch local data
        presenter!.fetchLocal()
        
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section==0){
            return remoteMovieList!.count
        }
        else{
            return localMovie!.count
        }
        
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableCell
        var movie:Movie?
        if indexPath.section==0
        {
            movie = remoteMovieList![indexPath.row]
            let url = URL(string: movie!.img)
            cell.poster.kf.setImage(with: url)
        }
        else {
            movie = localMovie![indexPath.row]
            let dataDecoded:NSData = NSData(base64Encoded: movie!.img, options: .ignoreUnknownCharacters)!
            let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
            cell.poster.image = decodedimage
        }
        
        cell.nameLable?.text = movie!.title
        cell.relaseYearLabe?.text = movie!.realseYear
        // sqllite3
//            let imageURL = URL(fileURLWithPath:movie.img)
//            let image    = UIImage(contentsOfFile: imageURL.path)
//            // Do whatever you want with the image
//            cell.poster.image = image
     
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details:ViewController = storyboard?.instantiateViewController(withIdentifier: "detailsView") as! ViewController
        details.movie = remoteMovieList![indexPath.row]
        navigationController?.pushViewController(details, animated: true)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section==0{
            return "Remote Data"
        }
        else {
            return "Local Data"
        }
    }
    
    // Override to support editing the table view.
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var title:String?
            if indexPath.section==0{
                title = remoteMovieList![indexPath.row].title
                remoteMovieList?.remove(at: indexPath.row)
            }
            else{
                title = localMovie![indexPath.row].title
                localMovie?.remove(at: indexPath.row)

            }
            presenter!.deleteMovieWithTitle(title: title!)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func addMovie(_  movie: Movie) {
        localMovie?.append(movie)
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addView :AddViewController = segue.destination as! AddViewController
            addView.addDelegete = self
        
    }
   
    func refreshData(json:Array<Dictionary<String,Any>>){
        for jsonObj in json {
            var rate :NSNumber = jsonObj["rating"] as! NSNumber
            var year :NSNumber = jsonObj["releaseYear"] as! NSNumber
            remoteMovieList?.append(Movie(title: jsonObj["title"] as! String, img: jsonObj["image"] as! String, rate: rate.floatValue, realseYear: year.stringValue, genr: jsonObj["genre"] as! [String]))
        }
        reloadTableView()
        presenter!.saveRemoteData(movieList: remoteMovieList!)
    }
 
  
    
  
    
  
    
    func addRemoteMovie(movieEntity:NSManagedObject)  {
        remoteMovieList?.append(Movie(title: movieEntity.value(forKey: "title") as! String, img: movieEntity.value(forKey: "imgUrl") as! String, rate: movieEntity.value(forKey: "rate") as! Float, realseYear: movieEntity.value(forKey: "year") as! String, genr: [movieEntity.value(forKey: "genr") as! String]))
    }
    func addLocalMovie(movieEntity: NSManagedObject) {
         localMovie?.append(Movie(title: movieEntity.value(forKey: "title") as! String, img: movieEntity.value(forKey: "imgUrl") as! String, rate: movieEntity.value(forKey: "rate") as! Float, realseYear: movieEntity.value(forKey: "year") as! String, genr: [movieEntity.value(forKey: "genr") as! String]))
    }
    func reloadTableView() {
        tableView.reloadData()
        indicatoin.stopAnimating()
        tableView.isHidden=false
    }
}
