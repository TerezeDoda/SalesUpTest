//
//  NetworkStatusMonitor.swift
//  SalesUpApp
//
//  Created by ritech on 22.3.22.
//

import Foundation
import Connectivity

enum NetworkStatus {
    case connected
    case connectedNoInternet
    case disconnected
    case unknown
}

protocol NetworkStatusMonitorProtocol {
    var currentStatus: NetworkStatus { get }
    var currentConnectivityStatus: ConnectivityStatus { get }

    func startMonitoring()
    func stopMonitoring()
}

class NetworkStatusMonitor: NSObject, NetworkStatusMonitorProtocol {

    static let shared = NetworkStatusMonitor()

    // Using our own NetworkStatus enum to abstract away from the Connectivity library,
    // but exposing the connectivity status in case we want finer detail
    var currentStatus: NetworkStatus = .unknown
    var currentConnectivityStatus: ConnectivityStatus = .determining

    private let connectivity: Connectivity = Connectivity()
    private let monitorQueue = DispatchQueue(label: "NetworkMonitor")

    private var isMonitoring: Bool = false

    private override init() {
        super.init()

        connectivity.framework = .network
        connectivity.isPollingEnabled = true
        connectivity.pollingInterval = K.networkStatusPollingInterval

        let connectivityChanged: (Connectivity) -> Void = { [weak self] connectivity in
             self?.updateConnectionStatus(connectivity.status)
        }
        connectivity.whenConnected = connectivityChanged
        connectivity.whenDisconnected = connectivityChanged
    }

    func startMonitoring() {
        guard !isMonitoring else { return }

        isMonitoring = true
        connectivity.startNotifier(queue: monitorQueue)
    }

    func stopMonitoring() {
        guard isMonitoring else { return }

        connectivity.stopNotifier()
        isMonitoring = false
    }

    private func updateConnectionStatus(_ status: ConnectivityStatus) {
        self.currentConnectivityStatus = status

        switch status {
        case .connected, .connectedViaWiFi, .connectedViaCellular:
            self.currentStatus = .connected
        case .connectedViaWiFiWithoutInternet, .connectedViaCellularWithoutInternet:
            self.currentStatus = .connectedNoInternet
        case .notConnected:
            self.currentStatus = .disconnected
        case .determining:
            self.currentStatus = .unknown
        }

        NotificationCenter.default.post(
            name: K.Notifications.networkStatusChanged,
            object: nil,
            userInfo: [
                K.Notifications.networkStatusKey: self.currentStatus,
                K.Notifications.connectivityNetworkStatusKey: status
            ]
        )
    }
}
