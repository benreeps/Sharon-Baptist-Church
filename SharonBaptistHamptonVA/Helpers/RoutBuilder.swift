//
//  RoutBuilder.swift
//  SharonBaptistHamptonVA
//
//  Created by Benjamin Reeps on 7/15/21.
//
/*
import Foundation
import MapKit

enum RouteBuilder {
  enum Segment {
    case text(String)
    case location(CLLocation)
  }

  enum RouteError: Error {
    case invalidSegment(String)
  }

  typealias PlaceCompletionBlock = (MKPlacemark?) -> Void
  typealias RouteCompletionBlock = (Result<Route, RouteError>) -> Void

  private static let routeQueue = DispatchQueue(label: "com.raywenderlich.RWRouter.route-builder")

  static func buildRoute(origin: Segment, stops: [Segment], within region: MKCoordinateRegion?, completion: @escaping RouteCompletionBlock) {
    routeQueue.async {
      let group = DispatchGroup()

      var originItem: MKMapItem?
      group.enter()
      requestPlace(for: origin, within: region) { place in
        if let requestedPlace = place {
          originItem = MKMapItem(placemark: requestedPlace)
        }

        group.leave()
      }

      var stopItems = [MKMapItem](repeating: .init(), count: stops.count)
      for (index, stop) in stops.enumerated() {
        group.enter()
        requestPlace(for: stop, within: region) { place in
          if let requestedPlace = place {
            stopItems[index] = MKMapItem(placemark: requestedPlace)
          }

          group.leave()
        }
      }

      group.notify(queue: .main) {
        if let originMapItem = originItem, !stopItems.isEmpty {
          let route = Route(origin: originMapItem, stops: stopItems)
          completion(.success(route))
        } else {
          let reason = originItem == nil ? "the origin address" : "one or more of the stops"
          completion(.failure(.invalidSegment(reason)))
        }
      }
    }
 
  }
*/
