# GitHub Actions for dbt Fusion Migration

This directory contains GitHub Actions workflows to help with the dbt Core to Fusion migration process.

## Workflows

### `dbt-fusion-compile.yml`

This workflow automatically downloads dbt Fusion and runs `dbtf compile` to validate that your dbt project is compatible with Fusion.

**Triggers:**
- Push to `main` or `cleanup-fusion` branches
- Pull requests to `main` or `cleanup-fusion` branches  
- Manual workflow dispatch

**What it does:**
1. Downloads and installs the latest dbt Fusion CLI
2. Creates a `profiles.yml` file from environment variables
3. Installs dbt packages (`dbtf deps`)
4. Runs `dbtf compile` to check for compilation errors
5. Runs `dbtf parse` for additional validation
6. Uploads compilation artifacts for review
7. Comments on PRs with compilation results

## Required GitHub Secrets

To use this workflow, you need to configure the following secrets in your GitHub repository:

### Snowflake Connection Secrets

Go to **Settings > Secrets and variables > Actions** and add these repository secrets:

| Secret Name | Description | Example Value |
|-------------|-------------|---------------|
| `SNOWFLAKE_ACCOUNT` | Your Snowflake account identifier | `abc12345.us-east-1` |
| `SNOWFLAKE_USER` | Snowflake username | `your_username` |
| `SNOWFLAKE_PASSWORD` | Snowflake password | `your_password` |
| `SNOWFLAKE_ROLE` | Snowflake role to use | `TRANSFORMER` |
| `SNOWFLAKE_DATABASE` | Target database | `DBT_FUSION_TRAINING` |
| `SNOWFLAKE_WAREHOUSE` | Snowflake warehouse | `COMPUTE_WH` |
| `SNOWFLAKE_SCHEMA` | Target schema (will be prefixed with username) | `dbt_fusion_migration` |

### Setting Up Secrets

1. Navigate to your repository on GitHub
2. Click **Settings** (in the repository menu)
3. Click **Secrets and variables** in the left sidebar
4. Click **Actions**
5. Click **New repository secret**
6. Add each secret from the table above

## Usage

### Automatic Runs
The workflow will automatically run when you:
- Push code to the `main` or `cleanup-fusion` branches
- Open a pull request targeting these branches

### Manual Runs
You can also trigger the workflow manually:
1. Go to the **Actions** tab in your repository
2. Select **dbt Fusion Compile Check**
3. Click **Run workflow**
4. Choose your branch and click **Run workflow**

### Reviewing Results

**Successful Compilation:**
- ✅ Green checkmark in the Actions tab
- PR comment confirming successful compilation
- Compilation artifacts available for download

**Failed Compilation:**
- ❌ Red X in the Actions tab  
- PR comment indicating failure
- Detailed logs available in the workflow run
- Compilation artifacts with error details

### Troubleshooting

**Common Issues:**

1. **Missing Secrets**: Ensure all Snowflake secrets are configured correctly
2. **Permission Errors**: Verify your Snowflake user has the necessary permissions
3. **Network Issues**: Check if your Snowflake account is accessible from GitHub Actions
4. **dbt Package Issues**: Review the `dbtf deps` step for package installation errors

**Debugging Steps:**

1. Check the workflow logs in the Actions tab
2. Download the `dbt-fusion-artifacts` to review detailed error messages
3. Verify your `profiles.yml` configuration matches your local setup
4. Test the same commands locally with dbt Fusion

## Benefits for Migration Training

This workflow provides several benefits for the migration course:

- **Immediate Feedback**: Students get instant validation when they push changes
- **Consistent Environment**: Everyone uses the same dbt Fusion version
- **Artifact Preservation**: Compilation results are saved for later analysis
- **Progress Tracking**: Clear indication of migration progress through PR comments
- **Best Practices**: Demonstrates CI/CD patterns for dbt projects

## Customization

You can customize this workflow by:

- Modifying the trigger branches in the `on` section
- Adding additional dbt commands (e.g., `dbtf test`, `dbtf run`)
- Changing the artifact retention period
- Adding Slack notifications or other integrations
- Configuring different Snowflake environments for different branches
