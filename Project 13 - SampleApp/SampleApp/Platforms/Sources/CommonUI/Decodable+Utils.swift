//
//  Decodable+Utils.swift
//  SampleApp
//
//  Created by jc.kim on 3/27/23.
//

import Foundation

public extension Decodable {
  static func loadFromFile(_ filename: String,_ type: AnyClass) -> Self {
    do {
      let path = Bundle(for: type).path(forResource: filename, ofType: nil)!
      let data = try Data(contentsOf: URL(fileURLWithPath: path))
      return try JSONDecoder().decode(Self.self, from: data)
    } catch {
      fatalError("Error: \(error.localizedDescription)")
    }
  }
}
