// This package tests the tf-gcp-simple-network simple_example example.
// All tests rely on TF_VAR_project_id existing on the environment.
package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

// Test a simple_example network deployment.
func TestSimpleExample(t *testing.T) {
	// signal that this test should be run in parallel with other parallel tests
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformBinary: "terragrunt",                 // required when using Tg* methods.
		TerraformDir:    "../examples/simple_example", // pass the example's base directory as an option
	}

	// make sure the infrastructure is destroyed in the end by terragrunt
	defer terraform.TgDestroyAll(t, terraformOptions)

	// use terragrunt to deploy the example with no custom variables
	terraform.TgApplyAll(t, terraformOptions)
}
