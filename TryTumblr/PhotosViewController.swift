//
//  PhotosViewController.swift
//  TryTumblr
//
//  Created by Kumawat, Diwakar on 3/31/17.
//  Copyright © 2017 Kumawat, Diwakar. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
   
    @IBOutlet weak var photoTableView: UITableView!
    
    
    var posts: [NSDictionary] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the index path from the cell that was tapped
        let indexPath = photoTableView.indexPathForSelectedRow
        // Get the Row of the Index Path and set as index
        let index = indexPath?.row
        // Get in touch with the DetailViewController
        let detailViewController = segue.destination as! DetailViewController
        // Pass on the data to the Detail ViewController by setting it's indexPathRow value
        detailViewController.index = index

        detailViewController.image = self.photoTableView.cellForRow(at: indexPath!)?.imageView?.image
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photoTableView.rowHeight = 240
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
        cell.photoLabel.text="Row \(indexPath.row)"
        
        // "https://i.imgur.com/tGbaZCY.jpg"
        
        let imageUrl = URL(string: "https://i.imgur.com/tGbaZCY.jpg")!
        
        // cell.photoImageView.setImageWith(imageUrl)
        let post = posts[indexPath.row]
        
        if let photos = post.value(forKeyPath: "photos") as? [NSDictionary] {
            // photos is NOT nil, go ahead and access element 0 and run the code in the curly braces
            let imageUrlString = photos[0].value(forKeyPath: "original_size.url") as? String
             let imageUrl = URL(string: imageUrlString!)!
             cell.photoImageView.setImageWith(imageUrl)
            
        } else {
            // photos is nil. Good thing we didn't try to unwrap it!
            cell.photoImageView.setImageWith(imageUrl)
            
        }
        
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoTableView.delegate = self
        photoTableView.dataSource = self

        let url = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(
            with: request as URLRequest,
            completionHandler: { (data, response, error) in
                if let data = data {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options:[]) as? NSDictionary {
                        //print("responseDictionary: \(responseDictionary)")
                        
                        // Recall there are two fields in the response dictionary, 'meta' and 'response'.
                        // This is how we get the 'response' field
                        let responseFieldDictionary = responseDictionary["response"] as! NSDictionary
                        
                        // This is where you will store the returned array of posts in your posts property
                        self.posts = responseFieldDictionary["posts"] as! [NSDictionary]
        		self.photoTableView.reloadData()
                    }
                }
        });
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
