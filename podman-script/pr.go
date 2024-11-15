package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
	"gopkg.in/yaml.v2"
	"github.com/jessevdk/go-flags"
	"os/exec"
)

// Configuration struct to hold the values from the YAML
type Config struct {
	LocalPath       string `yaml:"local_path"`
	ContainerVolume string `yaml:"container_volume"`
	YamlFile        string `yaml:"yaml_file"`
	RegistryImage   string `yaml:"registry_image"`
}

var configFile = "/Users/geoagriogiannis/Documents/scripts/pr.yaml"

// Options for command-line arguments
type Options struct {
	LocalPath       string `short:"l" long:"local_path" description:"Local directory path"`
	ContainerVolume string `short:"v" long:"container_volume" description:"Container volume path"`
	YamlFile        string `short:"y" long:"yaml_file" description:"Path to the YAML definition file"`
	RegistryImage   string `short:"r" long:"registry" description:"Registry image (optional)"`
	Help            bool   `short:"h" long:"help" description:"Show this help message"`
}

// Function to print the usage information
func printUsage() {
	fmt.Println("Usage: pr.go [options]")
	fmt.Println("\nOptions:")
	fmt.Println("  -l, --local_path PATH           Local directory path")
	fmt.Println("  -v, --container_volume PATH     Container volume path")
	fmt.Println("  -y, --yaml_file PATH            Path to the YAML definition file")
	fmt.Println("  -r, --registry IMAGE            Registry image (optional)")
	fmt.Println("  -h, --help                      Show this help message")
	fmt.Printf("\nThe default values are loaded from the YAML file located at:\n%s\n", configFile)
}

func main() {
	// Parse command-line options
	var opts Options
	_, err := flags.Parse(&opts)
	if err != nil {
		fmt.Println("Error parsing options:", err)
		return
	}

	// Check if --help is requested, if yes, print usage and exit
	if opts.Help {
		printUsage()
		return
	}

	// Load the configuration file
	configFilePath := configFile
	config := Config{}
	data, err := os.ReadFile(configFilePath)
	if err != nil {
		fmt.Println("Error loading YAML configuration file:", err)
		return
	}

	// Unmarshal YAML into config struct
	err = yaml.Unmarshal(data, &config)
	if err != nil {
		fmt.Println("Error unmarshaling YAML:", err)
		return
	}

	// Set the values from command-line options if provided, otherwise use the config values
	if opts.LocalPath == "" {
		opts.LocalPath = config.LocalPath
	}
	if opts.ContainerVolume == "" {
		opts.ContainerVolume = config.ContainerVolume
	}
	if opts.YamlFile == "" {
		opts.YamlFile = config.YamlFile
	}
	if opts.RegistryImage == "" {
		opts.RegistryImage = config.RegistryImage
	}

	// Validate inputs
	if opts.LocalPath == "" {
		fmt.Println("Error: Local path is required.")
		return
	}
	if opts.ContainerVolume == "" {
		fmt.Println("Error: Container volume is required.")
		return
	}
	if opts.YamlFile == "" {
		fmt.Println("Error: YAML file is required.")
		return
	}
	if opts.RegistryImage == "" {
		fmt.Println("Error: Registry image is required.")
		return
	}

	// Construct the podman command
	command := fmt.Sprintf("podman run --rm -it --privileged -v %s:%s %s build --definition-file %s", opts.LocalPath, opts.ContainerVolume, opts.RegistryImage, opts.YamlFile)

	// Ask for confirmation to run the command
	fmt.Println("\nThe following command will be executed:")
	fmt.Println(command)

	fmt.Print("Execute this command? (yes/no): ")
	reader := bufio.NewReader(os.Stdin)
	confirmation, _ := reader.ReadString('\n')
	confirmation = strings.TrimSpace(confirmation)
	if confirmation == "" {
		confirmation = "yes"
	}

	// If the user confirms, run the command
	if confirmation == "yes" {
		// Run the podman command
		err := runCommand(command)
		if err != nil {
			fmt.Println("Error executing the command:", err)
		}
	} else {
		fmt.Println("Command execution aborted.")
	}
}

// Function to actually execute the command
func runCommand(command string) error {
	cmd := exec.Command("bash", "-c", command)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	return cmd.Run()
}