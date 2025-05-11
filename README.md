# HaHor iOS application

HaHor application is an application to find your match dormitory near Kasetsart University.

Feature
- Login/Signin
- Interactive Map
- Sorting and Filtering
- Favorite dormitory
- Review Dormitory

## How to start HaHor Application
1. Clone this repository
   ```
   git clone https://github.com/panitnt/HaHorApp.git
   ```
2. Change directory to this project
    ```
    cd HaHor
    ```
3. You Need to have a firebase with (for iOS application)
   - Authentication
   - Database
4. Clone this re
5. Put your `GoogleService-Info.plist` into this project
6. Clean Build Folder (Product > Clean Build Folder)
7. Build (Product > Build)

## How to insert data into Firebase
1. You Need to have a firestore with collection name `users` and `dorm`

2. You need to have `serviceAccountKey.json` from Firebase 

3. Insert this data to Firestore
    <details>
    <summary>Click to show sample data</summary>

    <br>

        [
        {
            "name": "Chapter One The Campus Kaset",
            "lat": 13.838547623879665,
            "lon": 100.57468375008631,
            "amenities": {
            "autolockdoor": true,
            "carpark": true,
            "clothesdryer": false,
            "fitness": true,
            "washingmachine": true,
            "wifi": true
            },
            "contact": {
            "address": "xxx ถนนงามวงศ์งานเกษตร",
            "email": "dorm1@mail.com",
            "phone": "0xxxxxxxxx"
            },
            "price": "9,000 -13,000",
            "avg_review": 4.5,
            "review_count": 2,
            "review": [
            {
                "comment": "good",
                "star": 5
            },
            {
                "comment": "good",
                "star": 4
            }
            ]
        },
        {
            "name": "THE PRIZE",
            "lat": 13.839187786604779,
            "lon": 100.5690649490483,
            "amenities": {
            "autolockdoor": false,
            "carpark": true,
            "clothesdryer": false,
            "fitness": false,
            "washingmachine": true,
            "wifi": true
            },
            "contact": {
            "address": "8, 118-119 Ngam Wong Wan 54 Alley, Lane 5, Lat Yao, Chatuchak, Bangkok 10900",
            "email": "dorm2@mail.com",
            "phone": "0xxxxxxxxx"
            },
            "price": "6,500 - 7,500",
            "avg_review": 1,
            "review_count": 3,
            "review": [
            {
                "comment": "Everything is bad. The more you speak, the worse it is. You should improve it.",
                "star": 1
            },
            {
                "comment": "Don't come here, everyone. It's so bad that I don't know what words to say.",
                "star": 1
            },
            {
                "comment": "Not worth the money. Too many rules and poor service.",
                "star": 1
            }
            ]
        },
        {
            "name": "Premio Vetro",
            "lat": 13.841150455794715,
            "lon": 100.57221382825519,
            "amenities": {
            "autolockdoor": true,
            "carpark": true,
            "clothesdryer": true,
            "fitness": true,
            "washingmachine": true,
            "wifi": true
            },
            "contact": {
            "address": "28 Ngamwongwan Rd, Lat Yao, Chatuchak, Bangkok 10900",
            "email": "dorm3@mail.com",
            "phone": "0xxxxxxxxx"
            },
            "price": "11,000-17,000",
            "avg_review": 4.3,
            "review_count": 3,
            "review": [
            {
                "comment": "Near Kasetsart University with lots of food nearby.",
                "star": 4
            },
            {
                "comment": "Great parking and convenient location.",
                "star": 5
            },
            {
                "comment": "Modern building with good atmosphere.",
                "star": 4
            }
            ]
        },
        {
            "name": "The Ville Kaset-sart Condominium",
            "lat": 13.846551762977924,
            "lon": 100.56347787318933,
            "amenities": {
            "autolockdoor": false,
            "carpark": true,
            "clothesdryer": false,
            "fitness": false,
            "washingmachine": true,
            "wifi": false
            },
            "contact": {
            "address": "58 Ngamwongwan Rd, Lat Yao, Chatuchak, Bangkok 10900",
            "email": "dorm4@mail.com",
            "phone": "0xxxxxxxxx"
            },
            "price": "12,000 - 16,000",
            "avg_review": 5,
            "review_count":4 ,
            "review": [
            {
                "comment": "Comfortable and convenient with plenty of parking.",
                "star": 5
            },
            {
                "comment": "Best dorm I’ve stayed in. Clean and peaceful.",
                "star": 5
            },
            {
                "comment": "All essentials are here and it's close to campus.",
                "star": 5
            },
            {
                "comment": "Highly recommended for students.",
                "star": 5
            }
            ]
        },
        {
            "name": "The Pixels",
            "lat": 13.841217655701405,
            "lon": 100.56863966556612,
            "amenities": {
            "autolockdoor": false,
            "carpark": true,
            "clothesdryer": false,
            "fitness": false,
            "washingmachine": true,
            "wifi": true
            },
            "contact": {
            "address": "98/57 Ngamwongwan 52, Intersection 13, Lat Yao, Chatuchak, Bangkok 10900",
            "email": "dorm5@mail.com",
            "phone": "0xxxxxxxxx"
            },
            "price": "8,200 - 8,500",
            "avg_review": 4.33,
            "review_count": 3,
            "review": [
            {
                "comment": "Great location, close to 7-Eleven and campus.",
                "star": 5
            },
            {
                "comment": "Parking is limited, but good transport options.",
                "star": 3
            },
            {
                "comment": "Minimalist design and cozy rooms.",
                "star": 5
            }
            ]
        },
        {
            "name": "Like@Kaset",
            "lat": 13.839405039033796,
            "lon": 100.56845727540212,
            "amenities": {
            "autolockdoor": false,
            "carpark": true,
            "clothesdryer": false,
            "fitness": false,
            "washingmachine": true,
            "wifi": true
            },
            "contact": {
            "address": "8, 98 Ngam Wong Wan 54 Alley, Lane 7, Lat Yao, Chatuchak, Bangkok 10900",
            "email": "dorm6@mail.com",
            "phone": "0xxxxxxxxx"
            },
            "price": "6,000 - 6,500",
            "avg_review": 4.33,
            "review_count":3,
            "review": [
            {
                "comment": "The dormitory is good, but the water is a bit warm during the day.",
                "star": 5
            },
            {
                "comment": "Wi-Fi gets slow sometimes when everyone is using it at night. Works better in the morning.",
                "star": 4
            },
            {
                "comment": "Not much storage space in the room, so bring organizers. But the layout is smart.",
                "star": 4
            }
            ]
        },
        {
            "name": "Manee @Kasetsart",
            "lat": 13.839956720744793,
            "lon": 100.56908897028866,
            "amenities": {
            "autolockdoor": false,
            "carpark": false,
            "clothesdryer": false,
            "fitness": false,
            "washingmachine": false,
            "wifi": true
            },
            "contact": {
            "address": "23, 40 Soi Than Phuying Phahon, Lat Yao, Chatuchak, Bangkok 10900",
            "email": "dorm7@mail.com",
            "phone": "0xxxxxxxxx"
            },
            "price": "4,500 - 6,700",
            "avg_review": 4,
            "review_count": 3,
            "review": [
            {
                "comment": "Rules are tight—no guests and early curfews. But it’s clean and well-organized if you like structure.",
                "star": 3
            },
            {
                "comment": "It’s an all-female dorm, so I feel very safe.",
                "star": 5
            },
            {
                "comment": "Rent is reasonable, and you get a lot for what you pay. I’m happy living here.",
                "star": 4
            }
            ]
        },
        {
            "name": "All Living",
            "lat": 13.84182202456744,
            "lon": 100.56872010360321,
            "amenities": {
            "autolockdoor": false,
            "carpark": true,
            "clothesdryer": true,
            "fitness": false,
            "washingmachine": false,
            "wifi": true
            },
            "contact": {
            "address": "89 Ngam Wong Wan Rd 52, Lat Yao, Chatuchak, Bangkok 10900",
            "email": "dorm8@mail.com",
            "phone": "0xxxxxxxxx"
            },
            "price": "5,500 - 6,000",
            "avg_review": 3.5,
            "review_count": 4,
            "review": [
            {
                "comment": "Value for money. Quiet. Car park available. But lift needed to be maintained more often.",
                "star": 4
            },
            {
                "comment": "Clean, safe, quiet, with adequate parking.",
                "star": 4
            },
            {
                "comment": "Clean and has a security guard as well. Good.",
                "star": 5
            },
            {
                "comment": "Old dormitory.",
                "star": 1
            }
            ]
        },
        {
            "name": "THE MUVE Kaset",
            "lat": 13.84260100416922,
            "lon": 100.569909815293,
            "amenities": {
            "autolockdoor": true,
            "carpark": true,
            "clothesdryer": true,
            "fitness": true,
            "washingmachine": true,
            "wifi": true
            },
            "contact": {
            "address": "29 Ngam Wong Wan 54 Alley, Lane 3, Lat Yao, Chatuchak, Bangkok 10900",
            "email": "dorm9@mail.com",
            "phone": "0xxxxxxxxx"
            },
            "price": "10,000 - 13,000",
            "avg_review": 5 ,
            "review_count":3 ,
            "review": [
            {
                "comment": "Newly built condo, clean, secure, good service. Parking space 2.10 meters high.",
                "star": 5
            },
            {
                "comment": "8-floor condo, suitable size for student life.",
                "star": 5
            },
            {
                "comment": "Beautiful room, good size, overall I really like it.",
                "star": 5
            }
            ]
        },
        {
            "name": "Phuttachat House",
            "lat": 13.842525535277826,
            "lon": 100.56851506171604,
            "amenities": {
            "autolockdoor": true,
            "carpark": false,
            "clothesdryer": false,
            "fitness": false,
            "washingmachine": true,
            "wifi": true
            },
            "contact": {
            "address": "98/73 Ngamwongwan Rd, Lat Yao, Chatuchak, Bangkok 10900",
            "email": "dorm10@mail.com",
            "phone": "0xxxxxxxxx"
            },
            "price": "3,800 - 6,800",
            "avg_review": 4.8,
            "review_count":5,
            "review": [
            {
                "comment": "Good dormitory, very close to Kasetsart University, just across the road, close to places to eat.",
                "star": 5
            },
            {
                "comment": "Safe, very clean.",
                "star": 5
            },
            {
                "comment": "Clean, cheap.",
                "star": 5
            },
            {
                "comment": "Good dormitory.",
                "star": 5
            },
            {
                "comment": "Convenient, clean.",
                "star": 4
            }
            ]
        }
        ]
        
    </details>

    <details>
    <summary>Click to show code to put data to firestore - Python code</summary>

    <br>

        import firebase_admin
        from firebase_admin import credentials, firestore
        import json

        last_item = 1

        cred = credentials.Certificate("serviceAccountKey.json")
        firebase_admin.initialize_app(cred)

        db = firestore.client()

        with open("message.json", "r") as f:
            data = json.load(f)

        for i, item in enumerate(data):
            # Add to "users" collection, auto-generated document ID
            db.collection("dorm").document(f"{last_item+i+1}").set(item)
            print(f"Inserted document {last_item+i+1}: {item}")

    </details>

