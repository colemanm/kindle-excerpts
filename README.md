## Kindle Excerpts

Library of clipped highlights from Kindle books, and the tools to export them from your Kindle account.

### Installation

Install with bundler:

```
bundle install --path .bundle
```

This primarily relies on the [kindle-highlights](https://github.com/speric/kindle-highlights) gem, which is basically a scraper that requires your username and password to access the highlight data. The `export` and `excerpt` tools wrap this script and therefore require your creds. You can store them in a local dotfile to keep them safe and out of the code, if you want. The scripts here will attempt to autoload from a yaml file at `~/.kindle`. So do run this and edit the file to create your own creds:

```shell
cp kindle.yml.default ~/.kindle
```

### Usage

Running `export.rb` with your Kindle account credentials will write a `books.csv` file to the same directory. You can use this to see a list of all the books in your Kindle account, with ASINs ([Amazon Standard Identification Number](https://en.wikipedia.org/wiki/Amazon_Standard_Identification_Number)) to use for lookups.

```
export.rb
```

Use the `excerpts.rb` script to pass in a book ID using the ASIN number, and export the resulting clips to a file in JSON (with full highlight metadata), Markdown, or both.

```shell
./excerpts.rb -a B005H0O8KQ -f books/annals-of-the-former-world/annals-of-the-former-world -m -j
```
