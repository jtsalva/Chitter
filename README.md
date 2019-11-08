# Chitter

## Setup
1. Setup two Firebase projects, one for prod and one for testing, take note of their ids
2. Create and download credentials for accessing both and place in root of this project
3. Create `config.json` with contents like this:
```cassandraql
{
  "prod_credentials": "chitter-credentials.json",
  "test_credentials": "chitter-test-credentials.json",
  "prod_project_id": "chitter-prod-id",
  "test_project_id": "chitter-test-id"
}
```
4. And yeh sorry you gonna have to replace all occurences of config path if you wanna run this