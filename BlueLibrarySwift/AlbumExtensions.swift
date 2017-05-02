//
//  AlbumExtensions.swift
//  BlueLibrarySwift
//
//  Created by kwanghee jeong on 2017. 5. 1..
//  Copyright © 2017년 Raywenderlich. All rights reserved.
//

import Foundation

extension Album {
    func ae_tableRepresentation() -> (titles:[String], values:[String]) {
        return (["Artist", "Album", "Genre", "Year"], [artist, title, genre, year])
    }
}
