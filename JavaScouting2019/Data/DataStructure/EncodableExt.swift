//
//  EncodableExt.swift
//  JavaScouting2019
//
//  Created by Keegan on 2/14/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import Foundation

struct JSON {
	static let encoder = JSONEncoder()
}
extension Encodable {
	subscript(key: String) -> Any? {
		return dictionary[key]
	}
	var dictionary: [String: Any] {
		return (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self))) as? [String: Any] ?? [:]
	}
}
