//
//  ExtDecodable.swift
//  MVVMTest
//
//  Created by Mykhailo Zabarin on 12/15/18.
//  Copyright © 2018 Mykhailo Zabarin. All rights reserved.
//

import Foundation

protocol DecodableFromParams: Decodable { }

extension DecodableFromParams {
    
    init?(from json: APIParams) throws {
        guard let aJson = json, let data = try? JSONSerialization.data(withJSONObject: aJson, options: .prettyPrinted) else { return nil }
        guard let value = try? JSONDecoder().decode(Self.self, from: data) else { return nil }
        self = value
    }
}
