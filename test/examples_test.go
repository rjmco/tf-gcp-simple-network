// This package tests the tf-gcp-simple-network examples.
// All tests rely on TF_VAR_project_id being set on the environment.
package test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/gcp"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

const (
	projectIDEnvVar = "TF_VAR_project_id"
	subnetCidr      = "192.168.57.0/24"
)

// getBadComputeResourceNames returns a slice of strings with bad compute resource names.
func getBadComputeResourceNames() []string {
	return []string{
		"",     // Name is empty
		"1a",   // Name start character doesn't match [a-z]
		"a_1",  // Name contains a symbol other than hyphen
		"abc-", // Name ends with hyphen
		"aBc",  // Name contains upper case characters
		"a23456789b123456789c123456789d123456789e123456789f123456789g1234", // Name exceeds length limit of 63 characters
	}
}

// getBadProjectIds returns a slice of strings with bad project IDs.
func getBadProjectIds() []string {
	return []string{
		"",                               // Name is empty
		"a",                              // Name shorter then 6 characters
		"abcde",                          // Name shorter then 6 characters
		"1abcde",                         // Name start character doesn't match [a-z]
		"abc_ef",                         // Name contains a symbol other than hyphen
		"abcde-",                         // Name ends with hyphen
		"abCdef",                         // Name contains upper case characters
		"a234567890b234567890c234567890", // Name exceeds length limit of 30 characters
	}
}

// getBadSubnetworkIPCidrRanges returns a slice of strings with bad CIDR ranges.
func getBadSubnetworkIPCidrRanges() []string {
	return []string{
		"",            // An empty string
		"0.0.0.0",     // An IP
		"0.0.0.0/33",  // An invalid bit mask
		"256.0.0.0/0", // An invalid prefix octet
	}
}

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

// Test network deployment with good customized values.
func TestCustomizedExampleWithGoodInputs(t *testing.T) {
	// signal that this test should be run in parallel with other parallel tests
	t.Parallel()

	// get the project ID from the TF_VAR_project_id environment variable
	p := os.Getenv(projectIDEnvVar)

	// generate good GCP resource names
	networkName := gcp.RandomValidGcpName()
	regionName := gcp.GetRandomRegion(t, p, nil, nil)
	routerName := gcp.RandomValidGcpName()
	subnetworkName := gcp.RandomValidGcpName()

	// set terragrunt options, including customized variables
	terraformOptions := &terraform.Options{
		TerraformBinary: "terragrunt",             // required when using Tg* methods.
		TerraformDir:    "../examples/customized", // pass the example's base directory as an option

		Vars: map[string]interface{}{
			"nat_router_name":          routerName,
			"network_name":             networkName,
			"region":                   regionName,
			"subnetwork_ip_cidr_range": subnetCidr,
			"subnetwork_name":          subnetworkName,
		},
	}

	// make sure the infrastructure is destroyed in the end by terragrunt
	defer terraform.TgDestroyAll(t, terraformOptions)

	// use terragrunt to deploy the example with no custom variables
	terraform.TgApplyAll(t, terraformOptions)
}

// Test deployment with customized bad input values fail.
func TestCustomizedExampleWithBadInputs(t *testing.T) {
	// signal that this test should be run in parallel with other parallel tests
	t.Parallel()

	// testBadVariableValues defines a re-usable variable value test function regardless of the key
	testBadVariableValues := func(t *testing.T, k string, values []string) {
		// set terraform options baseline
		terraformOptions := &terraform.Options{
			TerraformBinary: "terragrunt",             // required when using Tg* methods.
			TerraformDir:    "../examples/customized", // pass the example's base directory as an option
		}

		for _, v := range values {
			terraformOptions.Vars = map[string]interface{}{
				k: v,
			}

			// use terragrunt to plan the example with bad custom variable
			exitCode := terraform.TgPlanAllExitCode(t, terraformOptions)
			if exitCode != 1 {
				t.Fatalf("Expected `%v` == '%v' to raise a failure. Exit code: %v", k, v, exitCode)
			} else {
				t.Logf("`%v` == '%v' raised a failure as expected. Exit code: %v", k, v, exitCode)
			}
		}
	}

	// Test detection of bad nat_router_name, network_name and subnetwork_name values in sub-tests
	t.Run("nat_router_name", func(t *testing.T) {
		t.Parallel()
		testBadVariableValues(t, "nat_router_name", getBadComputeResourceNames())
	})
	t.Run("network_name", func(t *testing.T) {
		t.Parallel()
		testBadVariableValues(t, "network_name", getBadComputeResourceNames())
	})
	t.Run("project_id", func(t *testing.T) {
		t.Parallel()
		testBadVariableValues(t, "project_id", getBadProjectIds())
	})
	t.Run("region", func(t *testing.T) {
		t.Parallel()
		testBadVariableValues(t, "region", []string{random.UniqueId()})
	})
	t.Run("subnetwork_name", func(t *testing.T) {
		t.Parallel()
		testBadVariableValues(t, "subnetwork_name", getBadComputeResourceNames())
	})
	t.Run("subnetwork_ip_cidr_range", func(t *testing.T) {
		t.Parallel()
		testBadVariableValues(t, "subnetwork_ip_cidr_range", getBadSubnetworkIPCidrRanges())
	})
}
