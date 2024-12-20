```markdown
# EasyOne:A 404 Error Vulnerability Discovered by me  ( Scanner )

**EasyOne** is a powerful, easy-to-use Python-based tool designed to scan for sensitive information exposure via 404 error from the developers. This tool helps identify potential vulnerabilities by analyzing the response of non-existent pages for sensitive keywords.

---

## 🚀 Features

- **Scan Single or Multiple URLs**:
  - Quickly scan a single URL for vulnerabilities.
  - Bulk scan multiple URLs from a file.

- **Keyword Matching**:
  - Detects sensitive keywords like `DB_USERNAME`, `DB_PASSWORD`, `APP_KEY`, and more.

- **Proxy Support**:
  - Specify an HTTP or HTTPS proxy for the requests.

- **Output Saving**:
  - Save the scan results to a file for further analysis.

- **Simple and Intuitive**:
  - Easy-to-use command-line interface (CLI).

---

## 📂 Repository Link

**GitHub Repository**: [https://github.com/shaheen101sec/EasyOne.git](https://github.com/shaheen101sec/EasyOne.git)

---

## 🛠️ Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/shaheen101sec/EasyOne.git
   cd EasyOne
   ```

2. **Install Dependencies**:
   Ensure you have Python 3.x installed. Then, install the required packages:
   ```bash
   pip install -r requirements.txt
   ```

---

## 🖥️ Usage

### Command Syntax
```bash
python3 tool.py [OPTIONS]
```

### Options:
| Option               | Description                                                    |
|----------------------|----------------------------------------------------------------|
| `-u, --url <URL>`    | Scan a single URL for vulnerabilities.                         |
| `-U, --urls <file>`  | Scan multiple URLs from a file (one URL per line).             |
| `-o, --output <file>`| Save results to the specified file.                            |
| `-p, --proxy <proxy>`| Use an HTTP/HTTPS proxy (e.g., `http://127.0.0.1:8080`).       |
| `-h, --help`         | Display the help message and usage information.               |

---

### Examples

#### Scan a Single URL
```bash
python3 tool.py -u https://example.com
```

#### Scan Multiple URLs from a File
```bash
python3 tool.py -U urls.txt
```

#### Save Scan Results to a File
```bash
python3 tool.py -U urls.txt -o results.txt
```

#### Use a Proxy for Scanning
```bash
python3 tool.py -u https://example.com -p http://127.0.0.1:8080
```

---

## 🛡️ Keywords Searched

The tool searches for the following sensitive keywords in the response from the server:
- `DB_USERNAME`
- `DB_PASSWORD`
- `APP_KEY`
- `APP_ENV`
- `NotFoundHttpException`
- `HTTP_HOST`
- `HTTP_AUTHORIZATION`
- `SSL_TLS_SNI`
- `HTTP_ACCEPT_ENCODING`
- `PATH`
- `HTTP_USER_AGENT`
- `Environment & details`
- `Symfony\Component`
- `ErrorException`

---

---

## 🐛 Issues

If you encounter any issues or have feature requests, please open an [issue](https://github.com/shaheen101sec/EasyOne/issues) in the repository.

---

## 💡 Acknowledgments

- Developed by [shaheen101sec](https://github.com/shaheen101sec).
- Inspired by the need for effective and efficient vulnerability scanners.
```

---
