# covidapp


A corona virus tracker android application


An android application that tracks the cases of corona virus accross the world
It was developed using google's Flutter cross-platform framework.
I fetched the Data from NovelCOVID API, get it here https://documenter.getpostman.com/view/8854915/SzS7R6uu?version=latest#84845016-70ae-4a1f-8e7a-d4b9a0289050.

Get the app here https://benacq.github.io/covid-satellite/


# FEATURES

- Displays the total number of cases, deaths, recoveries and other detailed information globally

- Displays total number of cases, deaths, recoveries and other detailed information for a country of your choice, you h ave an option to choose whatever country you want

- A visualization of how the pandemic has spread accross the world nicely dispayed on the map with a detailed information of the countries when a marker of a specific country is tapped.

# NOTE
If you intend to clone the source code and play around with it, 

- Navigate to ./android/app/src/main/AndroidManifest.xml
- Look for this line ```<meta-data android:name="com.google.android.geo.API_KEY" android:value="@string/key"/>```
- Replace "@string/key" with your API Key activated with google map
- The app will not run without that piece.


https://meet.google.com/jhj-sxwd-adp
