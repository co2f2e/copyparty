<h1 aligen="center">
  copyparty
</h1>

* Installation
```bash
bash <(curl -Ls https://raw.githubusercontent.com/co2f2e/copyparty/main/install.sh) 5800 username password
```

* Uninstallation
```bash
bash <(curl -Ls https://raw.githubusercontent.com/co2f2e/copyparty/main/uninstall.sh)
```

* Rule
  
| Path         | Anonymous user| Admin     |
|--------------|---------------|-----------|
| `/`          | ✔ 可访问      | ✔ 可访问  |
| `/public`    | ✔ 下载        | ✔ 管理    |
| `/private`   | ❌ 无权       | ✔ 全权    |
| `/inbox`     | ❌ 无权       | ✔ 只投    |
| `/sharex`    | ❌ 无权       | ✔ 全权    |


