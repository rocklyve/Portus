//
//  Created by Andreas Link on 09.03.19.
//  Copyright © 2019 Jamit Labs. All rights reserved.
//

import Foundation

/// Data structure uniquely identifying nodes to enter, leave or switch to. Routing entries are kept within the
/// routing tree to enable routing computations.
public class RoutingEntry {
    /// Data structure containing entries that are managed by the node
    public struct ManagedEntries {
        /// The entries that are managed by the node
        public var entries: [RoutingEntry]

        /// The active entry among all managed entries
        public var activeEntry: RoutingEntry

        /// ManagedEntries initializer
        ///
        /// - Parameters:
        ///     - entries: The entries that are managed by the node
        ///     - activeEntry: The active entry among all managed entries
        public init(entries: [RoutingEntry], activeEntry: RoutingEntry) {
            self.entries = entries
            self.activeEntry = activeEntry
        }
    }

    /// An unique identifier of a routing node. Additional routing identifiers are defined by
    /// extending the `RoutingIdentifier` type using static properties.
    public var identifier: RoutingIdentifier

    /// Parameters stored in a key-value map, defining the context in which the routing node is used.
    public var context: RoutingContext?

    /// The current routable associated with the entry.
    weak var routable: Routable?

    /// Information of associated child entries
    public var managedEntries: ManagedEntries?

    /// Initializes a routing entry for a given identifier and context.
    ///
    /// - Parameters:
    ///     - identifier: An identifier, i.e., a `String` identifying the routing node.
    ///     - context: The context the node is currently in, or `nil` if not given.
    ///     - routable: A `Routable` instance of the routable associated with the entry, or `nil` otherwise.
    ///     - managedEntries: The entries of the nodes that are managed by the node identified by the current entry
    public init(
        identifier: RoutingIdentifier,
        context: RoutingContext? = nil,
        routable: Routable? = nil,
        managedEntries: ManagedEntries? = nil
    ) {
        self.identifier = identifier
        self.context = context
        self.routable = routable
        self.managedEntries = managedEntries
    }
}

// MARK: - Equatable
extension RoutingEntry: Equatable {
    /// Implementation of the `Equatable` protocol.
    public static func == (lhs: RoutingEntry, rhs: RoutingEntry) -> Bool {
        if let lhsRoutable = lhs.routable, let rhsRoutable = rhs.routable {
            return (
                lhs.identifier == rhs.identifier &&
                lhs.context == rhs.context &&
                lhsRoutable === rhsRoutable
            )
        } else {
            return (
                lhs.identifier == rhs.identifier &&
                lhs.context == rhs.context
            )
        }
    }
}
