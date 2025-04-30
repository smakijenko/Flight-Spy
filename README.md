# Flight Spy - flight tracker app 
👋 Hi!

✈️ Let me introduce Flight Spy — a simple and useful SwiftUI app that lets you track real-time aircraft flying over Europe.

The app uses the free API from opensky-network.org to show live airplane positions on the map. To provide more details about specific flights, I used PHP scraper that collects extra public flight information.

The interface is clean and easy to use, with flight data displayed in neatly organized tiles, making browsing clear and enjoyable.

To ensure a smooth user experience, the app includes error handling throughout the entire data flow. Any issues with loading data, API responses, or connectivity are caught by backend managers, and the user is informed via clear system alerts, so they always know what’s going on.

🟥 Here is a link to the youtube video, that shows how the app looks like: https://youtu.be/ctARyKBTel4

🔥 A few interesting features that are implemented into the app:

◻️ Slide in tab with image of the aircraft, informations about the flight and menu at the bottom with buttons to show some extra informations about the flight and path of the flight.

▫️ To get data about the flight I used PHP scraper, that scrapes informations from: https://radarbox.com.

![ezgif com-optimize](https://github.com/user-attachments/assets/4f7ae1a9-ba11-4a54-809d-fdf6ed498354)

◻️ Drop up menu, with a list of regions on which the user can track the aircrafts.

![ezgif com-optimize](https://github.com/user-attachments/assets/63088bd4-7c06-46e9-b2cf-e67d0569a3cb)

◻️ As I named it - Pulsator. It is an aircraft position refresh indicator. On tap, it shows intervals drop down menu.

![ScreenRecording_11-06-202415-23-34_1-ezgif com-optimize](https://github.com/user-attachments/assets/4191a923-bff0-4e6b-80d3-93ca9d369ca9)

◻️ Button, with an action of finding user current location. If the location is on regions list, it automatically starts showing aircrafts in the region.

![ezgif com-optimize](https://github.com/user-attachments/assets/0435bb37-ebb6-4ea8-bc60-c456301c3580)

◻️ Button, with an action of switching between aircrafts currently on ground or airborn.

![ezgif com-optimize](https://github.com/user-attachments/assets/8363564e-e87a-406d-ad15-f7d9d68bfaf8)





