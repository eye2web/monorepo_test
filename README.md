# monorepo_test
monorepo_test

A test project to investigate the usage of `yarn workspaces` in mono-repositories.

Goals:
 - workspace independent versioning with semantic release
 - SonarQube projects per workspace
 
 To make the SonarQube action work you need to have the following environment variables set.
 
 - SONAR_TOKEN: Your SonarQube API token   
 - SONAR_HOST_URL: URL to your SonarQube instance   
 - SONAR_PROJECT_NAME: Name of the project, workspce names will be added to the name during analyses.   
 - SONAR_PROJECTKEY: The project key, the workspace name will be appended per workspace to identify the different projects   
 - SONAR_SOURCE_DIR: The source directory containing the package.json with the workspaces definition
 
 
 
