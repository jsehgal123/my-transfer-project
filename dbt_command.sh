#!/bin/bash

# Input arguments
#table_config="table_config.yml"
table_config=$1  # Path to the unified YAML file
env=$2        # Target environment (prod or preprod)

echo "Running DBT for environment: $env"

failed_result=0

# Function to parse YAML and extract environment configuration
parse_yaml() {
  python3 -c "
import yaml, sys
with open('$table_config', 'r') as f:
    config = yaml.safe_load(f)
env_config = config['environments']['$env']
for key, value in env_config.items():
    print(f\"{key}={value}\")
"
}

# Export environment variables
export_variables() {
  while IFS='=' read -r key value; do
    export "$key=$value"
  done < <(parse_yaml)
}

# Run dbt command
run_dbt_command() {
  export_variables
  dbt_cmd="dbt run --profiles-dir /data-domain-pipelines \
                    --project-dir /data-domain-pipelines/my_transfer/$env \
                    --target $env-ca"
  echo "Running: $dbt_cmd"

  # Execute the dbt command
  /bin/sh -c "$dbt_cmd"
  if [ $? -ne 0 ]; then
    failed_result=$((failed_result + 1))
  fi
}

# Main execution
run_dbt_command

if [ "$failed_result" -gt 0 ]; then
  echo "dbt command failed."
  exit 1
else
  echo "dbt command completed successfully!"
fi
