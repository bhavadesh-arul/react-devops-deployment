#!/bin/bash
set -e

echo "Building Docker image..."
docker build -t react-app-test .
echo "Docker image build completed."

