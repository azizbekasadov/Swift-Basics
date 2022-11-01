import Foundation

// MARK: DEFINITION
// A Set is an unordered collection of distinct instances.

let grosseriesList: Set<String> = ["Apple", "Juice", "Banana", "Coke"]

// A set’s values are unordered within the collection
// The values in a Set must be unique; a value can only
// be added to a set once

// To ensure that elements are unique, Set requires that its elements follow the same rule as a dictionary’s keys – being hashable
// Remark: look at the Hashable topic in the Apple's documentation;

// Immutable Set
let grosseriesList0: Set<String> = ["Apple", "Juice", "Banana", "Coke"]

// Mutable Set
var grosseriesList1: Set<String> = ["Apple", "Juice", "Banana", "Coke"]

// Syntax variations:
// 1.
let grosseriesList2 = Set<String>(["Apple", "Juice", "Banana", "Coke"])
// 2.
var grosseriesList3: Set<String> = ["Apple", "Juice", "Banana", "Coke"]
// 3.
var grosseriesList4: Set = ["Apple", "Juice", "Banana", "Coke"]

// Inserting items to the mutable set:
grosseriesList4.insert("Coffee")

let returnValueFromInsertion = grosseriesList4.insert("Tea")
print(returnValueFromInsertion)
// Returns a tuple including a Boolean (indicating whether the instance was
// successfully inserted into the set) and the instance that was (or was not) inserted.

// Iterating items in the list (Set)
for item in grosseriesList4 {
    print(item)
}

// Removing item in the Set
grosseriesList4.remove("Coffee")

// Returing the values that were removed from the Set
let removed = grosseriesList4.remove("Juice")
print(removed)

// This happens when you have no item to remove
grosseriesList4.remove("Pepsi")

// Check whether the item exists in the Set
let value = grosseriesList4.contains("Banana")
print(value)

// Union operation
// The union(_:) method eliminates duplicates
let unionResult = grosseriesList4.union(grosseriesList)
print(unionResult)

// Intersection
// Set’s intersection(_:) method identifies the items that are present in
// both collections and returns those duplicated items in a new Set instance.
let intersection = grosseriesList4.intersection(grosseriesList)
print(intersection)

// Disjoint
// isDisjoint(with:) method checks whether two sets exclusively contain different items
let disjoint = grosseriesList4.isDisjoint(with: grosseriesList)
print(disjoint)
// Set’s isDisjoint(with:) method returns true if no members of the set (here, groceryList)
// are in the sequence provided to isDisjoint(with:)’s argument (here, friendsGroceryList)
// and false if there are any members in common.

// Symmetric Difference
// symmetricDifference(_:), which would tell you about all the items that appear in one and only
// one of your lists
let symmetricDiff = grosseriesList4.symmetricDifference(grosseriesList)
print(symmetricDiff)

// Subtracting
//subtracting(_:), that will give you a set that represents what is left when you subtract the
// values in one set from another set
let subtracting = grosseriesList4.subtracting(grosseriesList)
print(subtracting)

// Superset
let myCities: Set = ["Atlanta", "Chicago", "Jacksonville", "New York", "Denver"]
let yourCities: Set = ["Chicago", "Denver", "Jacksonville"]
print(myCities.isSuperset(of: yourCities))
// a method on Set that returns a Bool indicating whether myCities contains all the cities contained
// by yourCities.

