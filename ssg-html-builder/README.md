# ssg-html-builder

Ata's Static Site Generator HTML Builder Github Action

This action builds HTML files from the PHP files in https://github.com/atas/ssg

Add this to your GitHub Actions Workflow

```
- name: Run Ata's SSG HTML Builder
  uses: atas/ssg-html-builder@2.1
  with:
    less_file_path: 'assets/styles/style.less'
```
