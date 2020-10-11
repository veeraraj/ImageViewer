//
//  ReachabilityHandler.swift
//  ImageViewer
//
//  Created by Veera on 11/10/20.
//

import Foundation
import Reachability

fileprivate var reachability: Reachability!

//--------------------------------------------------------------------------
// MARK: - Protocols
//--------------------------------------------------------------------------

protocol ReachabilityStatus {
    func isConnectionAvailabe(_ isReachable: Bool)
}

protocol ReachabilityObesrver: class, ReachabilityStatus {
    func addReachabilityObservers() throws
    func removeReachabilityObservers()
    func isNetworkAvailable() -> Bool
}

extension ReachabilityObesrver {

    //--------------------------------------------------------------------------
    // MARK: - Methods
    //--------------------------------------------------------------------------

    func addReachabilityObservers() throws {
        reachability = try Reachability()

        reachability.whenReachable = { [weak self] _ in
            self?.isConnectionAvailabe(true)
        }

        reachability.whenUnreachable = { [weak self] _ in
            self?.isConnectionAvailabe(false)
        }

        try reachability.startNotifier()
    }

    func removeReachabilityObservers() {
        reachability.stopNotifier()
        reachability = nil
    }

    func isNetworkAvailable() -> Bool {
        return reachability.connection != .unavailable
    }
}
