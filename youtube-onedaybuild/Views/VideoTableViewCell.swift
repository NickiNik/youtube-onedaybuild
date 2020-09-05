//
//  VideoTableViewCell.swift
//  youtube-onedaybuild
//
//  Created by Kassie Green on 9/5/20.
//  Copyright © 2020 Nicki J. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var video:Video?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ v:Video){
        
        self.video = v
        
        // Ensure we have a video
        guard self.video != nil else {
            return
        }
        
        // Set the title label
        self.titleLabel.text = video?.title
        
        // Set the date label
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        self.dateLabel.text = df.string(from: video!.published)
        
        // Set the thumbnail
        guard self.video!.thumbnail != "" else {
            return
        }
        
        //Check cache before downloading data
        if let cachedData = CacheManager.getVideoCache(self.video! .thumbnail) {
            
            // Set the thumbnail imageview
            self.thumbnailImageView.image = UIImage(data: cachedData)
            return
        }
        
        // If there is a thumbnail, Download the thumnail data
        let url = URL(string: self.video!.thumbnail)
        
        // Get the shared URL Session object
        let session = URLSession.shared
        
        // Create the data task
        let dataTask = session.dataTask(with: url!) {(data, response, error) in
            
            if error == nil && data != nil {
                
                // Save the data in the cache
                CacheManager.setVideoCache(url!.absoluteString, data)
                
                // Check that the downlaoded url matches the video thumbnail url that is cell is currently set to display
                
                if url!.absoluteString != self.video?.thumbnail {
                    //Video cell has been recycled for another video and no longer matches the thumbnail that was downloaded
                    return
                }
                
                // Create the image object
                let image = UIImage(data:data!)
                
                // Set image view
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
            }
            
        }
        
        // Start data task
        dataTask.resume()
    }

}
