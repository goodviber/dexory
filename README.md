# README
The app uses Ruby 3.1.0 and Rails 7.1.3.2 with postgres db, make sure you have the correst ruby version and postgres installed locally.

Clone the repo

`cd dexory`    
`bundle install`    
`yarn install` optional    
`rails db:prepare`    
`rails server`    

Tests run with `rspec`

On successfull install you will be on the root page, lists#index    
You will need to simulate a ScanReport upload with a curl command in the terminal.    
`curl -X POST -F "scan_report[json_file]=@path/to/jsonfile" http://localhost:3000/scan_reports`   
A successful upload will return `{"scan_report_id":1}%`    
Next upload a csv Inventory file. You can upload as many files of either type as needed.    
Enter the IDs of the required files in the input boxes for comparison, you will now be presented with a comparison report, with the option to download as a csv file.

It can be difficult when attempting these types of tech interviews to know how much detail to go into, for brevity I have left out integration tests, error scenario catching, flash messages etc. The tests run on 2 fixture files which cover the required statuses.    
I have done some work on file management, with image and video uploads, and am aware of some of the quirks and tradeoffs with validations, I have not covered these scenarios in this app.    

The main activity occurs in the inventories, lists and scan_reports controllers. Files are attached to barebones models with ActiveStorage and there is a CompareFile service which does the comparisons.
