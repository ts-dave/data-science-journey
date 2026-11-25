if(!require(pacman)) install.packages("pacman")
pacman::p_load(
  tidyverse
)


#### Ungraded Lab: Advanced Data Transformation Practice ----

# ================================================
# Activity 1: Load and Examine the Data
# ================================================

# Load the retail dataset (retail_set3.csv)
item_data <- read_csv("data/raw/retail_set3.csv")  # read_csv() from the readr package reads the CSV file into a data frame.

# Examine the data structure
print(head(item_data)) # head() shows the first few rows of data.

print(str(item_data))  # str() shows the structure of the data frame, including column names and data types. This helps understand the data's organization.

# ================================================
# Activity 2: Creating New Calculated Fields
# ================================================
# Create a new field named composite_score by combining existing fields. This example weights ratings and customer reviews.

# Example:
# item_data <- item_data %>%
#   mutate(composite_score = (Rating * 0.7 + Customer_Reviews * 0.3))

#Add a new binary variable, fast_shipping, to indicate whether the item has a shipping speed of "Fast".

#Example:
item_data <- item_data %>%
  mutate(fast_shipping = if_else(Shipping_Speed == "Fast", TRUE, FALSE))

#Additionally, create a new field called revenue by multiplying the Price by the Customer_Reviews to estimate the total revenue for each item. 

item_data <- item_data %>%
  mutate(revenue = Price * Customer_Reviews)

#output
head(item_data)


# Try it Out #1 : Create the new variable using mutate().

# <YOUR CODE HERE>


# ================================================
# Activity 3: Summarizing Data
# ================================================
# Calculate the average rating for all items.

# Example
avg_rating <- item_data %>%
  summarize(avg_rating = mean(Rating, na.rm = TRUE))
print(avg_rating)

#Calculate the total revenue for each category.

#Example
category_revenue_summary <- item_data %>%
  group_by(Category) %>%
  summarize(total_revenue = sum(revenue, na.rm = TRUE))
print(category_revenue_summary)

#Calculate the total revenue for items that have "Fast" shipping speed. Use the filter() to select them before summarizing.

#Example
fast_shipping_summary <- item_data %>%
  filter(Shipping_Speed == "Fast") %>%
  group_by(Category) %>%
  summarize(total_revenue = sum(revenue, na.rm = TRUE))
print(fast_shipping_summary)

#Find the overall count of items in each category to understand product distribution.

#Example
category_item_count <- item_data %>%
  group_by(Category) %>%
  summarize(item_count = n())
print(category_item_count)


# Try it Out #1 : Summarize the count of fast shipping items for each category using summarize().

item_data |> 
  filter(fast_shipping == TRUE) |> 
  group_by(Category) |> 
  summarize(count = n())

# ================================================
# Activity 4: Performing Grouped Analysis
# ================================================
# Compare average customer reviews and total revenue within each shipping speed to understand how shipping speed impacts sales and satisfaction.

# Example
shipping_analysis <- item_data %>%
  group_by(Shipping_Speed) %>%
  summarize(
    avg_rating = mean(Rating, na.rm = TRUE),
    revenue = sum(revenue, na.rm = TRUE)
  )
print(shipping_analysis)

# Analyze and compare category rating performance based on total revenue.

# Example
# category_performance_analysis <- item_data %>%
#   group_by(Category) %>%
#   summarize(
#     avg_rating = mean(Rating, na.rm = TRUE),
#     revenue = sum(total_revenue, na.rm = TRUE)
#   )
# print(category_performance_analysis)

#Combine category and shipping speed for a more detailed analysis to identify trends within specific segments.

# Example
combined_analysis <- item_data %>%
  group_by(Category, Shipping_Speed) %>%
  summarize(
    avg_rating = mean(Rating, na.rm = TRUE),
    revenue = sum(revenue, na.rm = TRUE)
  )
print(combined_analysis)


# Try it Out #1 : Summarize the total revenue for standard shipping items by category using group_by() and summarize(). Save in a variable called "revenue".
revenue <- item_data |> 
  filter(Shipping_Speed == "Standard") |> 
  group_by(Category) |> 
  summarize(total_revenue = sum(revenue))
print(revenue)

# ================================================
# Bringing it all Together
# ================================================
# Fill in the blanks with the appropriate code below:

# Problem #1 : Create a report that highlights average rating and total revenue.

# Step 1: Calculate average rating for each category
avg_rating_by_category <- item_data %>%
  group_by(Category) %>%
  summarize(avg_rating = mean(Rating, na.rm = TRUE))
    # Group by Category, then calculate the average rating (excluding missing values)

print(avg_rating_by_category)

# Step 2: Calculate total revenue for each category
total_revenue_by_category <- item_data %>%
  group_by(Category) %>%
  summarize(total_revenue = sum(revenue, na.rm = TRUE))
  # Group by Category, then sum up the revenue (ignoring NA values)

print(total_revenue_by_category)




########################################################
##### Reshaping data using tidyr ----
########################################################
# Reshaping from wide to long, vice versa.

# Data Format Transformation Practice

