//
//  AntrianViewModel.swift
//  AntrianHaji
//
//  Created by Agus Cahyono on 3/14/17.
//  Copyright © 2017 balitax. All rights reserved.
//

import Alamofire
import Moya
import ObjectMapper
import RealmSwift
import RxSwift

protocol AntrianViewModel {
	
}

extension AntrianViewModel {
	
	
	//MARK: GET LIST ANTRIAN HAJI
	func getAntrian(provider: RxMoyaProvider<AntrianService>) -> Observable<[AntrianModel]> {
		
		let observable = Observable<[AntrianModel]>.create { (observer: AnyObserver<[AntrianModel]>) -> Disposable in
			
			provider.request(.listAntrian).subscribe { event in
				switch event {
				case let .next(response):
					do {
						let responseString = try response.mapString()
						let antrians = Mapper<AntrianModel>().mapArray(JSONString: responseString)!
						
						let realm = try Realm()
						
						// Delete first
						try realm.write {
							realm.deleteAll()
						}
						
						// Rewrite Data
						try realm.write {
							for antrian: AntrianModel in antrians {
								realm.add(antrian.data)
							}
						}
						
						observer.onNext(antrians)
						observer.onCompleted()
						
					} catch (let error) {
						print("[Antrian View Model] ERROR: \(error)")
						observer.onError(error)
					}
				case let .error(error):
					print("[Antrian View Model] ERROR: \(error)")
					observer.onError(error)
				default:
					break
				}
			}
			
			return Disposables.create()
		}
		
		return observable
		
	}
	
}

