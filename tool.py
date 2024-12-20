#!/usr/bin/env python3

import requests
import argparse
import sys
from pathlib import Path

# Colors for beautification
RED = '\033[0;31m'
GREEN = '\033[0;32m'
YELLOW = '\033[1;33m'
CYAN = '\033[0;36m'
BLUE = '\033[1;34m'
PURPLE = '\033[0;35m'
BOLD = '\033[1m'
NC = '\033[0m'  # No Color

# Keywords to check for in the response
KEYWORDS = [
    "DB_USERNAME", "DB_PASSWORD", "APP_KEY", "APP_ENV",
    "NotFoundHttpException", "HTTP_HOST", "HTTP_AUTHORIZATION",
    "SSL_TLS_SNI", "HTTP_ACCEPT_ENCODING", "PATH", "HTTP_USER_AGENT",
    "Environment & details", "Symfony\\Component", "ErrorException"
]

# Display the banner
def banner():
    print(f"{CYAN}========================================")
    print(f"{BOLD}{PURPLE}shaheen101sec 404 Error Vulnerability Scanner{NC}")
    print(f"{CYAN}========================================{NC}")

# Scan a single URL
def scan_url(url, proxy=None):
    print(f"{CYAN}Scanning start on {url}{NC}")
    try:
        proxies = {"http": proxy, "https": proxy} if proxy else None
        response = requests.get(f"{url}/iam_not_a_file", proxies=proxies, timeout=10)

        # Check for keywords in the response
        for keyword in KEYWORDS:
            if keyword in response.text:
                print(f"{GREEN}[VULNERABLE]{NC} '{keyword}' found in response from {url}")
                print(f"{YELLOW}[+] Full response snippet from {url}:{NC}")
                print(response.text[:500])  # Show first 500 characters
                return

        print(f"{RED}[NOT VULNERABLE]{NC} No sensitive information found at {url}")
    except requests.RequestException as e:
        print(f"{RED}[ERROR]{NC} Failed to fetch URL: {url}, {e}")

# Scan multiple URLs from a file
def scan_urls_from_file(file_path, proxy=None):
    if not Path(file_path).is_file():
        print(f"{RED}[ERROR]{NC} URL file not found: {file_path}")
        sys.exit(1)

    print(f"{CYAN}Scanning URLs from {file_path}{NC}")
    with open(file_path, 'r') as file:
        for line in file:
            url = line.strip()
            if url:
                scan_url(url, proxy)

# Main function
def main():
    parser = argparse.ArgumentParser(description="shaheen101sec 404 Error Vulnerability Scanner")
    parser.add_argument("-u", "--url", help="Scan a single URL for the vulnerability.")
    parser.add_argument("-U", "--urls", help="Scan multiple URLs from a file (one per line).")
    parser.add_argument("-o", "--output", help="Save results to the specified file.")
    parser.add_argument("-p", "--proxy", help="Use an HTTP proxy (e.g., http://127.0.0.1:8080).")
    args = parser.parse_args()

    banner()

    if not args.url and not args.urls:
        print(f"{RED}[ERROR]{NC} No URL or file provided.")
        parser.print_help()
        sys.exit(1)

    # Redirect output if specified
    if args.output:
        sys.stdout = open(args.output, 'w')

    # Scan a single URL
    if args.url:
        scan_url(args.url, args.proxy)

    # Scan multiple URLs from a file
    if args.urls:
        scan_urls_from_file(args.urls, args.proxy)

    if args.output:
        print(f"{PURPLE}[*] Results saved to: {args.output}{NC}")

if __name__ == "__main__":
    main()