# Install necessary packages (if not already installed)
# install.packages("tidyverse")  # This line installs the tidyverse package, which includes dplyr and readr.

# ================================================
# Activity 1: Importing and Understanding Your Data
# ================================================

# Load the retail dataset (retail_set4.csv)
data4 <- read_csv("data/raw/retail_set4.csv")  # read_csv() from the readr package reads the CSV file into a data frame.

# Examine the data structure
str(data4)  # str() shows the structure of the data frame, including column names and data types. This helps understand the data's organization.

# ================================================
# Activity 2: Converting Wide Data into Long Format
# ================================================
# Use pivot_longer() to transform from wide to long, creating columns "Product" and "Sales".

# Example:
# sales_long <- sales_data %>%
# pivot_longer(cols = starts_with("Product"), 
#               names_to = "Product", 
#               values_to = "Sales")

# head(sales_long)


# sales_long <- sales_data %>%
# pivot_longer(cols = c(Product_A_Sales, Product_B_Sales),
#               names_to = "Product",
#               values_to = "Sales")



# Try it Out #1 : Use pivot_longer() to transform the dataset, including only "Product_A_Sales" and "Product_B_Sales" columns.

data4 |> 
  select(-Product_C_Sales) |> 
  pivot_longer(
    cols = starts_with("Product"),
    names_to = "Product",
    values_to = "Sales"
  )

# Try it Out #2 : Use pivot_longer() to transform the dataset, including only "Product_C_Sales" and "Product_B_Sales" columns.

# Check with all.equal(original_totals$Product_A_Sales_Total , reshaped_totals$Product_A_Sales_Total)
data4 |> 
  select(-Product_A_Sales) |> 
  pivot_longer(
    cols = starts_with("Product"),
    names_to = "Product",
    values_to = "Sales"
  )


# ================================================
# Activity 3: Transforming Data from Long to Wide Format
# ================================================
# Use pivot_wider() to turn your long format back into wide, creating separate columns for each product.
# Example

# sales_wide <- sales_long %>%
# pivot_wider(names_from = Product, values_from = Sales)

# print(head(sales_wide))

# Try it Out #1 : Use pivot_wider() to transform the dataset, creating separate columns for each product.

# <YOUR CODE HERE>

# ================================================
# Activity 4: Checking Data Accuracy after Reshaping
# ================================================
# Compare the summary statistics of your original data against the reshaped version. Checking these numbers quickly ensures accuracy.
# Example

# Calculate original total sales per product (wide data)
original_totals <- sales_data %>% 
 summarize(across(starts_with("Product"), sum))

# Calculate total sales per product after reshaping (long to wide)
# reshaped_totals <- sales_wide %>% 
#  summarize(across(starts_with("Product"), sum))

# Check if totals match
# print(original_totals)
# print(reshaped_totals)

# Try it Out #1 : Compare the summary statistics of the original data against the reshaped version to confirm that the totals match.

# <YOUR CODE HERE>

# ================================================
# Bringing it all Together
# ================================================

# Problem #1: Fill in the missing key parts

# Step 1: Convert the data from wide to long format
# In wide format, each product has its own column. We want to reshape this so we can 
# analyze all products using a single column for product names and another for sales.
# Use starts_with() to select all columns that represent product sales
# Choose a name for the column that will store the original column names (like "Product")
# Choose a name for the column that will store the actual sales values (like "Sales")

data4_long <- data4 %>%
  pivot_longer(cols = starts_with("_____"),      # Think: what prefix do all the product columns share?
               names_to = "_____",               # What do you want to call the column for product names?
               values_to = "_____")              # What should the new sales values column be called?

# Step 2: Summarize total sales for each product in long format
# Now that each row includes a product name and its sales:
# Use group_by() to group the data based on the product name column you just created
# Use summarize() to total the sales for each product

total_sales_long <- sales_long %>% 
  group_by(_____) %>%                    # Use the same name you used in `names_to`
  summarize(total_sales = sum(_____))     # Use the same name you used in`values_to`

# Step 3: Convert the data back to wide format
# To return to wide format:
# Use pivot_wider()
# The column with product names will become the new headers
# The column with sales values will be spread across the new product columns

sales_wide <- sales_long %>%
  pivot_wider(names_from = _____,                # This should match your `names_to` from Step 1
              values_from = _____)               # This should match your `values_to` from Step 1

# Step 4: Summarize sales again from the wide format
# In wide format again, each product has its own column. To total each product:
# Use summarize()
# Use across() with starts_with() to apply sum() to every product column at once
total_sales_wide <- sales_wide %>% 
  summarize(across(starts_with("_____"), sum)) # Match the same prefix you used in Step 1

# Step 5: Convert wide totals to long format for fair comparison
#  Convert wide totals to long format for fair comparison
total_sales_wide_long <- _____ %>%
  pivot_longer(cols = starts_with("____"), names_to = "Product", values_to = "total_sales")


# Step 6: Check if both summaries match

# Use all.equal() to compare your total sales in long vs. wide formats.
# If the result is TRUE, then your transformation logic is solid.
all_equal <- all.equal(_____, _____)  # Compare total_sales_long and total_sales_wide

print(all_equal)
