//
//  PersistencyManager.swift
//  BlueLibrarySwift
//
//  Created by kwanghee jeong on 2017. 5. 1..
//  Copyright © 2017년 Raywenderlich. All rights reserved.
//

import UIKit

class PersistencyManager: NSObject {

    private var albums = [Album]()
    
    override init() {
        super.init()
        if let data = NSData(contentsOfFile: NSHomeDirectory().appending("/Documents/albums.bin")) {
            let unarchiveAlbums = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [Album]?
            if let unwrappedAlbum = unarchiveAlbums {
                albums = unwrappedAlbum
            }
        } else {
            createPlaceholderAlbum()
        }
    }
    
    func createPlaceholderAlbum() {
        //Dummy list of albums
        let album1 = Album(title: "Best of Bowie",
                           artist: "David Bowie",
                           genre: "Pop",
                           coverUrl: "https://s3.amazonaws.com/CoverProject/album/album_juliana_hatfield_in_exile_deo.png",
                           year: "1992")
        
        let album2 = Album(title: "It's My Life",
                           artist: "No Doubt",
                           genre: "Pop",
                           coverUrl: "https://s3.amazonaws.com/CoverProject/album/album_juliana_hatfield_forever_baby.png",
                           year: "2003")
        
        let album3 = Album(title: "Nothing Like The Sun",
                           artist: "Sting",
                           genre: "Pop",
                           coverUrl: "https://s3.amazonaws.com/CoverProject/album/album_mark_ronson_version.png",
                           year: "1999")
        
        let album4 = Album(title: "Staring at the Sun",
                           artist: "U2",
                           genre: "Pop",
                           coverUrl: "https://s3.amazonaws.com/CoverProject/album/album_j_mascis_martin_and_me.png",
                           year: "2000")
        
        let album5 = Album(title: "American Pie",
                           artist: "Madonna",
                           genre: "Pop",
                           coverUrl: "https://s3.amazonaws.com/CoverProject/album/album_mark_ronson_version.png",
                           year: "2000")

        albums = [album1, album2, album3, album4, album5]
        saveAlbums()
    }
    
    func getAlbums() -> [Album] {
        return albums
    }
    
    func addAlbum(album: Album, index: Int) {
        if (albums.count >= index) {
            albums.insert(album, at: index)
        } else {
            albums.append(album)
        }
    }
    
    func saveAlbums() {
        let filename = URL(fileURLWithPath:NSHomeDirectory()).appendingPathComponent("/Documents/albums.bin")
        let data = NSKeyedArchiver.archivedData(withRootObject: albums)
        try! data.write(to: filename, options: .atomic)
    }
    
    func deleteAlbumAtIndex(index: Int) {
        albums.remove(at: index)
    }
    
    func saveImage(image: UIImage, filename: String) {
        let path = NSHomeDirectory().appending("/Documents/\(filename)")
        let data = UIImagePNGRepresentation(image)
        try! data?.write(to: URL(string: "file://\(path)")!)
    }
    
    func getImage(filename: String) -> UIImage? {
        let path = NSHomeDirectory().appending("/Documents/\(filename)")
        if let data = try? NSData(contentsOfFile: path, options: .uncachedRead) {
            return UIImage(data: data as Data)
        } else {
            return nil
        }
    }
}
