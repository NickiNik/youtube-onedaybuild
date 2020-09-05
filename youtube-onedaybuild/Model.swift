//
//  Model.swift
//  youtube-onedaybuild
//
//  Created by Kassie Green on 9/4/20.
//  Copyright © 2020 Nicki J. All rights reserved.
//

import Foundation

protocol ModelDelegate {
    func videosFetched (_ videos:[Video])
}

class Model {
    
    var delegate:ModelDelegate?
    
    func getVideos() {
        
        //Creat URL object
        let url = URL(string: Constants.API_URL)
        
        guard url != nil else {
            return
        }
        
        // Get URLSession object
        let session = URLSession.shared
        
        // Get a data task from URLSession object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check if there are any errors
            
            if error != nil || data == nil {
                return
            }
            
            do {
            
            //Parsing the data into video objects
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let response = try decoder.decode(Response.self, from: data!)
                
                if response.items != nil {
                   
                    DispatchQueue.main.async {
                        
                // Call the "videosFetched" method of the delegate
                    self.delegate?.videosFetched(response.items!)
                        
                    }
                }
            
                dump(response)
                
            }
            catch {
                
            }
            
        }
        
        //Kick off the task
        dataTask.resume()
    }

}
