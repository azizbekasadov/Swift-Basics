//
//  TaskStore.swift
//  TahDoodle
//
//  Created by Azizbek Asadov on 15/11/22.
//

import Foundation

class TaskStore: ObservableObject {
    private let fileURL: URL = {
        let fileManager = FileManager.default
        let documentDirectories = fileManager.urls(for: .documentDirectory,
                                                   in: .userDomainMask)
        let myDocumentDirectory = documentDirectories.first!
        let tasksFileURL = myDocumentDirectory.appendingPathExtension("tasks.json")
        print("Tasks file is \(tasksFileURL)")
        return tasksFileURL
    }()
    
//    You get a reference to the default FileManager from the Foundation framework, which is used for working with locations and directories in the filesystem in all kinds of apps, including command-line apps. You can use a FileManager to create, move, delete, and learn about files and directories. You could create your own instance, but there is generally no need to, since there is a default instance available.

//    Next, you call the urls(for:in:) method of the file manager to look up a list of document directories that you can access. This method is designed to search for different locations, from system-owned temporary directories to user-owned document directories. The .documentDirectory case of the FileManager.SearchPathDirectory enum specifies that you want a directory appropriate for storing documents, as opposed to other types of files such as caches or temporary files. The .userDomainMask case of the FileManager.SearchDomainMask enum tells the file manager to look within the user’s home folder.
//    The return value of urls(for:in:) is an array of URL instances representing the location of local directories where you can store and retrieve data.
//    The number of directories returned by urls(for:in:) depends on its arguments. Since you are searching for the .documentDirectory in the .userDomainMask, there will be exactly one object in the returned array. Finally, you append the tasks.json path component to the URL so that the final resulting URL represents the location on disk where you will save and load the tasks.

    
    @Published private(set) var tasks: [Task] = [] { // Publisher observer
        didSet {
            print("There are now \(tasks.count): \(tasks)")
        }
    }
    
    //  Any time the tasks property changes (such as by adding or removing a task), the TaskStore instance can publish knowledge of the change to any observing views.
    //  By declaring conformance to the ObservableObject protocol, TaskStore states its willingness to be observed and its intent to publish updates of its @Published properties to observers.
    
    init() {
        loadTasks()
    }
    
    func add(_ task: Task) {
        tasks.append(task)
        saveTasks()
    }
    
    func remove(_ task: Task) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks.remove(at: index)
        saveTasks()
    }
    
    private func saveTasks() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(tasks)
            try data.write(to: fileURL)
            print("Saved \(tasks.count) tasks to \(fileURL.path)")
        } catch {
            print("Could not save tasks. Reason: \(error)")
        }
    }
    
    private func loadTasks() {
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            tasks = try decoder.decode([Task].self, from: data)
            print("Loaded \(tasks.count) tasks from \(fileURL.path)")
        } catch {
            print("Did not load any tasks. Reason: \(error)")
        }
    }
    
//    Here, you create an instance of JSONEncoder, a type that can encode instances of various types into instances of Data using its throwing encode(_:) method. Data is a type that encapsulates arbitrary chunks of type-agnostic data: just a pile of ones and zeroes.
//    When you are transferring data to the disk or across a network, the APIs that handle the transmission generally do not care how your information is encoded. It is up to the saving and loading code – or transmitting and receiving code – to agree on how to interpret and translate the contents of an instance of Data. You are using JSON, but there are other formats available.
    
//    What types can JSONEncoder work with? Any type that conforms to Swift’s Encodable protocol.
//    That means the Task type must be Encodable. You will also want to decode instances of Data back into an array of tasks; that process will require Task to conform to the Decodable protocol. So to support both encoding and decoding, Task will need to be both Encodable and Decodable.
    
//    To save you some typing, Swift defines a protocol composition of Encodable and Decodable called, simply, Codable. Make Task conform to Codable.
    
//    Both encode(_:) and write(to:) can fail for reasons related to disk permissions or corrupt data, and they will throw errors if they cannot finish their work. A more robust application would visually notify the app’s user that the save had failed.
    
//    Since the Data type does not know anything about the kind of data it contains, the decode(_:from:) method of the JSONDecoder must be told how to interpret the contents of the Data. If the Data contains the wrong kind of information, such as an array of integers instead of an array of tasks, decode(_:from:) will throw an error.
}

#if DEBUG
extension TaskStore {
    static var sample: TaskStore = {
        let tasks = [
            Task(title: "Add features"),
            Task(title: "Fix bugs"),
            Task(title: "Ship it")
        ]
        let store = TaskStore()
        store.tasks = tasks
        return store
    }() }
#endif

//The new syntax is #if DEBUG and #endif. These compiler control statements allow you to specify chunks of code that should only be compiled into your program under certain conditions. Notice that the compiler control statements do not create braced scopes; the conditionally compiled code is between the lines containing #if and #endif.

//the #warning and #error expressions are examples of another type of compiler control statement called a compile-time diagnostic.

// MARK: Saving and Loading User Data
//The TaskStore is not currently saving tasks to disk or loading saved tasks on launch. It is time to fix that so that you can relegate the sample data to the preview providers.
//To begin, you will need a FileManager. The FileManager type allows you to work with the contents of the filesystem, such as generating the local URL of a place where you can save data. The URL type is basically a specialized string that refers to the location of a resource like a locally stored file or a document on the internet.
