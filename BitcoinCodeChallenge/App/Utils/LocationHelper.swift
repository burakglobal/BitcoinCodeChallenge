//
//
//  BitcoinCodeChallenge
//
//  Created by BURAK KEBAPCI on 5/24/19.
//  Copyright © 2019 BurakKebapci. All rights reserved.
//

import Foundation
import CoreLocation
import PromiseKit

class LocationHelper {
  let coder = CLGeocoder()
  
  func getLocation() -> Promise<CLPlacemark> {
    return CLLocationManager.requestLocation().lastValue.then { location in
      return self.coder.reverseGeocode(location: location).firstValue
    }
  }

  func searchForPlacemark(text: String) -> Promise<CLPlacemark> {
    return coder.geocode(text).firstValue
  }
}
