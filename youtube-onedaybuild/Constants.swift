//
//  Constants.swift
//  youtube-onedaybuild
//
//  Created by Kassie Green on 9/4/20.
//  Copyright © 2020 Nicki J. All rights reserved.
//

import Foundation

struct Constants {
    
    static var API_KEY = "AIzaSyAn5tgWhfwdul1lpIMhQjoF0cZwRrkUS6w"
    static var PLAYLIST_ID = "UU2D6eRvCeMtcF5OGHf1-trw"
    static var API_URL = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(Constants.PLAYLIST_ID)&key=\(Constants.API_KEY)"
}
