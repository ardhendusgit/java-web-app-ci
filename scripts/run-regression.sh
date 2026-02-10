#!/bin/bash
echo "Starting regression tests..."

# Example test runner - replace with your framework
# mvn verify -P regression
mvn test -Dtest.group.name=smoke

echo "Regression tests completed."
