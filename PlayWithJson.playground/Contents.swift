import UIKit

let exampleJSON = """
    {
      "branch": {
        "subject": 5,
        "total_students": 110,
        "total_books": 150
      },
      "Subject": [
        {
          "subject_id": 301,
          "name": "EMT",
          "pratical": false,
          "pratical_days": [
            "Monday",
            "Friday"
          ]
        },
        {
          "subject_id": 302,
          "name": "Network Analysis",
          "pratical": true,
          "pratical_days": [
            "Tuesday",
            "Thursday"
          ]
        }
      ]
    }
    """

struct Student: Codable {
    let branch: Branch
    let subjects: [Subject]
    
    enum CodingKeys: String, CodingKey {
        case branch = "branch"
        case subjects = "Subject"
    }
}

struct Branch: Codable {
    let subject: Int
    let totalStudents: Int
    let totalBooks: Int
    
    enum CodingKeys: String, CodingKey {
        case subject = "subject"
        case totalStudents = "total_students"
        case totalBooks = "total_books"
    }
}

struct Subject: Codable {
    let ID: Int
    let name: String
    let isPractical: Bool
    let practicalDays: [String]
    
    enum CodingKeys: String, CodingKey {
        case ID = "subject_id"
        case name = "name"
        case isPractical = "pratical"
        case practicalDays = "pratical_days"
    }
}

func getStudentsData(with data: Data) {
    do {
        //let data = Data(exampleJSON.utf8)
        let decoder = JSONDecoder()
        let response = try decoder.decode(Student.self, from: data)
        print(response.branch)
    } catch {
        print(error)
    }
}

getStudentsData(with: Data(exampleJSON.utf8))

func makeRequestToRemote() {
    let url = URL(string: "")!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        getStudentsData(with: data!)
    }
    task.resume()
}
