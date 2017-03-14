//
//  DaftarAntrianHajiViewController.swift
//  AntrianHaji
//
//  Created by Agus Cahyono on 3/14/17.
//  Copyright © 2017 balitax. All rights reserved.
//

import UIKit
import Moya
import RealmSwift
import RxSwift
import RxCocoa
import SVProgressHUD


class DaftarAntrianHajiViewController: UIViewController, AntrianViewModel, UISearchBarDelegate {
	
	// OUTLETS
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var searchBar: UISearchBar!
	
	// VARIABLES
	var antrians   = [Antrian]()
	let disposeBag = DisposeBag()
	let provider   = RxMoyaProvider<AntrianService>()
	var refresh    = UIRefreshControl()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.tableView.estimatedRowHeight = 66
		self.tableView.rowHeight = UITableViewAutomaticDimension
		
		self.searchBar.delegate = self
		
		self.title = "Daftar Antrian Haji"
		
		initiateData()
		
    }
	
	// MARK: Initiate Data
	func initiateData() {
		// Antrian
		
		SVProgressHUD.show()
		
		self.getAntrian(provider: provider).subscribe(onNext: {(post: [AntrianModel]) in
			
			self.initiateRealm()
			
			}, onError: { (error) in
				print("Error")
				self.initiateRealm()
				SVProgressHUD.dismiss()
		}, onCompleted: {
			print("Completed")
			SVProgressHUD.dismiss()
		}).addDisposableTo(disposeBag)
	}
	
	// MARK: Save Data To Realm
	func initiateRealm() {
		// Realm Antrian
		do {
			let realm = try Realm()
			antrians = realm.objects(Antrian.self).toArray()
			self.tableView.reloadData()
		} catch(let error) {
			print("ERROR WHEN OPERATE REALM : \(error)")
		}
	}
	
	//MARK: Do Reload Data
	func reloadData() {
		
		SVProgressHUD.show()
		
		// Reload antrian
		self.getAntrian(provider: provider).subscribe(onNext: {(post: [AntrianModel]) in
			
			self.initiateRealm()
			
		}, onError: { (error) in
			print("Error")
			self.initiateRealm()
			SVProgressHUD.dismiss()
		}, onCompleted: {
			print("Completed")
			SVProgressHUD.dismiss()
		}).addDisposableTo(disposeBag)
	}
	
	@IBAction func refreshData(_ sender: UIBarButtonItem) {
		self.reloadData()
	}
	
	// MARK: Search Data
	func searchData() {
		
	}
	
	
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
    }
	
	//MARK: UISearchBarDelegate
	
}


extension DaftarAntrianHajiViewController: UITableViewDelegate {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.antrians.count
	}
	
}

extension DaftarAntrianHajiViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AntrianCell
		
		let data = self.antrians[indexPath.row]
		
		cell.vWilayah.text 	        = "Wilayah : " + data.wilayah
		cell.vKuota.text   	        = "Kuota : " + data.kuota
		cell.vTahun.text	        = "Tahun : " + data.tahun
		cell.vPendaftaranAkhir.text = "Pendaftar Akhir : " + data.pendaftar_akhir
		cell.vPendaftaran.text      = "Pendaftaran : " + data.pendaftaran
		cell.vLunasTunda.text       = "Lunas Tunda : " + data.lunas_tunda
		
		return cell
		
	}
	
}



