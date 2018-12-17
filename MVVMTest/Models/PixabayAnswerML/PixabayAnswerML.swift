//
//  PixabayAnswerML.swift
//  MVVMTest
//
//  Created by Mykhailo Zabarin on 12/16/18.
//  Copyright © 2018 Mykhailo Zabarin. All rights reserved.
//

import Foundation

enum PixabayAnswerMLKeys: String, CodingKey {
    case totalHits
    case hits
    case total
}

final class PixabayAnswerML: DecodableFromParams {
    
    private var _totalHits: Int
    private var _hits: [ImageItemML]
    private var _total: Int
    
    var totalHits: Int {
        return _totalHits
    }
    
    var hits: [ImageItemML] {
        return _hits
    }
    
    var total: Int {
        return _total
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: PixabayAnswerMLKeys.self)
        
        _totalHits = try container.decode(Int.self, forKey: .totalHits)
        _hits = try container.decode([ImageItemML].self, forKey: .hits)
        _total = try container.decode(Int.self, forKey: .total)
    }
}
