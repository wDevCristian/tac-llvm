#!/bin/bash

# Ensure a C++ source file is passed as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <source_file.cpp>"
    exit 1
fi

# Set source and output file names
SOURCE_FILE="$1"
BASE_NAME=$(basename "$SOURCE_FILE" .cpp)
LLVM_IR="${BASE_NAME}.ll"
OPTIMIZED_IR="${BASE_NAME}_optimized.ll"
OBJECT_FILE="${BASE_NAME}.o"
EXECUTABLE="${BASE_NAME}"
STATIC_ANALYSIS_REPORT="${BASE_NAME}_static_analysis.txt"

# Step 1: Compile the C++ source file to LLVM IR
echo "Step 1: Compiling C++ source to LLVM IR..."
clang++ -S -emit-llvm "$SOURCE_FILE" -o "$LLVM_IR"

# Check if LLVM IR was generated successfully
if [ ! -f "$LLVM_IR" ]; then
    echo "Error: LLVM IR generation failed."
    exit 1
fi

# Step 2: Static Analysis
echo "Step 2: Performing Static Analysis..."
clang++ --analyze "$SOURCE_FILE" > "$STATIC_ANALYSIS_REPORT"

# Check if any issues were found during static analysis
if [ -s "$STATIC_ANALYSIS_REPORT" ]; then
    echo "Static analysis issues found! Check the report: $STATIC_ANALYSIS_REPORT"
    cat "$STATIC_ANALYSIS_REPORT"
else
    echo "No issues found during static analysis."
fi

# Step 3: Optimize the LLVM IR
echo "Step 3: Applying optimizations to LLVM IR..."
opt -O2 "$LLVM_IR" -o "$OPTIMIZED_IR"

# Check if optimization was successful
if [ ! -f "$OPTIMIZED_IR" ]; then
    echo "Error: LLVM IR optimization failed."
    exit 1
fi

# Step 4: Generate the object file from the optimized LLVM IR
echo "Step 4: Generating object file from optimized LLVM IR..."
llc "$OPTIMIZED_IR" -filetype=obj -o "$OBJECT_FILE"

# Check if object file was generated successfully
if [ ! -f "$OBJECT_FILE" ]; then
    echo "Error: Object file generation failed."
    exit 1
fi

# Step 5: Link the object file to create the executable
echo "Step 5: Linking object file to create executable..."
clang++ "$OBJECT_FILE" -o "$EXECUTABLE"

# Check if the executable was created successfully
if [ ! -f "$EXECUTABLE" ]; then
    echo "Error: Executable creation failed."
    exit 1
fi

# Step 6: Run the executable (optional)
echo "Step 6: Running the executable..."
./"$EXECUTABLE"
