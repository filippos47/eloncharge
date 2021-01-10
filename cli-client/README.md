# CLI

## Installation

The below commands have been tested on Ubuntu LTS 18.04.

1. Install requirements

    ```bash
    $ sudo apt install python3 python3-pip
    $ pip3 install virtualenv
    ```

2. Create & activate virtual environment

    ```bash
    $ python3 -m venv .venv
    $ source .venv/bin/activate
    ```

3. Install requirements

    ```bash
    $ pip3 install requirements
    ```

4. Generate distribution package

    ```bash
    $ python3 setup.py sdist bdist_wheel
    ```

5. Install built distribution

    ```bash
    $ pip3 install dist/ev_group53-<version>-py3-none-any.whl
    ```

## Usage

Produced executable `ev_group53` can be called upon in the following fashion:

```bash
$ ev_group53 SCOPE --param1 value1 [--param2 value2 ...] --format fff --apikey kkk
```

Mandatory arguments:

- `--format {csv,json}`: Desired output format
- `--apikey <alphanumeric-string>`: API token

For a complete list of the available functionalities and their corresponding
parameters, refer to the executable's help scripts (starting from
`ev_group53 -h`)
