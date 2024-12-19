-- Load Data
inputData = LOAD '/root/Inputs' USING PigStorage('\t') AS (name:chararray, line:chararray);

-- Group by name
groupByName = GROUP inputData BY name;

-- Count the number of lines by each character
names = FOREACH groupByName GENERATE $0 as name, COUNT($1) as no_of_lines;
namesOrdered = ORDER names BY no_of_lines DESC;

-- Remove the outputs folder
rmf /root/PigProjectOutput;

-- Store result
STORE namesOrdered INTO '/root/PigProjectOutput' USING PigStorage('\t');
