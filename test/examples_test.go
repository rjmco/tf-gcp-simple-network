// This package tests the tf-gcp-simple-network examples.
// All tests rely on TF_VAR_project_id being set on the environment.
package test

import (
	"crypto/rand"
	"encoding/hex"
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

const (
	exampleSubnetCidr = "192.168.57.0/24"
	exampleRegion     = "us-east1"
)

// Test network deployment with default values.
func TestDefaultsExample(t *testing.T) {
	// signal that this test should be run in parallel with other parallel tests
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformBinary: "terragrunt",           // required when using Tg* methods.
		TerraformDir:    "../examples/defaults", // pass the example's base directory as an option
	}

	// make sure the infrastructure is destroyed in the end by terragrunt
	defer terraform.TgDestroyAll(t, terraformOptions)

	// use terragrunt to deploy the example with no custom variables
	terraform.TgApplyAll(t, terraformOptions)
}

func TestCustomizedExampleWithGoodInputs(t *testing.T) {
	// signal that this test should be run in parallel with other parallel tests
	t.Parallel()

	randomBytes := make([]byte, 2)
	if _, err := rand.Read(randomBytes); err != nil {
		fmt.Println("error:", err)
	}

	// generate a valid 4 character GCP resource name suffix
	suffix := hex.EncodeToString(randomBytes)

	// Set terragrunt options, including customized variables
	terraformOptions := &terraform.Options{
		TerraformBinary: "terragrunt",             // required when using Tg* methods.
		TerraformDir:    "../examples/customized", // pass the example's base directory as an option

		Vars: map[string]interface{}{
			"nat_router_name":          fmt.Sprintf("nat-router-%s", suffix),
			"network_name":             fmt.Sprintf("network-%s", suffix),
			"region":                   exampleRegion,
			"subnetwork_ip_cidr_range": exampleSubnetCidr,
			"subnetwork_name":          fmt.Sprintf("subnet-%s", suffix),
		},
	}

	// make sure the infrastructure is destroyed in the end by terragrunt
	defer terraform.TgDestroyAll(t, terraformOptions)

	// use terragrunt to deploy the example with no custom variables
	terraform.TgApplyAll(t, terraformOptions)
}
