//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Chirag on 4/16/23.
//

import UIKit

class WeatherView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var TempStackView: UIStackView!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temparture: UILabel!
        
    @IBOutlet weak var windLabel: UILabel!
    
    @IBOutlet weak var lowTempLabel: UILabel!
    
    @IBOutlet weak var highTempLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("WeatherView", owner: self, options: nil)
        contentView.pinView(self)
    }
    
    func configureView(model:WeatherData) {
        DispatchQueue.main.async { [self] in
            cityName.text = model.name;
            temparture.text = "\(model.main.temp)°F"
            windLabel.text = "Wind\n\(model.wind.speed)"
            lowTempLabel.text = "Low\n\(model.main.temp_min)°F"
            highTempLabel.text = "High\n\(model.main.temp_max)°F"
            descriptionLabel.text = model.weather.first?.descriptionKey
            let weather = model.weather.first
            
            if let iconName = weather?.icon {
                let imageUrl = "\(WeatherConstants.IMAGE_URL)"+"\(iconName)@2x.png"
                weatherIcon.loadRemoteImageFrom(urlString: imageUrl)
            }
        }
    }
    
}

