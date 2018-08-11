//
//  NJSisVideoListCell.swift
//  NJSisVideoList
//
//  Created by HuXuPeng on 2018/8/11.
//

import UIKit


class NJSisVideoListCell: UITableViewCell {
    
    @IBOutlet weak var sisImageView: UIImageView!
    @IBOutlet weak var sisTitleLabel: UILabel!
    var sisVideo: NJSisTopic? {
        willSet {
            sisTitleLabel.text = newValue?.text
            
            sisImageView.image = nil
            if let imageUrlStr = newValue?.largePicture as? String, let imageUrl = URL(string: imageUrlStr) {
                sisImageView.af_setImage(withURL: imageUrl)
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}

extension NJSisVideoListCell
{
    fileprivate func setupUI()
    {
        sisImageView.clipsToBounds = true
    }
}


extension NJSisVideoListCell
{
    class func cell(tableView: UITableView) -> NJSisVideoListCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "NJSisVideoListCell")
        
        if cell == nil {
            
            let classBundle = Bundle(for: self)
            let path = classBundle.path(forResource: "NJSisVideoList", ofType: "bundle")!
            let inBundle = Bundle(path: path)
            
            cell = inBundle?.loadNibNamed("NJSisVideoListCell", owner: nil, options: nil)?.first as! UITableViewCell

        }
        return cell as! NJSisVideoListCell
    }
}
