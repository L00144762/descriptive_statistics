#frequency and contingency tables from categorical variables

# Contingency tables tell you the frequency or proportions
# of cases for each combination of the variables that make up the table

# describeBy() - ---------------------------------------
library(psych)
# DescribeBy() doesn’t allow you to specify
# an arbitrary function, so it ’s less generally applicable
describeBy(mtcars_variables, list(am = mtcars$am))

install.packages("vcd")
library(vcd)
head(Arthritis)
# Treatment, sex, and improved are categorical factors
str(Arthritis)

# one-way table ----------------------------------------
# simple frequency counts using the table() function
mytable <- with(Arthritis, table(Improved))

# Turn these frequencies into proportions
# Expresses table entries as fractions of the 
# marginal table defined by the margins
# In this example we dont have a representation for margins
prop.table(mytable)*100

# two-way tables -------------------------------------------
# use syntax mytable <- table(A, B)
# where A is the row variable and B is the column variable

# Alternatively use xtabs() ---------------------------------
# the variables to be cross-classified appear on the right 
# of the formula (that is, to the right of the ~) separated by + signs
# If variable is included on the left side of the formula, 
# it’s assumed to be a vector of frequencies 
# (useful if the data have already been tabulated).
mytable <- xtabs(~Treatment + Improved, data = Arthritis)
mytable

# generate marginal frequencies
# for mytable
# The index (1) refers to the first variable 
# in the table() statement
# This means proportional table by index (1)
# examines proportions by treatment
# and index (2) examines improved proportions
margin.table(mytable, 1)

# Looking at the table, we can see that 51% of treated 
# individuals had marked improvement, compared to 16% 
# of those receiving a placebo.
prop.table(mytable, 1)

# For column sums and proportions we use the same
# commands but examine the second variable in
# the table() statement
# Note - 1st variable = rows, 2nd variable = columns
# Here, the index (2) refers to the second 
# variable in the table() statement.
margin.table(mytable, 2)
prop.table(mytable, 2) 
# Cell proportions obtained using this statement
prop.table(mytable)
# addmargins() function to add marginal sums 
# to these tables. For example, the following 
# code adds a Sum row and column:
addmargins(mytable)

# Add marginal sums to proportion table
addmargins(prop.table(mytable))
mytable
# default is to create sum margins for all 
# variables in a table. 
# The following code adds a Sum column alone
addmargins(prop.table(mytable, 1), 2)
# Similarly, this code adds a Sum row:
addmargins(prop.table(mytable, 2)*100, 1)
# 25% of those patients with marked improvement received a placebo

install.packages("gmodels")
library(gmodels)
# options to report percentages (row, column, and cell) 
# specify decimal places; produce chi-square, Fisher, 
# and McNemar tests of independence; report expected 
# and residual values (Pearson, standardised, and adjusted 
# standardised) include missing values as valid; annotate 
# with row and column titles; and format as SAS or SPSS style output
help(CrossTable)
CrossTable(Arthritis$Treatment, Arthritis$Improved)

# Multidimensional tables ---------------------------------------
# This code produces cell frequencies for the three-way 
# classification. 
# Treatment and Sex are shown in 2 dimensional table
# for each state of Improved
mytable <- xtabs(~Treatment + Sex + Improved, data = Arthritis)
mytable
help(xtabs)

# This code demonstrates how the ftable()
# function can be used to print a more compact
# version of the table.
ftable(mytable)

# The code in this section produces the marginal frequencies for Treatment, Sex, and
# Improved. Because you created the table with the formula ~ Treatment + Sex +
# Improved, Treatment is referred to by index 1
# Sex is referred to by index 2, and Improved is referred to by index 3.

# Marginal frequencies by treatment
margin.table(mytable, 1)

# marginal frequencies by sex
margin.table(mytable, 2)

# marginal frequencies by Improved
margin.table(mytable, 3)

# This code produces the marginal frequencies 
# for the Treatment x Improved
# classification, summed over Sex.
# See earlier ftable() output for 
# explanation of results
margin.table(mytable, c(1, 3))

# The proportion of patients with None, Some, and
# Marked improvement for each Treatment × Sex 
# combination is provided
ftable(prop.table(mytable, c(1, 2)))

# 36% of treated males had marked improvement, compared to 59% of
# treated females. In general, the proportions will add to 1 over the indices not
# included in the prop.table() call(the third index, or Improved in this case) . You can
# see this in the last example, where you add a sum margin over the third index (Improved)

ftable(addmargins(prop.table(mytable, c(1, 2)), 3))

# percentages instead of proportions, you can multiply the resulting
# table by 100. For example, this statement
ftable(addmargins(prop.table(mytable, c(1, 2)), 3)) * 100

