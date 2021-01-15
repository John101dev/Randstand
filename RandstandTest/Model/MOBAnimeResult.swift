//
//  MOBAnimeResult.swift
//  RandstandTest
//
//  Created by 愤怒大葱鸭 on 1/14/21.
//  Copyright © 2021 Randstand. All rights reserved.
//

import Foundation

struct MOBAnimeResult: Codable {
    var request_hash: String?
    var request_cached: Bool?
    var request_cache_expiry: Int?
    var results: [MOBAnime]?
    init(request_hash: String? = nil,
         request_cached: Bool? = nil,
         request_cache_expiry: Int? = nil,
         results: [MOBAnime]? = nil) {
        self.request_hash = request_hash
        self.request_cached = request_cached
        self.request_cache_expiry = request_cache_expiry
        self.results = results
    }
}

struct MOBAnime: Codable {
    var url: String?
    var image_url: String?
    var title: String?
    var synopsis: String?
    var type: String?
    var episodes: Int?
    var start_date: String?
    var end_date: String?
    var score: Double?
    var rated: String?

    init(url: String? = nil,
         image_url: String? = nil,
         title: String? = nil,
         synopsis: String? = nil,
         type: String? = nil,
         episodes: Int? = nil,
         start_date: String? = nil,
         end_date: String? = nil,
         score: Double? = nil,
         rated: String? = nil) {
        self.url = url
        self.image_url = image_url
        self.title = title
        self.synopsis = synopsis
        self.type = type
        self.episodes = episodes
        self.start_date = start_date
        self.end_date = end_date
        self.score = score
        self.rated = rated
    }    
}
