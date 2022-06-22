# Parse Dashed Args [ PDA]

### Installation
Just copy the file `pda` and put it anywhere in your `$PATH`

For example
```bash
$ mdkir ~/local/bin
$ cp pda ~/local/bin
$ export PATH=$PATH:~/local/bin
```

### Basic Usage
You can source `pda` library and the use `pda` api anywhere from your bash script
```bash
$ source ~/local/bin/pda
$ pda --flag --abc 123 --def 456
$ echo $abc
123
$ echo $def
456
```

### Debugging
Set the env var `PDA_DEBUG` to see what `pda` does
```bash
$ PDA_DEBUG=1 pda --abc 123 --def 456
PDA: Parsing dashed args: --abc 123 --def 456
PDA: Setting abc to '123'
PDA: Setting def to '456'
```

### Flags
If the value for a dashed parameter is not specified, it would be assumed as a flag and the valued would be set to 1
```bash
$ PDA_DEBUG=1 pda --flag --abc 123 --def 456
PDA: Parsing dashed args: --flag --abc 123 --def 456
PDA: Setting flag to '1'
PDA: Setting abc to '123'
PDA: Setting def to '456'
```

### Errors
`pda` exits with error code 1 when something fails
```bash
$ pda --flag --abc 123 def 456 || echo "Failed"
PDA: Error parsing arg: 'def'
Failed
```
```bash
$ pda --flag --abc 123 --def --456 || die "Parsing cmd line args failed"
PDA: Error parsing arg: '--456'

Parsing cmd line args failed
```

### Usage
On invoking `pda` api without any args would make it print the following standard `usage` string
```bash
$ source pda
$ pda
Missing args

Usage:
    bash <dashed args>
```

To customize the `usage` string, define your own `usage` function
```bash
$ usage() { echo -e "  my_script --abc <abc> --def <def>"; }
$ source pda
$ pda|| die
Missing args

Usage:
  my_script --abc <abc> --def <def>
```

### Tests
There are some simple tests under the `tests` subdirectory. To run them,
make sure you have [BATS](https://github.com/bats-core/bats-core) and its
helper library [bats-assert](https://github.com/bats-core/bats-assert) installed

```Running the tests
$ bats test_pda.bats
test_pda.bats
 ✓ pda with int args
 ✓ pda with str args
 ✓ pda with str arg with spaces
 ✓ pda with bool flag
 ✓ pda error
 ✓ pda debugs
 ✓ pda debugs with error

7 tests, 0 failures
```

### TODO
* Detect missing vars
* Type validation
