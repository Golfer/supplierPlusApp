#  Supplier Test App

* Prepare to run App 
In file .env can check and edit this ENV variables

* Prepare DB

Create db if not present
````
rake db:create
````
Run migration and seed DB
````
bin/setup
````


Generate file with random invoices(can set number of ROWS), can generate incorrect data

Correct invoice
````
rake generate_csv_invoices:correct\[5000\] 
````

Incorrect invoice
````
rake generate_csv_invoices:incorrect\[5000\] 
````

This find this files on path [public/invoices/files/correct_rows_count.csv]

* Run application 

````
bin/dev
````



* use Rspec for test

Run
````
rspec
````

User can see only own Invoices. Admin have access to all invoices

test admin: admin@supplier_plus.com / qwerty (after run rake db:seed) 