//
//  AntrianCell.swift
//  AntrianHaji
//
//  Created by Agus Cahyono on 3/14/17.
//  Copyright © 2017 balitax. All rights reserved.
//

import UIKit

class AntrianCell: UITableViewCell {
	
	@IBOutlet weak var vWilayah: UILabel!
	@IBOutlet weak var vKuota: UILabel!
	@IBOutlet weak var vTahun: UILabel!
	@IBOutlet weak var vPendaftaranAkhir: UILabel!
	@IBOutlet weak var vPendaftaran: UILabel!
	@IBOutlet weak var vLunasTunda: UILabel!
	

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
