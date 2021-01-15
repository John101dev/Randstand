//
//  RandstandTestTests.swift
//  RandstandTestTests
//
//  Created by 愤怒大葱鸭 on 1/15/21.
//  Copyright © 2021 Randstand. All rights reserved.
//

import XCTest
@testable import RandstandTest

class RandstandTestTests: XCTestCase {

    var animeVC: AnimeViewController!
    var animeVM: AnimeViewModel!

    override func setUp() {
        super.setUp()
        animeVC = AnimeViewController()
        animeVM = AnimeViewModel(urlStr: Constant.url)
        animeVM.getData()
    }

    override func tearDown() {
        animeVC = nil
        animeVM = nil
        super.tearDown()
    }

    func testAnimeStructure() {
        if let path = Bundle.main.path(forResource: "mockData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let anime = try JSONDecoder().decode(MOBAnimeResult.self, from: data)
                XCTAssertEqual(anime.results?[0].title, "One Piece")
                XCTAssertEqual(anime.results?[1].title, "King of the Ring")
                XCTAssertEqual(anime.results?[0].episodes, 1000)
              } catch {
                   print(error.localizedDescription)
              }
        }
    }
}
