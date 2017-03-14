//
//  AntrianService.swift
//  AntrianHaji
//
//  Created by Agus Cahyono on 3/14/17.
//  Copyright © 2017 balitax. All rights reserved.
//

import Moya

enum AntrianService {
	case listAntrian
	case porsiAntrian(nomorPorsi: String)
}


extension AntrianService: TargetType {
	
	var baseURL: URL {
		return URL(string: "http://ibacor.com/api/info-haji")!
	}
	
	var path: String {
		return ""
		
	}
	
	var method: Moya.Method {
		return .get
	}
	
	var parameters: [String : Any]? {
		switch self {
		case .listAntrian:
			
			let params =  [
				"view": "waiting",
				"k": "6b4795e0ec760435ac2a186a67c71ae8"
			]
			return params
			
		case .porsiAntrian(let noPorsi):
			return [
				"view":"keberangkatan",
				"np": noPorsi,
				"k": "6b4795e0ec760435ac2a186a67c71ae8"
			]
		}
	}
	
	var parameterEncoding: ParameterEncoding {
		return URLEncoding.default
	}
	
	var sampleData: Data {
		return Data()
	}
	
	var task: Task {
		return .request
	}
	
}



