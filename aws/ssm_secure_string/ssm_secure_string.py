import boto3
import botocore.exceptions
import os

def manage_ssm_parameters(parameter_mappings, kms_key_id, region='us-east-1'):
    """
    Create or update AWS SSM Parameter Store secure strings with KMS encryption.
    
    Args:
        parameter_mappings (dict): Dictionary mapping SSM parameter names to environment variable names
        kms_key_id (str): KMS Key ID for encryption
        region (str): AWS region
    Returns:
        dict: Status of operations
    """
    # Initialize SSM client
    ssm_client = boto3.client('ssm', region_name=region)
    results = {}
    
    for param_name, env_var_name in parameter_mappings.items():
        # Get value from environment variable
        param_value = os.getenv(env_var_name)
        if not param_value:
            results[param_name] = {
                'status': 'error',
                'error': f"Environment variable {env_var_name} not found"
            }
            continue
            
        try:
            # Create or update parameter
            response = ssm_client.put_parameter(
                Name=param_name,
                Value=param_value,
                Type='SecureString',
                KeyId=kms_key_id,
                Overwrite=True
            )
            results[param_name] = {
                'status': 'success',
                'version': response['Version']
            }
        except botocore.exceptions.ClientError as e:
            results[param_name] = {
                'status': 'error',
                'error': str(e)
            }
    
    return results

def main():
    # Define mapping of SSM parameter names to environment variable names
    parameter_mappings = {
        '/app/config/api_key': 'API_KEY',
        '/app/config/db_password': 'DB_PASSWORD',
        '/app/config/secret_token': 'SECRET_TOKEN'
    }
    
    # KMS Key ID (replace with your KMS key ID)
    kms_key_id = 'alias/my-key'  # Example: 'alias/my-key' or 'arn:aws:kms:us-east-1:123456789012:key/1234abcd-12ab-34cd-56ef-1234567890ab'
    
    # AWS region
    region = 'us-east-1'
    
    # Execute parameter management
    results = manage_ssm_parameters(parameter_mappings, kms_key_id, region)
    
    # Print results
    for param_name, result in results.items():
        if result['status'] == 'success':
            print(f"Parameter {param_name} processed successfully, version: {result['version']}")
        else:
            print(f"Error with {param_name}: {result['error']}")

if __name__ == '__main__':
    main()