## jsssr

### Install jsssr
```
rm -f "/usr/local/bin/jsssr" && curl -so "/usr/local/bin/jsssr" "https://raw.githubusercontent.com/jedetaste/jsssr/master/bin/jsssr" && chmod +x "/usr/local/bin/jsssr"
```

### Update index
```
$ cd jsssr/
$ rm -f index && rm -f Library/.DS_Store && ls -A Library/ >> index
```
