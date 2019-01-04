

//
//  moviesitemEntity.swift
//  WeTest
//
//  Created by Abdulrahman Sammy on 1/2/19.
//  Copyright © 2019 We. All rights reserved.
//

import Foundation

struct MoviesitemEntity {
    let id: Int?
    let title: String?
    let posterPath: String?
    let overview, releaseDate: String?
    
    init(id: Int?, title: String?, posterPath: String?, overview: String?, releaseDate: String?) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.overview = overview
        self.releaseDate = releaseDate

    }
}
