terraform {
  backend "remote" {
    organization = "SomeSoftwareTeam"
    workspaces {
      name = "club-abode-appsync-graphql"
    }
  }
}

provider "aws" {
  profile    = "default"
  region     = "us-east-1"
  access_key = var.provider_access_key
  secret_key = var.provider_secret_key
}

provider "github" {
  token        = var.github_token
  organization = "SomeSoftwareTeam"
}