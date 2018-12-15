//
//   ImageItemML.swift
//  MVVMTest
//
//  Created by Mykhailo Zabarin on 12/15/18.
//  Copyright © 2018 Mykhailo Zabarin. All rights reserved.
//

import Foundation

enum ImageItemMLKeys: String, CodingKey {
    case largeImageURL
    case previewURL
}

final class  ImageItemML: DecodableFromParams {
    
    private var _largeImageURL: String
    private var _previewURL: String
    private var _name: String
    
    var largeImageURL: String {
        return _largeImageURL
    }
    
    var previewURL: String {
        return _previewURL
    }
    
    var name: String {
        return _name
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: ImageItemMLKeys.self)
        
        _largeImageURL = try container.decode(String.self, forKey: .largeImageURL)
        _previewURL = try container.decode(String.self, forKey: .previewURL)
        _name = ""
    }
}
