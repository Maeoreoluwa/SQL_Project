# AxiaStores SQL Database Project
## Project Overview
This project demonstrates a complete SQL based solution for an Electronics & Accessories retail business, *AxiaStores*. It involves designing and implementing a relational database with three core tables, Customer, Product, and Orders. While performing various analytical queries to extract insights.
## Objectives
The primary goal of this project is to
- Create a sample relational database
- Creation of multiple tables within the database with appropriate data types and constraints:
- Insertion of sample records into all tables
- Query functions like:
  - Retriever of customer details
  - Sorting alphabetically
  - The use of Join funtion for multiple tables
  - Use of aggregate functions like average and sum
    ## Tools and Methodologies 
*Tool Used:* *SQL SERVER MANAGEMENT STUDIO 21* [Download Here](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)
## Key Analytical Questions
The queries in this project aim to answer the following key questions based on the AxiaStores dataset:
1. Return the FirstName and Email of every customer who has ever purchased the product “Wireless Mouse”
2. List all customers’ full names in ascending alphabetical order (LastName, then FirstName)
3. Show every order together with the customer’s full name, the product name, quantity, unit price, total price (quantity × unit price), and order date
4. Show average sales per product category and sort in descending order
5. Which city generated the highest revenue for AxiaStores
1. *CREATING DATABASE*
<pre>
CREATE DATABASE [AxiaStores]; --SQL Server
</pre>
