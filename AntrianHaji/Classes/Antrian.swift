//
//  Antrian.swift
//  AntrianHaji
//
//  Created by Agus Cahyono on 3/14/17.
//  Copyright © 2017 balitax. All rights reserved.
//

import ObjectMapper
import ObjectMapper_Realm
import RealmSwift
import RxRealm

struct AntrianModel: Mappable {
	
	var data = [Antrian]()
	
	init?(map: Map) {
		
	}
	
	mutating func mapping(map: Map) {
		data 		<- map["data"]
	}
	
}

class Antrian: Object, Mappable {
	
	dynamic var wilayah: String = ""
	dynamic var kuota: String = ""
	dynamic var tahun: String = ""
	dynamic var pendaftar_akhir: String = ""
	dynamic var pendaftaran: String = ""
	dynamic var lunas_tunda: String = ""
	
	required convenience init(map: Map) {
		self.init()
	}
	
	func mapping(map: Map) {
		wilayah 		<- map["wilayah"]
		kuota 			<- map["kuota"]
		tahun 			<- map["tahun"]
		pendaftar_akhir	<- map["pendaftar_akhir"]
		pendaftaran 	<- map["pendaftaran"]
		lunas_tunda 	<- map["lunas_tunda"]
	}
	
	
}
