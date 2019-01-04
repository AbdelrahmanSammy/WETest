//
//  MovieTableViewCell.swift
//  WeTest
//
//  Created by Abdulrahman Sammy on 1/2/19.
//  Copyright © 2019 We. All rights reserved.
//

import UIKit
import Kingfisher
class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if #available(iOS 11.0, *) {
            self.movieImageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        } else {
            // Fallback on earlier versions
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
////////    SET CELL DATA ////////

    
    func setData(movie : MoviesitemEntity ) {
        let imagesource  =  ImageResource(downloadURL:URL(string: movie.posterPath!)!,cacheKey:movie.posterPath!)
        self.movieImageView.kf.setImage(with:imagesource)
        self.nameLabel.text = movie.title
        self.descriptionLabel.text = movie.overview
        self.dateLabel.text = movie.releaseDate
        
    }
    
}
