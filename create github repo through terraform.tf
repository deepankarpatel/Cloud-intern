terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

# Configure the GitHub Provider
provider "github" {
    token = "Your token number"
}

resource "github_repository" "example" {
  name        = "example-terraform"
  description = "created through terraform"

  visibility = "private"

}

#this will create new repo in terraform