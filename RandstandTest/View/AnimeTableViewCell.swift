//
//  AnimeTableViewCell.swift
//  RandstandTest
//
//  Created by 愤怒大葱鸭 on 1/14/21.
//  Copyright © 2021 Randstand. All rights reserved.
//

import UIKit

class AnimeTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblEpisode: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblDescription: UILabel!

    /// the anime can become a cellViewModel if cell has complex structure, for this simple structure I'm only creating a var.
    var anime = MOBAnime()
    let imageCache = NSCache<NSString, UIImage>()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
    }

    func bindAnime() {
        lblTitle.text = anime.title
        lblType.text = "Type: \(anime.type ?? "")"
        lblRate.text = "Rate: \(anime.rated ?? "")"
        lblScore.text = "Score: \(String(anime.score ?? 0))"
        lblEpisode.text = "Episodes: \(String(anime.episodes ?? 0))"
        lblDescription.text = anime.synopsis
        imgView.image = getImage()
    }

    func getImage() -> UIImage? {
        guard let url = anime.image_url else { return nil }
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            return cachedImage
        }
        var data = Data()
        if let url = URL(string: url) {
            do {
                data = try Data(contentsOf: url)
            } catch let error {
                print(error.localizedDescription)
            }
        }

        if let image = UIImage(data: data) {
            imageCache.setObject(image, forKey: url as NSString)
            return image
        }
        return nil
    }
}
