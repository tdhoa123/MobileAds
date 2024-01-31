//
//  SmallNativeAdView.swift
//  MobileAds
//
//  Created by macbook on 30/08/2021.
//

import UIKit
import GoogleMobileAds
import SkeletonView

class SmallNativeAdView: GADNativeAdView, NativeAdProtocol {

    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var lblAds: UILabel!
    @IBOutlet weak var cstWidthBtn: NSLayoutConstraint!
    @IBOutlet weak var viewLinePrice: UIView!
    @IBOutlet weak var stackAppStore: UIStackView!
    @IBOutlet weak var starContainerView: UIView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    let (viewBackgroundColor, titleColor, _, contenColor, actionColor, backgroundAction) = AdMobManager.shared.adsNativeColor.colors
    var adUnitID: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = viewBackgroundColor
        loadingLabel.text = AdMobManager.shared.loadingAdsString
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lblAds.layer.cornerRadius = 4
        borderView.layer.cornerRadius = 8
        borderView.clipsToBounds = true
    }
    
    func bindingData(nativeAd: GADNativeAd) {
        self.hideSkeleton()
        (self.headlineView as? UILabel)?.text = nativeAd.headline
        
        (self.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction, for: .normal)
        self.callToActionView?.isHidden = nativeAd.callToAction == nil
        
        (self.iconView as? UIImageView)?.image = nativeAd.icon?.image
        self.iconView?.isHidden = nativeAd.icon == nil
        
        //        if nativeAd.starRating != nil, nativeAd.starRating != 0 {
        //            (self.starRatingView as? UIImageView)?.image = self.imageOfStars(from: nativeAd.starRating)
        //            starContainerView.isHidden = false
        //        } else {
        starContainerView.removeFromSuperview()
        starRatingView?.removeFromSuperview()
        //        }

        if nativeAd.price == nil || nativeAd.price == "" {
            self.viewLinePrice.isHidden = true
        } else {
            self.viewLinePrice.isHidden = false
        }
        
        if nativeAd.body == nil {
            (self.bodyView as? UILabel)?.text = nativeAd.advertiser
        } else {
            (self.bodyView as? UILabel)?.text = nativeAd.body
        }
        
        //        if nativeAd.body == nil {
        //            (self.advertiserView as? UILabel)?.text = nativeAd.advertiser
        //        } else {
        //            (self.advertiserView as? UILabel)?.text = nativeAd.body
        //        }
        
        if backgroundAction.count > 1 {
            self.callToActionView?.gradient(startColor: backgroundAction.first!, endColor: backgroundAction.last!, cornerRadius: AdMobManager.shared.adsNativeCornerRadiusButton)
        } else {
            self.callToActionView?.layer.backgroundColor = backgroundAction.first?.cgColor
            self.callToActionView?.layer.cornerRadius = AdMobManager.shared.adsNativeCornerRadiusButton
        }
        (self.callToActionView as? UIButton)?.setTitleColor(actionColor, for: .normal)
        (self.bodyView as? UILabel)?.textColor = contenColor
        (self.headlineView as? UILabel)?.textColor = titleColor
        lblAds.textColor = AdMobManager.shared.adNativeAdsLabelColor
        lblAds.backgroundColor = AdMobManager.shared.adNativeBackgroundAdsLabelColor
        self.backgroundColor = viewBackgroundColor
        layer.borderWidth = AdMobManager.shared.adsNativeBorderWidth
        layer.borderColor = AdMobManager.shared.adsNativeBorderColor.cgColor
        layer.cornerRadius = AdMobManager.shared.adsNativeCornerRadius
        cstWidthBtn.constant = AdMobManager.shared.adsNativeSmallWidthButton
        clipsToBounds = true
        self.nativeAd = nativeAd
    }

    func hideLoadingView() {
        loadingView.isHidden = true
    }
}
