# Building

To build either add-on, go to the appropriate directory and execute this command:

```bash
./build.sh
```

# Releasing a new version

The Mozilla and OpenOffice.org add-ons are automatically versioned according to the latest annotated tag. To release a new version of either add-on, run:

```bash
git tag -a v9.8.7 -m '9.8.7'
./build.sh
```
