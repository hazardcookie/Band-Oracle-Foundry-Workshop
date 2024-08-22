import sys

def decode_prices(hex_data):
    # Remove the "0x" prefix if present
    if hex_data.startswith("0x"):
        hex_data = hex_data[2:]

    # Decode the prices
    prices = []
    for i in range(0, len(hex_data), 64):
        price_hex = hex_data[i:i + 64]
        if len(price_hex) == 64:
            price_int = int(price_hex, 16)
            if price_int > 10**15:  # Adjusted threshold to capture potentially valid values
                prices.append(price_int)

    return prices

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python decode_prices.py <hex_data>")
        sys.exit(1)

    hex_data = sys.argv[1]
    prices = decode_prices(hex_data)

    print("Decoded Prices:", prices)

