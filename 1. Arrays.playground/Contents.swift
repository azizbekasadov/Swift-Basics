import UIKit

var toDoList = ["Take out the trash", "Pay bills", "Cross off finished items"]
var exp = toDoList
var randList = toDoList
toDoList.reversed()

var result = [String]()
//O(n)
for _ in exp {
    if !exp.isEmpty {
        var last = exp.last!
        result.append(last)
        exp.removeLast()
    }
}
print(result)

var resultRand = [String]()
//O(n)
//use the Array documentation to find an easy way to rearrange the items in your toDoList into a random order.
for (index, each) in randList.enumerated() {
    if !randList.isEmpty {
        var rand = randList.randomElement() ?? each
        var index = randList.firstIndex(of: rand) ?? index
        resultRand.append(rand)
        randList.remove(at: index)
    }
}
print(resultRand)

resultRand.shuffle()
