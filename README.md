# 4407-assignment-2

Student name: Zhenhao Zhu

Student ID: 24065267

# Board Games Analysis Project

### Repository

This assignment uses git and is hosted on GitHub:

```bash
git clone https://github.com/dynamicCat/4407-assignment-2.git
```

## Overview

This project analyzes the Board Games Geek dataset to answer research questions about board game popularity, mechanics, domains, and correlations between various game attributes. The implementation consists of three shell scripts that handle data quality checking, preprocessing, and analysis.

⚠️ **Important**: Before running the scripts, make sure they have executable permissions:

```bash
chmod +x empty_cells preprocess analysis
```

## Requirements

- Bash shell environment (Linux/Unix)
- AWK (GNU Awk recommended)
- Core Unix utilities: sed, tr, etc.

## Project Structure

```
.
├── empty_cells # Script to check data quality
├── preprocess # Script to clean the dataset
├── analysis # Script to analyze the data
├── README.md # This documentation file
├──sample.txt # data file
└──more data files...
```

## Scripts

### 1. `empty_cells`

Analyzes a spreadsheet-like text file to count empty cells in each column.

#### Usage

```bash
./empty_cells <file> <separator>
```

#### Parameters

- `file`: Path to the input file
- `separator`: Character used as field separator in the input file (e.g., ';')

#### Output

Outputs the column titles and the number of empty cells in each column.

#### Example

```bash
$ ./empty_cells sample.txt ";"
/ID: 0
Name: 0
Year Published: 0
Min Players: 0
Max Players: 0
Play Time: 0
Min Age: 0
Users Rated: 0
Rating Average: 0
BGG Rank: 0
Complexity Average: 0
Owned Users: 0
Mechanics: 0
Domains: 0
```

#### Features

- Handles custom field separators
- Detects Windows line endings (CRLF)
- Reports errors for unreadable files
- Warns about data rows with more fields than the header

### 2. `preprocess`

Cleans the dataset by performing multiple transformations.

#### Usage

```bash
./preprocess <file>
```

#### Parameters

- `file`: Path to the input file

#### Output

Outputs a cleaned version of the input file with the following transformations:

- Semicolon separators converted to tab characters
- Windows line endings (CRLF) converted to Unix line endings (LF)
- Decimal commas (e.g., "1,23") converted to decimal points (e.g., "1.23")
- Non-ASCII characters removed
- New unique IDs generated for empty or non-numeric IDs

#### Features

- Creates temporary files that are properly cleaned up on exit
- Uses safe Bash practices (set -euo pipefail)
- Maintains data integrity while cleaning

### 3. `analysis`

Analyzes the cleaned dataset to answer the research questions.

#### Usage

```bash
./analysis <tsv_file>
```

#### Parameters

- `tsv_file`: Path to the tab-separated preprocessed file

#### Output

Outputs answers to the following research questions:

- The most popular game mechanics and in how many games it appears
- The most popular game domain and in how many games it appears
- The correlation between publication year and average rating
- The correlation between game complexity and average rating

#### Example

```bash
$ ./analysis sample.tsv
The most popular game mechanics is Hand Management found in 48 games
The most game domain is Strategy Games found in 77 games

The correlation between the year of publication and the average rating is 0.226
The correlation between the complexity of a game and its average rating is 0.426
```

#### Features

- Dynamically identifies column positions, maintaining flexibility
- Handles empty fields in Mechanics and Domains columns
- Calculates Pearson correlation coefficients
- Filters out invalid data for correlation calculations

## Safety Features

### Script Security

- All scripts have proper error checking
- Temporary files are automatically cleaned up
- Input validation prevents common errors

### Data Integrity

- The preprocessing step ensures data is properly formatted
- Invalid data points are excluded from correlation calculations
- Empty cells in Mechanics and Domains are handled correctly

## How to Use

### Step 1: Check data quality

```bash
./empty_cells bgg_dataset.txt ";"
```

This step helps you understand what issues exist in your data before processing.

### Step 2: Preprocess the data

```bash
./preprocess bgg_dataset.txt > bgg_dataset.tsv
```

This step cleans the data and prepares it for analysis. Make sure to redirect the output to a new file.

### Step 3: Analyze the data

```bash
./analysis bgg_dataset.tsv
```

This step performs the actual analysis on the cleaned data file.

## Troubleshooting

### Common Issues and Solutions

1. **Permission denied**:

   ```
   -bash: ./empty_cells: Permission denied
   ```

   **Solution**: Ensure scripts have execution permissions

   ```bash
   chmod +x empty_cells preprocess analysis
   ```
2. **Separator confusion**:

   ```
   Error: Unexpected field count
   ```

   **Solution**: Make sure you're using the correct separator character

   ```bash
   ./empty_cells bgg_dataset.txt ";"  # Note the quotes around the separator
   ```
3. **Invalid input data**:
   If your input data has unexpected format issues, try examining it first

   ```bash
   head -n 5 bgg_dataset.txt  # View first 5 lines to check format
   ```

## Implementation Details

### Data Cleaning Process

1. Converts CRLF to LF using `sed`
2. Replaces semicolon separators with tabs
3. Converts decimal commas to decimal points
4. Removes non-ASCII characters using `tr`
5. Generates new unique IDs for empty/non-numeric ID fields

### Analysis Process

1. Identifies the most popular mechanics and domains by counting occurrences
2. Calculates the Pearson correlation between:

- Publication year and average rating
- Game complexity and average rating

## Error Handling

- All scripts check for input file existence and readability
- Proper usage information is displayed when incorrect parameters are provided
- The `preprocess` script uses `trap` to ensure temporary files are cleaned up
- `set -euo pipefail` is used to enforce strict error checking

## Script Modifications

If you need to modify the scripts, here are some important points:

1. The column names and order are assumed to match the original dataset
2. All scripts use AWK with tab field separator for the cleaned data
3. If you change one script, make sure to check if others need updates
4. The scripts are designed to be used in sequence (`empty_cells` → `preprocess` → `analysis`)

## Testing

The scripts have been tested with the following sample files:

- `sample.txt` and `sample.tsv` (first 100 lines)
- `sample1.txt` and `sample1.tsv` (contains empty cells)
- `tiny_sample.txt` and `tiny_sample.tsv` (minimal test case)

### Testing Procedure

1. Test `empty_cells` on all input formats
2. Verify `preprocess` correctly transforms input files
3. Confirm `analysis` produces expected results for all test files
4. Test the entire pipeline with direct piping between scripts

## Performance Considerations

- The scripts are optimized for typical dataset sizes
- For extremely large datasets (>100MB), consider:
  - Processing in batches
  - Using more memory-efficient approaches
  - Running on machines with sufficient memory

## Example Results

When run on the sample dataset, the analysis produces results like:

```
The most popular game mechanics is Hand Management found in 48 games
The most game domain is Strategy Games found in 77 games

The correlation between the year of publication and the average rating is 0.226
The correlation between the complexity of a game and its average rating is 0.426
```
