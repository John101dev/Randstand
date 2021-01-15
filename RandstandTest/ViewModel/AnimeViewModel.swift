//
//  AnimeViewModel.swift
//  RandstandTest
//
//  Created by 愤怒大葱鸭 on 1/14/21.
//  Copyright © 2021 Randstand. All rights reserved.
//

import Foundation

protocol AnimeDelegate {
    func refreshTableView()
}
class AnimeViewModel {
    var urlStr: String?
    var animeInfo: MOBAnimeResult?
    var animes: [MOBAnime]?
    var filteredAnimes: [MOBAnime]?
    var delegate: AnimeDelegate?

    init(urlStr: String? = nil) {
        self.urlStr = urlStr
    }

    func getData() {
        if let urlstr = urlStr, let url = URL(string: urlstr) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let err = error {
                    //handle error
                    print(err)
                }
                if let data = data {
                    do {
                        self.animeInfo = try JSONDecoder().decode(MOBAnimeResult.self, from: data)
                        self.animes = self.animeInfo?.results
                        self.filteredAnimes = self.animes
                        self.delegate?.refreshTableView()
                        if self.animeInfo?.request_cached ?? false {
                            //do something
                        }
                    } catch let err {
                        print(err.localizedDescription)
                    }
                }

            }.resume()
        }
    }
}
