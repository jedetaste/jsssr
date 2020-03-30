## jsssr

### Install jsssr
```shell
rm -f "/usr/local/bin/jsssr" && curl -s -L -o "/usr/local/bin/jsssr" "https://raw.githubusercontent.com/jedetaste/jsssr/master/bin/jsssr" && chmod +x "/usr/local/bin/jsssr"
```

### Update index
```shell
$ cd jsssr/
$ rm -f index && rm -f Library/.DS_Store && ls -A Library/ >> index
```
