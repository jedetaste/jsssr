## jsssr aka JSS Script Runner

Install jsssr:
```
/bin/rm -f "/usr/local/bin/jsssr" && /usr/bin/curl -sfko "/usr/local/bin/jsssr" "https://raw.githubusercontent.com/jedetaste/jsssr/master/bin/jsssr" && /bin/chmod +x "/usr/local/bin/jsssr"
```


--

Update index:
```
$ cd jsssr/
$ rm -f index && rm -f Library/.DS_Store && ls -A Library/ >> index
```
