//
//
//  BitcoinCodeChallenge
//
//  Created by BURAK KEBAPCI on 5/24/19.
//  Copyright © 2019 BurakKebapci. All rights reserved.
//

import Foundation
import PromiseKit

func brokenPromise<T>(method: String = #function) -> Promise<T> {
  return Promise<T>() { seal in
    let err = NSError(domain: "BitcoinCodeChallenge", code: 0, userInfo: [NSLocalizedDescriptionKey: "'\(method)' not yet implemented."])
    seal.reject(err)
  }
}
