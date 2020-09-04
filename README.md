# chrome2org
Migrate bookmarks exported from chrome to orgmode

Convert a netscape bookmark file (format `<!DOCTYPE NETSCAPE-Bookmark-file-1>` as exported by chrome) to a .org file with the same hierarchy and org-formatted links.

Example of usage:
```
bash netscape2org.sh < bookmarks_9_4_20.html | tee -a bookmarks.org
```
