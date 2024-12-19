### README.md

```markdown
# shaheen101sec Advanced Vulnerability Scanner

A powerful and efficient Bash-based vulnerability scanner designed for ethical hackers and penetration testers. This tool helps in identifying common misconfigurations and exposed sensitive information in web applications. It is lightweight, easy to use, and provides results directly on the screen as well as in a file for post-analysis.

---

## Features
- **Single URL Scanning**: Analyze individual URLs for vulnerabilities.
- **Batch URL Scanning**: Scan multiple URLs from a file.
- **Proxy Support**: Use HTTP proxies for scans.
- **Customizable Threads**: Control the number of concurrent scans for faster results.
- **Detailed Reporting**: Save the scan results to a specified file.
- **Keyword-Based Vulnerability Detection**: Searches for sensitive information like database credentials, environment keys, and stack traces.

---

## Prerequisites
- **Bash**: Ensure Bash is installed and set as the default shell.
- **cURL**: Required for making HTTP requests.
- **Linux/MacOS**: Compatible with Unix-based operating systems.

---

## Installation
Clone the repository and navigate to the script directory:
```bash
git clone https://github.com/shaheen101sec/EasyOne.git
cd vuln-scanner
```

Make the script executable:
```bash
chmod +x tool.sh
```

---

## Usage
Run the script with various options as described below:

### Command-Line Options
| Option                | Description                                                      |
|-----------------------|------------------------------------------------------------------|
| `-u, --url <URL>`     | Scan a single URL for vulnerabilities.                          |
| `-U, --urls <file>`   | Scan multiple URLs listed in a file (one URL per line).          |
| `-o, --output <file>` | Specify the file to save scan results.                          |
| `-p, --proxy <proxy>` | Use an HTTP proxy (e.g., `http://127.0.0.1:8080`).               |
| `-t, --threads <num>` | Number of concurrent threads for batch scans (default: 5).       |
| `-h, --help`          | Display help information.                                       |

### Examples

#### Single URL Scan
```bash
./tool.sh -u https://example.com -o results.txt
```

#### Batch URL Scan
```bash
./tool.sh -U urls.txt -o results.txt
```

#### Using Proxy
```bash
./tool.sh -u https://example.com -p http://127.0.0.1:8080 -o results.txt
```

#### Multithreaded Scanning
```bash
./tool.sh -U urls.txt -t 10 -o results.txt
```

---

## Output
- **Screen Output**: Real-time progress and results are displayed in a color-coded format.
- **File Output**: Scan results are saved in the specified file (default: `results.txt`).

### Color Codes:
- **Green**: Vulnerability found.
- **Red**: Not vulnerable.
- **Yellow**: Full response snippet for detected vulnerabilities.
- **Blue**: General scan status messages.

---

## How It Works
1. Fetches the HTTP response for the specified URL(s) using `curl`.
2. Searches for sensitive keywords like `DB_USERNAME`, `DB_PASSWORD`, `APP_KEY`, and stack traces in the response.
3. Identifies potential vulnerabilities based on the presence of these keywords.
4. Outputs results to both the screen and a file for further analysis.

---

## Disclaimer
This tool is designed for **ethical hacking** and **educational purposes** only. Use it exclusively on systems you own or have explicit permission to test. The authors are not responsible for any misuse.

---

## Contributing
We welcome contributions! Please fork the repository, make your changes, and submit a pull request. Ensure your changes follow the best coding practices.

---

## Authors
Developed with ❤️ by [shaheen101sec](https://github.com/shaheen101sec)
```
