//
//  GrandCentralDispatch.swift
//  ONTHEMAP
//
//  Created by Delberto Martinez on 09/11/16.
//  Copyright © 2016 Delberto Martinez. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(updates: @escaping() -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
