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
Enter the IDs of the required files in the input boxes for comparison, you will no be presented with a comparison report, with the option to download as a csv file.
