#!/bin/bash

# shaheen101sec Advanced Vulnerability Scanner
# Author: HackerGPT

# Colors for beautification
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BLUE='\033[1;34m'
PURPLE='\033[0;35m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Function to display the banner
banner() {
    echo -e "${CYAN}========================================"
    echo -e "${BOLD}${PURPLE}shaheen101sec Advanced Vulnerability Scanner${NC}"
    echo -e "${CYAN}========================================${NC}"
}

# Function to display help
usage() {
    banner
    echo -e "${BLUE}Usage:${NC} $0 [OPTIONS]"
    echo -e "Options:"
    echo -e "  -u, --url <URL>         Scan a single URL for the vulnerability."
    echo -e "  -U, --urls <file>       Scan multiple URLs from a file (one per line)."
    echo -e "  -o, --output <file>     Save results to the specified file."
    echo -e "  -p, --proxy <proxy>     Use an HTTP proxy (e.g., http://127.0.0.1:8080)."
    echo -e "  -t, --threads <num>     Number of threads for faster scanning (default: 5)."
    echo -e "  -h, --help              Show this help message and exit."
}

# Function to test a single URL
scan_url() {
    local url="$1"
    local proxy="$2"

    # Display scanning status
    echo -e "${BLUE}[*] Scanning:${NC} $url"

    # Use proxy if provided
    local curl_cmd="curl -s -X GET"
    [[ -n "$proxy" ]] && curl_cmd+=" -x $proxy"

    # Fetch HTTP response headers and first lines of the body
    local response=$($curl_cmd "$url/iam_not_a_file" | head -n 50)

    # Keywords to check for in the response
    local keywords=(
        "DB_USERNAME" "DB_PASSWORD" "APP_KEY" "APP_ENV"
        "NotFoundHttpException" "HTTP_HOST"
        "Environment & details" "Symfony\\Component" "ErrorException"
    )

    # Loop through keywords to check for vulnerability
    local vulnerable=false
    for keyword in "${keywords[@]}"; do
        if echo "$response" | grep -q "$keyword"; then
            echo -e "${GREEN}[VULNERABLE]${NC} '$keyword' found in response from $url"
            vulnerable=true
            break
        fi
    done

    # Display the response snippet if vulnerable
    if [[ "$vulnerable" == true ]]; then
        echo -e "${YELLOW}[+] Full response snippet from $url:${NC}"
        echo -e "$response"
        return 0
    else
        echo -e "${RED}[NOT VULNERABLE]${NC} No sensitive information found at $url"
        return 1
    fi
}

# Main script logic
main() {
    if [[ "$#" -eq 0 ]]; then
        echo -e "${RED}[ERROR] No arguments provided.${NC}"
        echo -e "Use the ${YELLOW}-h${NC} option for usage information."
        exit 1
    fi

    local urls_file=""
    local output_file=""
    local single_url=""
    local proxy=""
    local threads=5

    while [[ "$#" -gt 0 ]]; do
        case $1 in
            -u|--url)
                single_url="$2"
                shift 2
                ;;
            -U|--urls)
                urls_file="$2"
                shift 2
                ;;
            -o|--output)
                output_file="$2"
                shift 2
                ;;
            -p|--proxy)
                proxy="$2"
                shift 2
                ;;
            -t|--threads)
                threads="$2"
                shift 2
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *)
                echo -e "${RED}Unknown option: $1${NC}"
                usage
                exit 1
                ;;
        esac
    done

    # Display banner
    banner

    # Scan a single URL
    if [[ -n "$single_url" ]]; then
        echo -e "${CYAN}[+] Starting single URL scan...${NC}"
        if scan_url "$single_url" "$proxy" && [[ -n "$output_file" ]]; then
            echo "$single_url: VULNERABLE" >> "$output_file"
        fi
    fi

    # Scan multiple URLs from a file
    if [[ -n "$urls_file" ]]; then
        if [[ ! -f "$urls_file" ]]; then
            echo -e "${RED}[ERROR] URL file not found: $urls_file${NC}"
            exit 1
        fi

        echo -e "${CYAN}[+] Starting scan for URLs in file: $urls_file${NC}"

        # Multithreaded scanning logic
        cat "$urls_file" | xargs -n 1 -P "$threads" -I {} bash -c "scan_url '{}' '$proxy' && echo '{}: VULNERABLE' >> $output_file"
    fi

    if [[ -n "$output_file" ]]; then
        echo -e "${PURPLE}[*] Results saved to: $output_file${NC}"
    fi
}

# Start the script
main "$@"
