#  Supplier Test App
# Original Test assignment
````
We have developed a simple assignment to imitate a real system situation in SupplierPlus. The test assignment should show the candidates' ability of system thinking, coding style, code versioning and testing skills.

# Feature: Invoice upload

As a customer, I would like to upload files and get them converted into Invoices with precalculation.

1. A customer prepares a CSV file with invoices: the first column is internal invoice id, the second is invoice amount and third is the due on date

```
1,100,2019-05-20
2,200.5,2019-05-10
B,300,2019-05-01
```

The test file includes five thousand rows and includes invalid rows.

2. Customer can upload invoice CSV to the system
3. System processes file so that every invoice gets the selling price according to the next logic:
> Invoice sell price depends on amount and days to the due date. The formula is `amount - amount * discount`. The discount is 0.5% when the invoice uploaded more than 30 days before the due date and 0.3% when less or equal to 30 days.

3. Customer can check invoices uploaded to the system and check their selling price.
4. Customer can see an upload report and understand errors related to CSV file row processing.
````

* Prepare to run App 
In file .env can check and edit this ENV variables

* Prepare DB

Create, migrate, seed DB
````
rake db:create db:mirate db:seed
````

Create Service to generate random invoice 
(can set number of ROWS), use rake for generate incorrect invoices

Correct invoice
````
rake generate_csv_invoices:correct\[5000\] 
````
Incorrect invoice
````
rake generate_csv_invoices:incorrect\[5000\] 
````

Files can find on path [public/invoices/files/correct_rows_count.csv]


* Run application 

````
bin/dev
````
* use Rspec test

run test
````
rspec
````
* Functional 
Basic description

For login Admin pre-setup user admin@supplier.com / qwerty123 (after run rake db:seed)

User can see only own Invoices. 
Admin have access to all invoices
Object Attachment for upload CSV invoices from User
At Model Invoice has process precalculate sell_price according amount and due_date

* Integrate coverage checks (Simplecov). Check Percent at folder [coverage] open index.html 
````
rspec
````


