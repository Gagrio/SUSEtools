# Podman Command Automation Scripts
##### For easier execution of eib.

This repository contains two scripts that help automate the execution of a `podman` command with configurable options such as local paths, container volume, and YAML definition files. Both the Ruby and Go scripts perform the same function but are written in different programming languages.

## Ruby Script

### Usage

```bash
Usage: pr.rb [options]

Options:
  -l, --local_path PATH           Local directory path
  -v, --container_volume PATH     Container volume path
  -y, --yaml_file PATH            Path to the YAML definition file
  -r, --registry IMAGE            Registry image (optional)
  -h, --help                      Show this help message

The default values are loaded from the YAML file located at:
~/Documents/scripts/pr.yaml
```

### Requirements

- Ruby 2.0 or higher
- `podman` installed

### Configuration File

The script loads default values from a YAML configuration file. The default location of the YAML file is `~/Documents/scripts/pr.yaml`. This configuration file can be used to set the following default parameters:

- `local_path`: Local directory path
- `container_volume`: Container volume path
- `yaml_file`: Path to the YAML file
- `registry_image`: Registry image (optional)

### Execution

To execute the script:

1. Edit the `pr.yaml` file to include your default values.
2. Use the command line to specify overrides or rely on the YAML file.

Example usage:

```bash
ruby pr.rb --local_path "/path/to/local" --container_volume "/path/to/container" --yaml_file "/path/to/yaml/file"
```

The script will print the `podman` command it is about to execute and ask for confirmation. If you press enter without typing anything, it will default to "yes".

### Error Handling

The script will ensure that the following parameters are provided:

- Local path
- Container volume path
- YAML file path
- Registry image

If any of these are missing, the script will exit with an error message.

---

## Go Script

### Usage

```bash
Usage: pr.go [options]

Options:
  -l, --local_path PATH           Local directory path
  -v, --container_volume PATH     Container volume path
  -y, --yaml_file PATH            Path to the YAML definition file
  -r, --registry IMAGE            Registry image (optional)
  -h, --help                      Show this help message

The default values are loaded from the YAML file located at:
~/Documents/scripts/pr.yaml
```

### Requirements

- Go 1.16 or higher
- `podman` installed

### Configuration File

The script loads default values from a YAML configuration file. The default location of the YAML file is `~/Documents/scripts/pr.yaml`. This configuration file can be used to set the following default parameters:

- `local_path`: Local directory path
- `container_volume`: Container volume path
- `yaml_file`: Path to the YAML file
- `registry_image`: Registry image (optional)

### Execution

To execute the script:

1. Edit the `pr.yaml` file to include your default values.
2. Use the command line to specify overrides or rely on the YAML file.

Example usage:

```bash
go run pr.go --local_path "/path/to/local" --container_volume "/path/to/container" --yaml_file "/path/to/yaml/file"
```

The script will print the `podman` command it is about to execute and ask for confirmation. If you press enter without typing anything, it will default to "yes".

### Error Handling

The script will ensure that the following parameters are provided:

- Local path
- Container volume path
- YAML file path
- Registry image

If any of these are missing, the script will exit with an error message.
